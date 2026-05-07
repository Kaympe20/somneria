extends CharacterBody3D
class_name enemy

var attacks: Array[attack];
var headshot: CompressedTexture2D;
var model: PackedScene;
var hitbox: CollisionShape3D = CollisionShape3D.new();
var hitboxDimensions: Vector3 = Vector3(1, 2, 1);

func _ready() -> void:
	add_child(model.instantiate());

	hitbox.position = Vector3(0, hitboxDimensions.y/2, 0);
	hitbox.shape = BoxShape3D.new();
	hitbox.shape.size = hitboxDimensions;
	add_child(hitbox);
