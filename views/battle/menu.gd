extends Control

signal renderMenuItems(options: Array[String]);

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	renderMenuItems.emit(["Attack", "Items", "Special", "Escape"] as Array[String]);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if displayedMenuScreen != currentMenuScreen:
		var itemsToRender: Array[String];
		match currentMenuScreen:
			menuScreens.main: itemsToRender = ["Attack", "Items", "Special", "Escape"] as Array[String];
			menuScreens.attack: itemsToRender = PlayerData.getAttacks();
		
		displayedMenuScreen = currentMenuScreen;
		renderMenuItems.emit(itemsToRender);
		
	if Input.is_action_just_pressed("ui_cancel"):
		endConfirmation();

func _on_option_select(option: int) -> void:
	print("optionSelected(%s) received" % option);
	if option == 4:
		currentMenuScreen = menuScreens.main;
		return;
	match currentMenuScreen:
		menuScreens.main: match option:
			0: currentMenuScreen = menuScreens.attack;
			1: currentMenuScreen = menuScreens.items;
			2: currentMenuScreen = menuScreens.special;
			3: currentMenuScreen = menuScreens.escape;
		menuScreens.attack: runConfirmation(PlayerData.getAttacks()[option]);
			
func runConfirmation(thingToConfirm: String):
	var confirmationType: String;
	
	match currentMenuScreen:
		menuScreens.attack: confirmationType = "perform";
		menuScreens.items: confirmationType = "use";
		menuScreens.special: confirmationType = "use the special ability";
		menuScreens.escape: confirmationType = "attempt";
	
	assert(!isConfirmation, "error running runConfirmation(): isConfirmation is already true");
	isConfirmation = true;
	confirmationRequested.emit("Are you sure you would like to %s %s?" % [confirmationType, thingToConfirm]);
 
func endConfirmation():
	isConfirmation = false;
