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
var is_jump_animation_finished = false

# Additional variables.
var fall_gravity = 500
var normal_gravity = 400

var initial_position = Vector2()

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		# Apply falling gravity once the character is falling
		if current_state == "die":
			animated_sprite.play("Death")
		elif velocity.y > 0:
			velocity.y += fall_gravity * delta  # Applying fall gravity
			if current_state != "fall":
				current_state = "fall"
				animated_sprite.play("fall")
		elif velocity.y <= 0:
			# Apply normal gravity once the character reaches peak or starts falling
			velocity.y += normal_gravity * delta
			if current_state != "jump":
				current_state = "jump"  # Set state to jump while in the air
				animated_sprite.play("jump")
	else:
		# If on the ground, reset the state to idle
		if current_state == "die":
			animated_sprite.play("Death")
		elif current_state in ["jump", "fall"]:
			current_state = "idle"
			animated_sprite.play("idle")

	# Handle jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		current_state = "jump"
		Jump()

	# Handle horizontal movement (air control is allowed)
	var horizontal_input = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	handle_horizontal_movement(delta, horizontal_input)

	if current_state == "sleep" and horizontal_input != 0:
		current_state = "idle"
		animated_sprite.play("idle")

	# Flip sprite based on horizontal input, regardless of state
	if horizontal_input != 0:
		$Sprite2D.flip_h = horizontal_input < 0
		$Sprite2D/AnimatedSprite2D.flip_h = horizontal_input < 0
		
  
	# Apply physics
	move_and_slide()

func _ready():
	# Connect the animation_finished signal from the AnimatedSprite2D node
	animated_sprite.connect("animation_finished", Callable(self, "_on_animated_sprite_2d_animation_finished"))
	var initial_position = global_position  #Gets the position of the player starting the game
	


func handle_horizontal_movement(delta, horizontal_input):
	# Handle horizontal movement, allowing for movement during falling/jumping
	if current_state in ["idle", "run", "fall", "jump"]:  # Allow movement in all states
		if horizontal_input != 0:
			# Accelerate towards max speed
			var target_speed = float(horizontal_input) * max_speed
			velocity.x = lerp(velocity.x, target_speed, acceleration * delta)

			# Only play walk animation if grounded and not jumping
			if current_state != "jump" and current_state != "fall":
				current_state = "run"
				animated_sprite.play("walk")
		else:
			# Decelerate towards 0
			velocity.x = lerp(velocity.x, 0.0, deceleration * delta)
		
			# Transition to idle if movement stops and grounded
			if is_on_floor() and current_state == "run":
				current_state = "idle"
				animated_sprite.play("idle")

	# Ensure player doesn't exceed max speed
	if abs(velocity.x) > max_speed:
		velocity.x = sign(velocity.x) * max_speed

func _on_animated_sprite_2d_animation_finished():
	# Allow transitions out of dance and sleep states
	if current_state == "idle":
		current_state = "dance"
		animated_sprite.play("dance")
	elif current_state == "dance":
		current_state = "sleep"
		animated_sprite.play("sleep")
	elif current_state == "sleep":
		# Transition out of sleep if any other action is taken
		# For example, we go back to idle after sleeping
		current_state = "idle"
		animated_sprite.play("idle")
	elif current_state == "jump":
		# Reset the speed scale after the jump animation is finished
		animated_sprite.speed_scale = 1.0  # Reset speed scale to normal
		current_state = "fall"  # Transition to fall state
		animated_sprite.play("fall")
	elif current_state == "fall":
		current_state = "idle"  # Transition to idle when landing
		animated_sprite.play("idle")
	elif current_state == "die":  #Spawn the player in the starting position
		Respawn()

func Jump():
	animated_sprite.speed_scale = 0.6
	animated_sprite.play("jump")
	ApplyJumpForce()

func ApplyJumpForce():
	velocity.y -= jump_force
	
	
func Die():
	current_state = "die" 	 #enters into die state
	velocity.x = 0.0  #this stops the player for moving
	velocity.y = 0.0
	print("Player dies")
	
func Respawn(): 
	print("Time to respawn")
	current_state = "idle"  #return in the idle animation
	global_position = initial_position  #respawn the player in the starting position


	
	
	
	
