extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while (get_line_count() > 1):
		add_theme_font_size_override("normal_font_size", get_theme_font_size("normal_font_size") - 1)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
