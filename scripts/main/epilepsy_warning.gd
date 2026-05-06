extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible and Input.is_action_just_pressed("ui_accept"):
		hide()

func _on_warning_show_timer_timeout() -> void:
	hide();
