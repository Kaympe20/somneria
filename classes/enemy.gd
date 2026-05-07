extends CharacterBody3D
class_name enemy

signal death();

var attacks: Array[attack];
var health: float;
var headshot: CompressedTexture2D;
var model: PackedScene;
var modelInstance: Node3D;
var hitbox: CollisionShape3D = CollisionShape3D.new();
var hitboxDimensions: Vector3 = Vector3(1, 2, 1);

func _ready() -> void:
	modelInstance = model.instantiate(); 
	modelInstance.add_to_group("model");
	add_child(modelInstance);

	hitbox.position = Vector3(0, hitboxDimensions.y/2, 0);
	hitbox.shape = BoxShape3D.new();
	hitbox.shape.size = hitboxDimensions;
	add_child(hitbox);

func performAttack(attackToPerform: attack):
	var animationPlayer: AnimationPlayer;
	
	for child in modelInstance.get_children():
		if child is AnimationPlayer:
			animationPlayer = child;
			
	animationPlayer.play(attackToPerform.animationName);
	Bus.playerDamage.emit(attackToPerform.baseDamage);

func _process(delta: float) -> void:
	if health <= 0:
		death.emit();
		queue_free();
