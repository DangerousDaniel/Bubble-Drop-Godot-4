extends AnimatableBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var animated_sprite = $AnimatedSprite2D
	await get_tree().create_timer(2).timeout
	animated_sprite.play("Bubble_Pop")
	await get_tree().create_timer(0.5).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
