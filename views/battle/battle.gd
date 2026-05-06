extends Node3D

enum menuScreens {
	main,
	attack,
	items,
	special,
	escape
}
var currentMenuScreen = menuScreens.main;
var displayedMenuScreen = currentMenuScreen;

@export var enemyScenes: Array[PackedScene];

@onready var MovingParts: Control = get_node("ui/Intro/MovingParts");
@onready var Intro: Control = get_node("ui/Intro");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemies: Array[Enemy];

	for enemyScene in enemyScenes:
		enemies.append(enemyScene.instantiate() as Enemy);

	Bus.newBattle.connect(newBattle);
	Bus.newBattle.emit("house", enemies);

func newBattle(backgroundName: String, enemies: Array[Enemy]):
	var enemyNames: Array[String];

	for enemy in enemies:
		enemyNames.append(enemy.name);

	MovingParts.loadEnemies(enemyNames);

	$Enemies.spawnEnemies(enemies);

	$WorldEnvironment.environment.sky.sky_material.panorama = load("res://assets/backgrounds/battle/%s.exr" % backgroundName);
	
	await MovingParts.finishedIntro;
	Intro.hide();
