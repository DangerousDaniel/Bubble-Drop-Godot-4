extends CharacterBody2D

@export var speed = 400
@export var jump_force = 800

func get_input():
	var input_direction = 0
	if Input.is_action_pressed("ui_left"):
		input_direction -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction += 1
	velocity.x = input_direction * speed
	
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		velocity.y = -jump_force
	
func _physics_process(delta):
	get_input()
	move_and_slide()
