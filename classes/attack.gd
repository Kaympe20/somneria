extends move;
class_name attack;

func _init(attackName: String, animationName: String) -> void:
	self.moveType = move.moveTypes.attack;
	self.moveName = attackName;
	self.animation = animationName;
	
func getName() -> String:
	return moveName;
