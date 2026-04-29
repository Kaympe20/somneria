extends Node;
class_name PlayerData;

var possibleAttacks: Dictionary;
 
# Called when the node enters the scene tree for the first time.
static func getAttacks() -> Array:
	return ["Big depleting attack", "Small Eco Attack", "", ""] as Array[String];
	
