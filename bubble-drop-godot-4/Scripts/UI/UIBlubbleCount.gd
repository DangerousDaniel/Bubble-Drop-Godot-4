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
