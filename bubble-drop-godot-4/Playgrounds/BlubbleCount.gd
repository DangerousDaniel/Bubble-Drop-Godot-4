extends Control

@export var count = 0
@export var maxCount = 3

signal BlubbleUpCountUIEvent
signal BlubbleDownCountUIEvent 

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	#test code for Counter
	if Input.is_action_just_pressed("ui_up"):
		emit_signal("BlubbleUpCountUIEvent")
	if Input.is_action_just_pressed("ui_down"):
		emit_signal("BlubbleDownCountUIEvent")

func _on_blubble_up_count_ui_event() -> void:
	if count <= maxCount && count != maxCount:
		count = count + 1
		$Counter.text = str("x ", count)
		print(count)

func _on_blubble_down_count_ui_event() -> void:
	if count <= maxCount && count != 0:
		count = count - 1
		$Counter.text = str("x ", count)
		print(count)
