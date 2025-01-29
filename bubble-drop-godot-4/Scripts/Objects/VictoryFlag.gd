extends Node2D

@onready var sprite = $AnimatedSprite2D
var flag = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("Flag")
	pass # Replace with function body.

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		$"../CanvasLayer/VictoryScreen".ActiveScreen()
		print("you win")
