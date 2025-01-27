class_name Player extends CharacterBody2D

# Public variables
@export_group("Movement Modifiers")
@export var move_speed : float = 50.0
@export var max_speed : float = 500
@export var acceleration : float = 4
@export var deceleration : float = 6
@export var threshold : float = 20

@export_group("Jump Modifiers")
@export var jump_force : float = 300
@export var jump_delay : float = 0.9
var isJumping : bool = false

@onready var animated_sprite : AnimatedSprite2D = $Sprite2D/AnimatedSprite2D
var current_state :  = "standing"  # Track the current character state
var is_jump_animation_finished : bool = false
var is_waiting_for_idle : bool = false

@export_group("Gravity Modifiers")
@export var gravity : float = 350
var isFalling : bool = false
@export var fall_gravity : float = 500
@export var normal_gravity : float = 400



func _physics_process(delta):
	#Check if player is airborne.
	if not is_on_floor():
		# Apply falling gravity once the character is falling
		if (velocity.y > 0 and !isJumping):
			isFalling = true
			isJumping = false
			current_state = "fall"
			animated_sprite.play("fall")
			velocity.y += fall_gravity * delta  # Applying fall gravity
			
	else:
		isFalling = false
		if (current_state in ["jump", "fall"]):
			current_state = "standing"
			animated_sprite.play("standing")
	
		
	# Handle jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		isJumping = true
		isFalling = false
		current_state = "jump"
		Jump()
	# Handle landing jump
	velocity.y += gravity * delta
	if (isFalling and isJumping):
		animated_sprite.play("landing_jump")

	# Handle horizontal movement (air control is allowed)
	var horizontal_input = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	
	if (current_state == "standing" and horizontal_input == 0 and !is_waiting_for_idle):
		start_idle_timer()
		
	handle_horizontal_movement(delta, horizontal_input)

	if (current_state == "idle" and horizontal_input != 0):
		current_state = "run"
		animated_sprite.play("walk")
	if (current_state == "sleep" and horizontal_input != 0):
		current_state = "idle"
		animated_sprite.play("idle")

	# Flip sprite based on horizontal input, regardless of state
	if (horizontal_input != 0):
		$Sprite2D.flip_h = horizontal_input < 0
		$Sprite2D/AnimatedSprite2D.flip_h = horizontal_input < 0
		


	# Apply physics
	move_and_slide()

func _ready():
	# Connect the animation_finished signal from the AnimatedSprite2D node
	
	animated_sprite.connect("animation_finished", Callable(self, "_on_animated_sprite_2d_animation_finished"))

func handle_horizontal_movement(delta, horizontal_input):
	# Handle horizontal movement, allowing for movement during falling/jumping
	if (current_state in ["idle", "run", "fall", "jump", "standing"]):  # Allow movement in all states
		if (horizontal_input != 0):
			# Accelerate towards max speed
			var target_speed : float = horizontal_input * max_speed
			velocity.x = lerp(velocity.x, target_speed, acceleration * delta)

			# Only play walk animation if grounded and not jumping
			if (current_state != "jump" and current_state != "fall"):
				current_state = "run"
				animated_sprite.play("walk")
		else:
			# Decelerate towards 0
			velocity.x = lerp(velocity.x, 0.0, deceleration * delta)
		
			# Transition to idle if movement stops and grounded
			if (is_on_floor() and current_state == "run"):
				current_state = "idle"
				animated_sprite.play("idle")

	# Ensure player doesn't exceed max speed
	if (abs(velocity.x) > max_speed):
		velocity.x = sign(velocity.x) * max_speed

func _on_animated_sprite_2d_animation_finished():
	# Allow transitions out of dance and sleep states
	
	if (current_state == "idle"):
		current_state = "dance"
		animated_sprite.play("dance")
	elif (current_state == "dance"):
		current_state = "sleep"
		animated_sprite.play("sleep")
	elif (current_state == "sleep"):
		# Transition out of sleep if any other action is taken
		# For example, we go back to idle after sleeping
		current_state = "idle"
		animated_sprite.play("idle")
	elif (current_state == "jump"):
		animated_sprite.play("landing_jump")
		# Reset the speed scale after the jump animation is finished
		current_state = "fall"  # Transition to fall state
		animated_sprite.play("fall")
	elif (current_state == "fall"):
		current_state = "idle"  # Transition to idle when landing
		animated_sprite.play("idle")

func Jump():
	# Handle jump
	animated_sprite.play("jump")
	ApplyJumpForce()

func ApplyJumpForce():
	# Add force to jump
	velocity.y -= jump_force
	
func start_idle_timer():
	is_waiting_for_idle = true
	current_state = "standing"  # Ensure state is locked during the wait
	animated_sprite.play("standing")
	print("Started waiting")
	await get_tree().create_timer(6).timeout
	print("Ended waiting")
	# Ensure no new input occurred during the wait
	if current_state == "standing" and Input.get_action_strength("MoveRight") == 0 and Input.get_action_strength("MoveLeft") == 0:
		current_state = "idle"
		animated_sprite.play("idle")
	is_waiting_for_idle = false


func _on_area_2d_right_side_bubble_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
	
func Die():
	current_state = "die" 	 #enters into die state
	velocity.x = 0.0  #this stops the player for moving
	velocity.y = 0.0
	Respawn()
	
func Respawn(): 
	current_state = "idle"  #return in the idle animation
	get_tree().reload_current_scene()  #reload the current scene
