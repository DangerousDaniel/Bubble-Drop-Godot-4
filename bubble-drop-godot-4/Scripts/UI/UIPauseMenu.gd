extends Control

#Getters and Setters
var IsGamePaused : bool = false:
	get:
		return IsGamePaused
	set(value):
		IsGamePaused = value

#Game Events Methods
func ToggleGamePaused():
	if IsGamePaused == false:
		IsGamePaused = true
		get_tree().paused = true
	elif IsGamePaused ==  true:
		IsGamePaused = false
		get_tree().paused = false	

#Godot Methods
func _process(delta: float) -> void:
	#Pause Inputs
	if (Input.is_action_just_pressed("ui_cancel")):
		if not $Panel.is_visible_in_tree():
			ToggleGamePaused()
			$Panel.show()
		else:
			ToggleGamePaused()
			$Panel.hide()
			

#Signal Methods			
func _on_back_to_main_menu_button_button_down() -> void:
	ToggleGamePaused()
	get_tree().change_scene_to_file("res://Scenes/MainMenuLevel.tscn")

func _on_back_to_game_button_button_down() -> void:
	ToggleGamePaused()
	$Panel.hide()
