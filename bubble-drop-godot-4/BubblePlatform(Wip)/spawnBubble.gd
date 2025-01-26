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

var mynode = preload ("res://BubblePlatform(Wip)/bubble_platform.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("CreateBubble"):
		inst(get_global_mouse_position())


func inst(pos):
	var instance = mynode.instantiate()
	instance.position = pos
	add_child(instance)
