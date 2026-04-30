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

@onready var MovingParts: Control = get_node("ui/Intro/MovingParts");
@onready var Intro: Control = get_node("ui/Intro");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bus.newBattle.connect(newBattle);
	Bus.newBattle.emit("house",["example", "example", "example"] as Array[String]);

func newBattle(backgroundName: String, enemyNames: Array[String]):
	MovingParts.loadEnemies(enemyNames);
	$Enemies.spawnEnemies(enemyNames);
	$WorldEnvironment.environment.sky.sky_material.panorama = load("res://assets/backgrounds/battle/%s.exr" % backgroundName);
	
	await MovingParts.finishedIntro;
	Intro.hide();
