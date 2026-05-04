extends Control

var timeElapsed: float;
var gameActive: bool = false;
var absurdityLevel: float = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeElapsed = PlayerData.getElapsedTime();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gameActive:
		timeElapsed += delta;

func _on_start_pressed() -> void:
	gameActive = true;
