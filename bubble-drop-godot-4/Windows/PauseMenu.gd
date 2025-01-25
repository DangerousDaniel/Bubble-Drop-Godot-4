extends Control

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_cancel")):
		if not $Panel.is_visible_in_tree():
			$Panel.show()
		else: 
			$Panel.hide()
			
func _on_back_to_main_menu_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/MainMenu/MainMenuLevel.tscn")

func _on_back_to_game_button_button_down() -> void:
	$Panel.hide()
