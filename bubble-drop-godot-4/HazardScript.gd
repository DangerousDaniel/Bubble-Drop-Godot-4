extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("There is a hazard")


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_body_entered(body):
	print("Collision")
	if body is Player:
 		body.Die()
		
	elif "bubble" in body.name: 
		body.Pop() # Replace with function body.
