"""
	Project Name: Bubble Drop Godot 4: Prostyle 1
	Team Name: GGJ 2025 - Bubble Drop Godot 4
	Authors: Daniel
	Game Jam Date: January 24 - 26, 2025
	Description: This is the bubble counter controller for the Bubble Counter UI.
	Notes: 
	Resources:
"""

extends Control

#Class Variables
@export var count : int = 0
@export var maxCount : int = 10

#GDScript Methods
func _ready() -> void:
	BubbleCountSetMaxCount()
	
func BubbleCountDownUI():
	if count <= maxCount && count != 0:
		count = count - 1
		$Counter.text = str(count)
		print(count)

func BubbleCountSetMaxCount():
	count = maxCount
	$Counter.text = str(count)
