extends Node2D

#File path to the Bubble platform object
var mynode = preload ("res://BubblePlatform(Wip)/bubble_platform.tscn")

# During each update of the game, this checks for if mouse1 is pressed; creates a bubble in that space
func _physics_process(delta):
	if Input.is_action_just_pressed("CreateBubble"):
		inst(get_global_mouse_position())

# method/function to instantiate bubble object
func inst(pos):
	var instance = mynode.instantiate()
	instance.position = pos
	add_child(instance)
