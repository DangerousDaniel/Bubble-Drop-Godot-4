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
@export var maxCount : int = 3

signal BubbleUpCountUIEvent
signal BubbleDownCountUIEvent 

#GDScript Methods
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	#test code for Counter
	if Input.is_action_just_pressed("ui_up"):
		emit_signal("BubbleUpCountUIEvent")
	if Input.is_action_just_pressed("ui_down"):
		emit_signal("BubbleDownCountUIEvent")

#Signal Methods
func _on_bubble_up_count_ui_event() -> void:
	if count <= maxCount && count != maxCount:
		count = count + 1
		$Counter.text = str("x ", count)
		print(count)

func _on_bubble_down_count_ui_event() -> void:
	if count <= maxCount && count != 0:
		count = count - 1
		$Counter.text = str("x ", count)
		print(count)
