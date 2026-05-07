extends enemy

func _init() -> void:
	self.headshot = load("res://assets/characters/miku/miku.png");
	self.name = "ball";
	self.attacks = [attack.new("drop", "sphereAction", 30.0)];
	self.model = load("res://components/enemies/ball/worst ball bounce ever.glb");
	self.health = 100;
