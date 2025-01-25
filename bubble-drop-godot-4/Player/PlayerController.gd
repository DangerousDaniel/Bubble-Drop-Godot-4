extends CharacterBody2D

# public variables.
@export_group("Movement Modifiers")
@export var move_speed = 150
var max_speed = 300
@export var gravity = 350
@export var jump_force = 300
@export var acceleration = 6
@export var deceleration = 5
@export var threshold = 25

var _isJumping = false

func _physics_process(delta):
	# Apply gravity if player is airborne
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		_isJumping = false

	# Handle jump
	if Input.is_action_just_pressed("Jump") and !_isJumping:
		Jump()

	horizontal_movement(delta)

	# Apply physics
	move_and_slide()

func horizontal_movement(delta):
	var horizontal_input = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	
	if horizontal_input != 0:
		# Accelerate towards max speed based on input direction
		var target_speed = float(horizontal_input) * max_speed
		velocity.x = lerp(velocity.x, target_speed, acceleration * delta)
		# Flip sprite based on direction
		$Sprite2D.flip_h = horizontal_input < 0
	else:
		# Decelerate towards 0 when no input
		velocity.x = lerp(velocity.x, 0.0, deceleration * delta)
	
	if abs(velocity.x) < threshold:
		velocity.x = 0
	# Ensure the player does not exceed max speed
	if abs(velocity.x) > max_speed:
		velocity.x = sign(velocity.x) * max_speed

func Jump():
	velocity.y -= jump_force
	_isJumping = true
	
	if velocity.x > 0:
		velocity.x = move_speed
	elif velocity.x < 0:
		velocity.x = -move_speed
	else:
		velocity.x = 0
