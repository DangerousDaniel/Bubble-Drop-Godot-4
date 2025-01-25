extends Control

func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/Game.tscn")

func _on_load_game_button_down() -> void:
	pass # Replace with function body.

func _on_quit_button_button_down() -> void:
	get_tree().quit()
