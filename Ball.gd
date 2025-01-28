extends Node2D

@export var direction:Vector2
@export var speed:float
@export var maxSpeed:float
@export var speedIncrease:float

var isColliding

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + direction.normalized() * speed)
	query.collision_mask = 0b0001
	query.collide_with_areas = true
	var onRaycastResult = space_state.intersect_ray(query)
	if onRaycastResult:
		bounce(onRaycastResult)
	else:
		global_position = global_position + direction.normalized() * speed
	pass

func bounce(rayCastResult):
	var rayNormalX = rayCastResult.normal.x
	var rayNormalY = rayCastResult.normal.y
	#var newY =  rayCastResult.position.y - (25 * scale.y if rayNormalY != 0 else 25 * scale.y  * direction.normalized().y/direction.normalized().x)
	#var newX =  rayCastResult.position.x - (25 * scale.x if rayNormalX != 0 else 25 * scale.x * direction.normalized().y/direction.normalized().x)
	global_position = rayCastResult.position - Vector2(14,14) * direction.normalized()
	#global_position = Vector2(newX,newY)
	var dot = direction.dot(rayCastResult.normal)
	var newDir = -2 * (dot) * rayCastResult.normal + direction
	direction = newDir
	var newSpeed = speed + speedIncrease
	if (newSpeed > maxSpeed):
		speed = maxSpeed
	else:
		speed = newSpeed
	get_node("BounceSound").play()

func _on_area_2d_area_entered(area):
	isColliding = true
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	isColliding = false
	pass # Replace with function body.
