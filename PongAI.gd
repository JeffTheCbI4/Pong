extends Object
class_name PongAI

var _controlledEntity:Player
var _isUnbeatable:bool = false

func init_ai(controlledEntity, isUnbeatable):
	_controlledEntity = controlledEntity
	_isUnbeatable = isUnbeatable
	pass

func process_ai(ballPosition:Vector2):
	if (_isUnbeatable):
		var playerX = _controlledEntity.global_position.x
		var ballY = ballPosition.y
		_controlledEntity.global_position = Vector2(playerX, ballY)
		return
	var entityY = _controlledEntity.global_position.y
	var ballY = ballPosition.y
	if (entityY - 37.5 > ballY):
		_controlledEntity.move_up()
	elif (entityY + 37.5 < ballY):
		_controlledEntity.move_down()
	pass
