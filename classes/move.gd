## Base class for attacks,  

extends Node;
class_name move;

enum moveTypes {
	attack,
	item,
	special,
	escape,
}

var moveType: int;
var moveName: String;
var animationName: String;

func _init(moveType: int, moveName: String, animationName: String) -> void:
	self.moveType = moveType;
	self.moveName = moveName;
	self.animationName = animationName;
	
func getName() -> String:
	return moveName;

func getMoveType() -> int:
	return moveType;
