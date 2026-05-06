extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnEnemies(enemies: Array[Enemy]):
	assert(enemies.size() <= 3, "spawnEnemies() recieved an array with more than 3 values.");
	for index in range(enemies.size()):
		var currentEnemy = enemies[index]; # Sadly godot does not like shadowing and there is already an enemy class

		var parentNode: Node3D = get_node("Enemy%s" % (index + 1));
		parentNode.add_child(currentEnemy);

		print("Enemy Added: %s" % currentEnemy.name);
	print("Enemies finished spawning");
