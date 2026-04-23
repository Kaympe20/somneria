extends Node

const dreamList: Array[String] = [];
var levelInstance;
var levelNumber: int;

func unloadLevel():
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free();
	levelInstance = null;
	
func loadLevel(levelIdentifier):
	if typeof(levelIdentifier) == TYPE_STRING:
		unloadLevel();
		
		var levelPath: String;
		
		levelPath = "res://scenes/%s/%s.tscn" % levelIdentifier;
		
		var levelResource : PackedScene = load(levelPath);
		
		if levelResource:
			levelInstance = levelResource.instantiate();
			add_child(levelInstance);
	elif typeof(levelIdentifier) == TYPE_INT:
		if levelIdentifier != 0:
			levelNumber = levelIdentifier;
		unloadLevel();
		SignalBus.mainMenuHide.emit();
		var levelPath : String
		
		levelPath = "res://scenes/levels/scn%s.tscn" % str(levelNumber);
		
		if (ResourceLoader.exists(levelPath)):
			var levelResource : PackedScene = load(levelPath);
			
			if levelResource:
				levelInstance = levelResource.instantiate();
				add_child(levelInstance);
				levelNumber += 1;
		else:
			pass; #win condition
	else:
		push_error("Function loadLevel() recieved a type that was not an int or String");
		
func _ready() -> void:
	SignalBus.returnToReality.connect(loadBedroom);
	SignalBus.loadLevel.connect(loadLevel);

func loadBedroom():
	loadLevel("bedroom");
