extends Node2D

var mynode = preload ("res://BubblePlatform(Wip)/bubble_platform.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("CreateBubble"):
		inst(get_global_mouse_position())


func inst(pos):
	var instance = mynode.instantiate()
	instance.position = pos
	add_child(instance)
