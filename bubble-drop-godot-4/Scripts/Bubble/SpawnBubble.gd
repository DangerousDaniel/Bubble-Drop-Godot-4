extends Node2D

#File path to the Bubble platform object
var mynode = preload ("res://Pefab/Objects/bubble_controller.tscn")
@onready var root = get_node("/root")
@onready var bubbleplafrom = $"../BubbleController/Sprite2D/anim"
# During each update of the game, this checks for if mouse1 is pressed; creates a bubble in that space
func _physics_process(delta):
	
	if $"../CanvasLayer/BubbleCounter".count <= $"../CanvasLayer/BubbleCounter".maxCount && $"../CanvasLayer/BubbleCounter".count != 0:
		if Input.is_action_just_pressed("CreateBubble"):
			
			$"../CanvasLayer/BubbleCounter".BubbleCountDownUI()
			
			#var variable = $"../../Sprite2D".Vector2(global_position.x, global_position.y) 
			#variable = get_global_mouse_position()
			#$"../../Sprite2D".Vector2 = variable
			
			bubbleplafrom.global_position = get_global_mouse_position()
			
			
			bubbleplafrom.play("create")
			inst(get_global_mouse_position())
			
	elif $"../CanvasLayer/BubbleCounter".count == 0 && $"../VictoryFlagRoot".flag == false:
		$"../CanvasLayer/GameOverScreen".ActiveScreen()
	
			

# method/function to instantiate bubble object
func inst(pos):
	var instance = mynode.instantiate()
	instance.position = pos
	root.add_child(instance)
