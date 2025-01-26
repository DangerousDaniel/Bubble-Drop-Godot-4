"""
	Project Name: Bubble Drop Godot 4: Prostyle 1
	Team Name: GGJ 2025 - Bubble Drop Godot 4
	Authors: Sliver
	Game Jam Date: January 24 - 26, 2025
	Description: This class spawn a bubble platform from the player
	Notes: 
	Resources:
"""
extends Node2D

#File path to the Bubble platform object
var mynode = preload ("res://Player/bubble_platform.tscn")
@onready var root = get_node("/root")

# During each update of the game, this checks for if mouse1 is pressed; creates a bubble in that space
func _physics_process(delta):
	if Input.is_action_just_pressed("CreateBubble"):
		
		
		#var variable = $"../../Sprite2D".Vector2(global_position.x, global_position.y) 
		#variable = get_global_mouse_position()
		#$"../../Sprite2D".Vector2 = variable
		
		$"../../BubblePlatform/Sprite2D/anim".global_position = get_global_mouse_position()
		
		
		$"../../BubblePlatform/Sprite2D/anim".play("Create_Bubble")
		inst(get_global_mouse_position())

# method/function to instantiate bubble object
func inst(pos):
	var instance = mynode.instantiate()
	instance.position = pos
	root.add_child(instance)
