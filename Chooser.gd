extends Node2D

@export var variants:Array
@export var chosenIndex:int

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Text").text = variants[chosenIndex]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_left_button_button_down():
	_set_new_index(chosenIndex - 1)
	pass # Replace with function body.


func _on_right_button_button_down():
	_set_new_index(chosenIndex + 1)
	pass # Replace with function body.

func _set_new_index(newIndex):
	var resultIndex = newIndex
	if(newIndex < 0):
		resultIndex = variants.size() - 1
	elif(newIndex > variants.size() - 1):
		resultIndex = 0
	chosenIndex = resultIndex
	get_node("Text").text = variants[chosenIndex]
	pass
	
func get_choice_string():
	return str(variants[chosenIndex])
