class_name BubbleExplosion extends Node2D

var thrust = Vector2(0, -250)
var angle = rotation
var impulse_force_strength = 400
var rng = RandomNumberGenerator.new()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Collision")
	var random_rotation = rng.randf_range(-10.0, 10.0)
	var collision_info = (impulse_force_strength * thrust )
	if body is CharacterBody2D:
		var collision_impulse = thrust.rotated(rotation * random_rotation).normalized() * impulse_force_strength
		body.velocity += collision_impulse
		
		print("Collided with player")
