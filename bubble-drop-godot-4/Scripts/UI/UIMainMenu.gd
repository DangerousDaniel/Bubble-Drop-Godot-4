extends Control

#Signal Methods
func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/GameNew.tscn")

func _on_quit_button_button_down() -> void:
	get_tree().quit()

func _on_load_button_button_down() -> void:
	pass
