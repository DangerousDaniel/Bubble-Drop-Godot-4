"""
	Project Name: Bubble Drop Godot 4: Prostyle 1
	Team Name: GGJ 2025 - Bubble Drop Godot 4
	Authors: Daniel Cox
	Game Jam Date: January 24 - 26, 2025
	Description: This is Menu Controller for the game.
	Notes: 
	Resources:
"""

extends Control

#Signal Methods
func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/Game.tscn")

func _on_quit_button_button_down() -> void:
	get_tree().quit()

func _on_load_button_button_down() -> void:
	pass
