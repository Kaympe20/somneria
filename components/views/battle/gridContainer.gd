extends GridContainer

var currentUnderlinePosition: Vector2 = Vector2.ONE;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	renderOptions(["Wonderfire", "Wonderfire", "Wonderfire"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("right"):
		pass
	if Input.is_action_pressed("left"):
		pass
	if Input.is_action_pressed("forward"):
		pass
	if Input.is_action_pressed("back"):
		pass

func renderOptions(options: Array[String]):
	assert(options.size() <= 4, "renderOptions recieved an array with more than 4 values.");
	for index in range(4):
		var text: String;
		var label: RichTextLabel = get_node("Label%s" % str(index + 1));
		
		if (index < options.size()):
			text = options[index];
		else:
			text = "            ";
			
		label.text = text;

#TODO Implement
func moveUnderline(amountToMoveBy: Vector2) -> bool: ## Moves the underline by the amount given as a Vector 2, does nothing if the move would be out of bounds
	return true
