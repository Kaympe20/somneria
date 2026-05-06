extends CharacterBody3D
class_name Enemy

var attacks: Array[attack];

func _init(attacks: Array[attack], enemyName: String) -> void:
    self.attacks = attacks;
    name = enemyName;

