extends Node3D

signal renderMenuItems(options: Array[String]);

enum menuScreens {
	main,
	attack,
	items,
	special,
	escape
}
var currentMenuScreen = menuScreens.main;
var displayedMenuScreen = currentMenuScreen;

@onready var MovingParts: Control = get_node("ui/Intro/MovingParts");
@onready var Intro: Control = get_node("ui/Intro");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bus.newBattle.connect(newBattle);
	Bus.newBattle.emit("house",["example", "example", "example"] as Array[String]);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if displayedMenuScreen != currentMenuScreen:
		var itemsToRender: Array[String];
		match currentMenuScreen:
			menuScreens.main: itemsToRender = ["Attack", "Items", "Special", "Escape"] as Array[String];
			
		displayedMenuScreen = currentMenuScreen;

func newBattle(backgroundName: String, enemyNames: Array[String]):
	renderMenuItems.emit(["Attack", "Items", "Special", "Escape"] as Array[String]);
	
	MovingParts.loadEnemies(enemyNames);
	$Enemies.spawnEnemies(enemyNames);
	$WorldEnvironment.environment.sky.sky_material.panorama = load("res://assets/backgrounds/battle/%s.exr" % backgroundName);
	
	await MovingParts.finishedIntro;
	Intro.hide();

func getPlayerAttacks() -> Array:
	return [];

func _on_option_select(option: int) -> void:
	print("optionSelected(%s) recieved" % option);
	if option == 4:
		currentMenuScreen = menuScreens.main;
		return;
	match currentMenuScreen:
		menuScreens.main: match option:
			0: currentMenuScreen = menuScreens.attack;
			1: currentMenuScreen = menuScreens.items;
			2: currentMenuScreen = menuScreens.special;
			3: currentMenuScreen = menuScreens.escape;
