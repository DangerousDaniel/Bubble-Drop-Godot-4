class_name BubbleExplosion extends Node2D

var thrust = Vector2(-50, -50)
var angle = rotation
var impulse_force_strength = 500
var rng = RandomNumberGenerator.new()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Collision")

	var random_rotation = rng.randf_range(-50.0, 50.0 * 5)
	var collision_info = (impulse_force_strength * random_rotation )
	
	if body is Player:
		var collision_impulse = thrust.rotated(random_rotation).normalized() * impulse_force_strength
		body.velocity += collision_impulse
		
		print("Collided with player")


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
