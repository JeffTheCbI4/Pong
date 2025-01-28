extends Node2D
class_name Player

@export var speed: float
@export var topMaxPoint: float
@export var bottomMaxPoint: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func move_up():
	global_position.y -= speed
	if (global_position.y - get_half() < topMaxPoint):
		global_position.y = topMaxPoint + get_half()
	pass

func move_down():
	global_position.y += speed
	if (global_position.y + get_half() > bottomMaxPoint):
		global_position.y = bottomMaxPoint - get_half()
	pass

func get_half():
	return 37.5

func _on_area_2d_area_entered(area):
	
	pass # Replace with function body.
