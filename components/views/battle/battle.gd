extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	newBattle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func intro(enemyNames: Array[String]):
	pass

func newBattle(backgroundName: String, enemyNames: Array[String]):
	$Enemies.spawnEnemies(enemyNames);
	$WorldEnvironment.environment.sky.panorama = load("res://components/characters/%s/%s.tscn" % [backgroundName, backgroundName]);
