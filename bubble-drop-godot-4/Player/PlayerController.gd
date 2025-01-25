extends CharacterBody2D

# public variables.
@export_group("Movement Modifiers")
@export var move_speed = 300
@export var gravity = 350
@export var jump_force = 300

var _isJumping = false

func _physics_process(delta):
	# Apply gravity if player is airborne
	if not is_on_floor():
		velocity.x -= gravity * delta
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		velocity.x = 0
		_isJumping = false

	# Handle jump
	if Input.is_action_just_pressed("Jump") and !_isJumping:
		Jump()

	horizontal_movement()

	# Apply physics
	move_and_slide()

func horizontal_movement():
	var horizontal_input = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	velocity.x = horizontal_input * move_speed

	# Flip sprite based on direction
	if horizontal_input != 0:
		$Sprite2D.flip_h = horizontal_input < 0

func Jump():
	velocity.y -= jump_force
	_isJumping = true
