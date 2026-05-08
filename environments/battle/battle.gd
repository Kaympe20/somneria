extends Node3D

signal reopenMenu();

enum menuScreens {
	main,
	attack,
	items,
	special,
	escape
}
var currentMenuScreen = menuScreens.main;
var displayedMenuScreen = currentMenuScreen;
var playerHealth: float = 100;

var testEnemy: enemy = load("res://components/enemies/ball/ball.gd").new();

@onready var MovingParts: Control = get_node("ui/Intro/MovingParts");
@onready var Intro: Control = get_node("ui/Intro");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bus.newBattle.connect(newBattle);
	Bus.newBattle.emit("house", [testEnemy] as Array[enemy]);
	Bus.playerDamage.connect(playerDamage);

func newBattle(backgroundName: String, enemies: Array[enemy]):
	MovingParts.loadEnemies(enemies);
	$Enemies.spawnEnemies(enemies);
	$WorldEnvironment.environment.sky.sky_material.panorama = load("res://assets/backgrounds/battle/%s.exr" % backgroundName);
	
	await MovingParts.finishedIntro;
	Intro.hide();
	
func playerDamage(damage: float):
	playerHealth -= damage;
	if playerHealth <= 0:
		Bus.loseCondition.emit();
		
	reopenMenu.emit();
	
	
	
