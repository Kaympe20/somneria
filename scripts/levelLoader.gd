extends Node

var levelInstance;

func unloadLevel():
	if (is_instance_valid(levelInstance)):
		levelInstance.queue_free();
	levelInstance = null;
	
func loadLevel(levelName: String):
	unloadLevel();
	
	var levelPath: String;
	
	levelPath = "res://scenes/%s/%s.tscn" % levelName;
	
	var levelResource : PackedScene = load(levelPath);
	
	if levelResource:
		levelInstance = levelResource.instantiate();
		add_child(levelInstance);
		
func _ready() -> void:
	SignalBus.returnToReality.connect(loadBedroom);

func loadBedroom():
	loadLevel("bedroom");
