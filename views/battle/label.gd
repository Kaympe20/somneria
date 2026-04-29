extends Label


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_confirmation_requested(confirmationAction: String) -> void:
	text = "Are you sure you want to %s?" % confirmationAction;
	show();
