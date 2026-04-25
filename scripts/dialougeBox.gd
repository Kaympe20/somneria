extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.newDialouge.connect(newDialouge);
	SignalBus.updateDialouge.connect(changeText);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func changeText(text: String):
	$Label.text = text;

func newDialouge(character: String, dialouge: String):
	var headshotPath: String = "res://assets/characters/%s/%s.png" % [character, character];
	$TextureRect.texture = load(headshotPath);
	changeText(dialouge);
