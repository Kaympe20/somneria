extends Control

var absurdity: float = 0.8;

var active: bool = true;

@export var absurdityDecreaseRate: float; ## The amount to decrease absurdity by per minute

signal showLevel(levelFraction: float);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		absurdity -= (delta * (absurdityDecreaseRate/60));

		showLevel.emit(absurdity);
