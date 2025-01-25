extends StaticBody2D

@onready var bubbleNode = preload("res://BubblePlatform(Wip)/bubble_platform.tscn")
@onready var root = get_node("/root")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta):
		if Input.is_action_just_pressed("Action"):	
			CreateBubble()

func CreateBubble():
			var instance = bubbleNode.instantiate()
			instance.position = Vector2(global_position.x, global_position.y)
			add_child(instance)
