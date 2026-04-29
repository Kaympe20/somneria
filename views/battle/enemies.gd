extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnEnemies(enemyNames: Array[String]):
	assert(enemyNames.size() <= 3, "spawnEnemies() recieved an array with more than 3 values.");
	for index in range(enemyNames.size()):
		var enemyName: String = enemyNames[index];
		var enemyFile: PackedScene = load("res://components/characters/%s/%s.tscn" % [enemyName, enemyName]);
		
		var enemyNode: Node3D = enemyFile.instantiate();
		
		var parentNode: Node3D = get_node("Enemy%s" % (index + 1));
		
		parentNode.add_child(enemyNode);
		print("Enemy Added: %s" % enemyName);
	print("Enemies finished spawning");
