extends enemy

func _init() -> void:
	self.headshot = load("res://assets/characters/miku/miku.png");
	self.name = "ball";
	self.attacks = [attack.new("drop", "SphereAction", 30.0)];
	self.model = load("res://components/enemies/ball/worst ball bounce ever.glb");
	self.health = 100;

func _postReady():
	for child in modelInstance.get_children():
		if child is MeshInstance3D:
			child.position.y = 1.0;
			
