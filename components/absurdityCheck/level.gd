extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	showLevel(0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func showLevel(levelFraction: float) -> void:
	var parent: MarginContainer = get_parent();
	
	var sizeDenom: float = parent.size.y - 20; #HACK 
	
	custom_minimum_size.y = levelFraction * parent.size.y;
