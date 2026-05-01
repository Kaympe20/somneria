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
var animation: Animation;

func _init(moveType: int, moveName: String, animation: Animation = Animation.new()) -> void:
	self.moveType = moveType;
	self.moveName = moveName;
	self.animation = animation;
	
func getName() -> String:
	return moveName;

func getMoveType() -> int:
	return moveType;
