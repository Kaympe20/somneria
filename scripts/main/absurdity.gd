extends Control

var absurdity: float = 0.8;

var active: bool = false;

@onready var main: Node = get_tree().get_root().get_node("main");

@export var absurdityDecreaseRate: float; ## The amount to decrease absurdity by per minute

signal showLevel(levelFraction: float);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		if absurdity >= 0:
			absurdity -= (delta * (absurdityDecreaseRate/60));

	if Input.is_action_pressed("show_level") and main.activeView() == root.views.firstPerson:
		
		show()
		
		showLevel.emit(absurdity);
		
		$TextureRect.texture.speed_scale = absurdity/1.5;
		
#		print("show")
	else:
		hide()

func absurdityLevel(callback: Callable):
	callback.call(absurdity);


func _on_start_pressed() -> void:
	active = true;
