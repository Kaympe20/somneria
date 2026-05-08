extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bus.winCondition.connect(show);
	Bus.loseCondition.connect(show);
