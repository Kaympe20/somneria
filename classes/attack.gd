extends move;
class_name attack;

var baseDamage: float;

func _init(attackName: String, animationName: String, baseDamage: float) -> void:
	self.moveType = move.moveTypes.attack;
	self.moveName = attackName;
	self.animationName = animationName;
	self.baseDamage = baseDamage;
	
func getName() -> String:
	return moveName;
