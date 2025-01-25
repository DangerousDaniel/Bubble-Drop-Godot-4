extends CharacterBody2D

# Movement variables
@export var speed = 400
@export var jump_force = 800
@export var gravity = 1000

func get_input():
	# Horizontal direction based on input.
	var input_direction = 0
	if Input.is_action_pressed("ui_left"):
		input_direction -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction += 1
	# Move the character using input.
	velocity.x = input_direction * speed
	
	# If the player is grounded, they can jump.
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		velocity.y = -jump_force
	
func _physics_process(delta):
	if not is_on_floor():
		# Apply gravity if player is airborne.
		velocity.y += gravity * delta
	get_input()
	move_and_slide()
