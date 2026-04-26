extends Node3D

@onready var MovingParts: Control = get_node("ui/Intro/MovingParts");
@onready var Intro: Control = get_node("ui/Intro");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.newBattle.connect(newBattle);
	SignalBus.newBattle.emit("house",["example", "example", "example"] as Array[String]);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func newBattle(backgroundName: String, enemyNames: Array[String]):
	MovingParts.loadEnemies(enemyNames);
	$Enemies.spawnEnemies(enemyNames);
	$WorldEnvironment.environment.sky.sky_material.panorama = load("res://assets/backgrounds/battle/%s.exr" % backgroundName);
	
	await MovingParts.finishedIntro;
	Intro.hide();
