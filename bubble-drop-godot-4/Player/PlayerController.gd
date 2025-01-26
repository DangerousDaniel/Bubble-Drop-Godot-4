extends CharacterBody2D

# Public variables
@export_group("Movement Modifiers")
@export var move_speed = 50
var max_speed = 500
@export var gravity = 350
@export var jump_force = 300
@export var acceleration = 4
@export var deceleration = 6
@export var threshold = 20

@export var jump_delay = 0.9

@onready var animated_sprite = $Sprite2D/AnimatedSprite2D

var current_state = "idle"  # Track the current character state

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		if current_state != "jump":
			current_state = "jump"  # Set state to jump while in the air
			animated_sprite.play("jump")
	else:
		if current_state == "jump":
			current_state = "idle"  # Reset state to idle when landing
			animated_sprite.play("idle")

	# Handle jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		current_state = "jump"
		Jump()

	# Handle horizontal movement (air control is allowed)
	var horizontal_input = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	handle_horizontal_movement(delta, horizontal_input)

	# Apply physics
	move_and_slide()

func handle_horizontal_movement(delta, horizontal_input):
	if horizontal_input != 0:
		# Accelerate towards max speed
		var target_speed = float(horizontal_input) * max_speed
		velocity.x = lerp(velocity.x, target_speed, acceleration * delta)

		# Flip sprite based on direction
		$Sprite2D.flip_h = horizontal_input < 0
		$Sprite2D/AnimatedSprite2D.flip_h = horizontal_input < 0

		# Only play walk animation if grounded and not jumping
		if current_state != "jump":
			current_state = "run"
			animated_sprite.play("walk")
	else:
		# Decelerate towards 0
		velocity.x = lerp(velocity.x, 0.0, deceleration * delta)

	# Ensure player doesn't exceed max speed
	if abs(velocity.x) > max_speed:
		velocity.x = sign(velocity.x) * max_speed

func Jump():
	animated_sprite.play("jump")
	ApplyJumpForce()

func ApplyJumpForce():
	await get_tree().create_timer(jump_delay).timeout
	velocity.y -= jump_force
