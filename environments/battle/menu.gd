extends Control

signal renderMenuItems(options: Array[String]);

signal playerMove(move: move);

var moveType: int;

var isConfirmation: bool = false;
signal confirmationRequested(confirmationAction: String);
signal confirmationEnded;

enum menuScreens {
	main,
	attack,
	items,
	special,
	escape
}
var currentMenuScreen = menuScreens.main;
var displayedMenuScreen = currentMenuScreen;

## Helper function to properly display the grid
func fillUnusedSpaces(incompleteArray: Array[String]) -> Array[String]:
	print(incompleteArray)
	assert(incompleteArray.size() <= 4, "fillUnusedSpaces() received an array with a size greater than 4");
	for index in range(4 - incompleteArray.size()):
		incompleteArray.append("");
	return incompleteArray;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	renderMenuItems.emit(["Attack", "Items", "Special", "Escape"] as Array[String]);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if displayedMenuScreen != currentMenuScreen:
		var itemsToRender: Array[String];
		if currentMenuScreen == menuScreens.main: 
			itemsToRender = ["Attack", "Items", "Special", "Escape"] as Array[String];
		else:
			match currentMenuScreen:
				menuScreens.attack: moveType = move.moveTypes.attack;
				menuScreens.items: moveType = move.moveTypes.item;
				menuScreens.special: moveType = move.moveTypes.special
			itemsToRender = fillUnusedSpaces(PlayerData.getMoveNames(PlayerData.getMoves(moveType)));

		
		displayedMenuScreen = currentMenuScreen;
		renderMenuItems.emit(itemsToRender);
		
	if Input.is_action_just_pressed("ui_cancel"):
		endConfirmation(false);

func _on_option_select(option: int) -> void:
	print("optionSelected(%s) received" % option);
	if option == 4:
		currentMenuScreen = menuScreens.main;
		return;
		
	if currentMenuScreen == menuScreens.main:
		match option:
			0: currentMenuScreen = menuScreens.attack;
			1: currentMenuScreen = menuScreens.items;
			2: currentMenuScreen = menuScreens.special;
			3: currentMenuScreen = menuScreens.escape;
		return;
		
	if !isConfirmation:
		runConfirmation(PlayerData.getMoves(moveType)[option]);
	else:
		assert(option == 1 or option == 0, "error in _on_option_select(): option is not binary")
		if !bool(option):
			endConfirmation(true);
		else:
			endConfirmation(false);

var pendingAction: move; ## variable holding the move that is currently being confirmed by the user, class variable so that it can be shared between runConfirmation() and endConfirmation()

func runConfirmation(actionToMarkAsPending: move):
	pendingAction = actionToMarkAsPending;
	var confirmationType: String;
	
	match pendingAction.getMoveType():
		move.moveTypes.attack: confirmationType = "perform";
		move.moveTypes.item: confirmationType = "use";
		move.moveTypes.special: confirmationType = "use the special ability";
		move.moveTypes.escape: confirmationType = "attempt";
	
	assert(!isConfirmation, "error running runConfirmation(): isConfirmation is already true");
	isConfirmation = true;
	confirmationRequested.emit("%s \"%s\"" % [confirmationType, pendingAction.getName()]);
 
func endConfirmation(result: bool):
	isConfirmation = false;
	if result:
		playerMove.emit(pendingAction);
	else:
		currentMenuScreen = menuScreens.main;
	confirmationEnded.emit();
