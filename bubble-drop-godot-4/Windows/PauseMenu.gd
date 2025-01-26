"""
	Project Name: Bubble Drop Godot 4: Prostyle 1
	Team Name: GGJ 2025 - Bubble Drop Godot 4
	Authors: Daniel
	Game Jam Date: January 24 - 26, 2025
	Description: This is the class for the Pause Menu
	Notes: 
	Resources:
"""

extends Control

#Getters and Setters
var IsGamePaused : bool = false:
	get:
		return IsGamePaused
	set(value):
		IsGamePaused = value

#Game Events Methods
func ToggleGamePaused():
	IsGamePaused = !IsGamePaused
	get_tree().paused = IsGamePaused	

#Godot Methods
func _process(delta: float) -> void:
	#Pause Inputs
	if (Input.is_action_just_pressed("ui_cancel")):
		if not $Panel.is_visible_in_tree():
			$Panel.show()
		else: 
			$Panel.hide()

#Signal Methods			
func _on_back_to_main_menu_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/MainMenu/MainMenuLevel.tscn")

func _on_back_to_game_button_button_down() -> void:
	$Panel.hide()
