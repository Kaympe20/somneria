extends ColorRect

@onready var marginNode: MarginContainer = get_parent();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func showLevel(levelFraction: float):
	levelFraction = 1.0 if levelFraction > 1 else levelFraction;

	var insideMarginHeight: float = marginNode.size.y - marginNode.get_theme_constant("margin_top") - marginNode.get_theme_constant("margin_bottom");

	custom_minimum_size.y = insideMarginHeight * levelFraction;
