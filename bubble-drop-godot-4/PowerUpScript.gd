extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("There is a powerUp")


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_body_entered(body):
	print("Collision")
	if body is CharacterBody2D:
		print("The player got the PowerUp")
		queue_free()
