extends AnimatableBody2D
@onready var RightSideBubble = $Area2DRightSideBubble
@onready var LeftSideBubble = $Area2DLeftSideBubble
# Called when the node enters the scene tree for the first time.

var thrust = Vector2(0, -250)

func _on_Area2_area_entered(area):
	if area.is_in_group("player"):
		print("collided with player")

#func _integrate_forces(state):
	#Replace with collision detection with player
	#if Input.is_action_pressed("ui_up"):
		#set direction to a range -30 to 0 for left, 0 to 30 for right.
		#var rotation_direction = 0
		#state.apply_force(thrust.rotated(rotation))
