extends Control

func _ready() -> void:
	get_tree().paused = false

func ActiveScreen():
	$Panel.show()
	get_tree().paused = true

func _on_play_again_button_button_down() -> void:
	get_tree().reload_current_scene() 

func _on_back_to_main_menu_button_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenuLevel.tscn")

func _on_quit_button_button_down() -> void:
	get_tree().quit()
