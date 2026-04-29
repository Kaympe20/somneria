extends Control

signal finishedIntro();
@export var moveSpeed: float;
@export var finishMultiplier: float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = -200;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var finished: bool = false;
	
	if position.x < 200:
		position.x += delta *  moveSpeed
	elif !finished:
		finished = true;
		
		var secondFinish: bool = false;
		
		if position.x < 1700:
			position.x += delta * moveSpeed * finishMultiplier;
		elif !secondFinish:
			secondFinish = true;
			finishedIntro.emit();
			

func loadEnemies(enemyNames: Array[String]):
	assert(enemyNames.size() <= 3, "loadeEnemies() in Intro recieved an array with more than 3 values.");
	for index in range(enemyNames.size()):
		var enemyName: String = enemyNames[index];
		var enemyHeadshot: CompressedTexture2D = load("res://assets/characters/%s/%s.png" % [enemyName, enemyName]);

		var enemyNode = TextureRect.new();
		enemyNode.texture = enemyHeadshot;
		enemyNode.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;
		enemyNode.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED;
		enemyNode.size_flags_horizontal = Control.SIZE_EXPAND_FILL;
		enemyNode.size_flags_vertical = Control.SIZE_EXPAND_FILL;
		
		$HBoxContainer.add_child(enemyNode);
