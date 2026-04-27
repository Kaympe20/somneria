extends GridContainer

var currentIndex: int = 0;
var numItems: int;
signal optionSelected(option: int);


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	renderOptions(["Wonderfire", "Wonderfire", "Wonderfire"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var amountToMoveBy: Vector2 = Vector2.ZERO;
	
	if Input.is_action_just_pressed("right"):
		amountToMoveBy.x += 1;
	if Input.is_action_just_pressed("left"):
		amountToMoveBy.x -= 1;
	if Input.is_action_just_pressed("forward"):
		amountToMoveBy.y += 1;
	if Input.is_action_just_pressed("back"):
		amountToMoveBy.y -= 1;
		
	if amountToMoveBy != Vector2.ZERO:
		moveUnderline(amountToMoveBy);
		if Input.is_action_just_pressed("select"):
			optionSelected.emit(currentIndex);

func renderOptions(options: Array[String]):
	assert(options.size() <= 4, "renderOptions recieved an array with more than 4 values.");
	numItems = options.size();
	for index in range(4):
		
		var text: String;
		var label: RichTextLabel = get_node("Label%s" % str(index + 1));
		
		if (index < numItems):
			text = options[index];
			if index == 0:
				text = addUnderline(text);
		else:
			text = "";
			
		label.text = text;

#TODO Implement
func moveUnderline(amountToMoveBy: Vector2): ## Moves the underline by the amount given as a Vector 2, does nothing if the move would be out of bounds
	var workingIndex = currentIndex;
	
	var label: RichTextLabel = get_node("Label%s" % (workingIndex + 1));
	label.text = label.get_parsed_text(); # Clear underline
	
	print("current index is %s and index to move by is %s" % [workingIndex, convertToIndex(amountToMoveBy)]);
	workingIndex += convertToIndex(amountToMoveBy);
	
	if workingIndex > numItems - 1:
		workingIndex = numItems - 1;
	elif workingIndex < 0:
		workingIndex = 0;
	
	print("Getting node Label%s" % (workingIndex + 1));
	label = get_node("Label%s" % (workingIndex + 1)); # Reassign "label" to new active RichTextLabel
	
	label.text = addUnderline(label.text);
	
	currentIndex = workingIndex;
	
func addUnderline(textToUnderline: String) -> String:
	return "[u]%s[/u]" % textToUnderline;
	
func convertToIndex(elementPosition: Vector2) -> int: ## Converts from a 2D vector to an integer index indicating which label a Vector2 refers to
	return elementPosition.x + (elementPosition.y * -2);
	
