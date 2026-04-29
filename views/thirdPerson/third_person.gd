extends CharacterBody3D

@export var speed = 14; #player movement speed, in mps
@export var fallAcceleration = 75; # player acceleration, in meters per second squared

# Vertical impulse applied to the character upon jumping in meters per second.
@export var jump_impulse = 20;

@onready var _camera_pivot: Node3D = $CameraPivot;


var targetVelocity = Vector3.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var inputDirection = Vector2.ZERO

	if Input.is_action_pressed("right"):
		inputDirection.x += 1
	if Input.is_action_pressed("left"):
		inputDirection.x -= 1
	if Input.is_action_pressed("forward"):
		inputDirection.y += 1
	if Input.is_action_pressed("back"):
		inputDirection.y -= 1

	inputDirection = inputDirection.normalized()

	# Get camera directions
	var forward = -_camera_pivot.global_transform.basis.z
	var right = _camera_pivot.global_transform.basis.x

	# Flatten so movement stays horizontal
	forward.y = 0
	right.y = 0
	forward = forward.normalized()
	right = right.normalized()

	# Convert input into world direction relative to camera
	var direction = (right * inputDirection.x + forward * inputDirection.y).normalized()
	
	#old pre-mouse movement code
	#if Input.is_action_pressed("right"):
		#direction.x += 1;
	#if Input.is_action_pressed("left"):
		#direction.x -= 1;
	#if Input.is_action_pressed("back"):
		#direction.z += 1;
	#if Input.is_action_pressed("forward"):
		#direction.z -= 1;

	if direction != Vector3.ZERO:
		direction = direction.normalized();
		# Setting the basis property will affect the rotation of the node.
		$Pivot.basis = Basis.looking_at(direction);
		
	targetVelocity.x = direction.x * speed;
	targetVelocity.z = direction.z * speed;

	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		targetVelocity.y = targetVelocity.y - (fallAcceleration * delta);
		
	velocity = targetVelocity;
	
	# Jumping.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		targetVelocity.y = jump_impulse;
	
	move_and_slide();
	

@export_range(0.0, 1.0) var mouse_sensitivity = 0.01
@export var tilt_limit = deg_to_rad(75)

func _unhandled_input(event: InputEvent) -> void:
	# Mouselook implemented using `screen_relative` for resolution-independent sensitivity.
	if event is InputEventMouseMotion:
		_camera_pivot.rotation.x -= event.screen_relative.y * mouse_sensitivity
		# Prevent the camera from rotating too far up or down.
		_camera_pivot.rotation.x = clampf(_camera_pivot.rotation.x, -tilt_limit, tilt_limit)
		_camera_pivot.rotation.y += -event.screen_relative.x * mouse_sensitivity
