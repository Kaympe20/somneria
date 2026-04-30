extends Node
class_name attack;

func _init(attackName: String) -> void:
	var name = attackName;
	
func getName() -> String:
	return name;
