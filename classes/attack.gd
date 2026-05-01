extends move;
class_name attack;

func _init(attackName: String, animation: Animation = Animation.new()) -> void:
	self.moveType = move.moveTypes.attack;
	self.moveName = attackName;
	self.animation = animation;
	
func getName() -> String:
	return moveName;
