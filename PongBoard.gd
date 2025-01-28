extends Node2D
class_name PongBoard

@export var player1Score: int = 0
@export var player2Score: int = 0
@export var _winningScore: int = 0

@export var _difficulty:Difficulty
@export var _isAgainstAI:bool

var ai:PongAI

enum { LEFT, RIGHT }
enum Difficulty { EASY, MEDIUM, IMPOSSIBLE }

func init_parameters(winningScore, difficulty, isAgainstAI):
	_difficulty = difficulty
	_isAgainstAI = isAgainstAI
	_winningScore = winningScore
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Player1Score").text = str(player1Score)
	get_node("Player2Score").text = str(player2Score)
	
	if (_isAgainstAI):
		var player2 = get_node("Player2")
		ai = PongAI.new()
		ai.init_ai(player2, _difficulty == Difficulty.IMPOSSIBLE)
		player2.speed = 20 if _difficulty == Difficulty.MEDIUM else 10
	_start_round(LEFT)
	pass # Replace with function body.


func _start_round(ball_direction):
	var ball = get_node("Ball")
	if (!ball.visible):
		ball.visible = true
	ball.global_position = Vector2(640, 360)
	ball.speed = 8
	var x = 0
	if (ball_direction == LEFT):
		x = -1
	elif (ball_direction == RIGHT):
		x = 1
	var y = randf_range(-1,1)
	if (y > 0 && y < 0.5):
		y += 0.3
	elif (y < 0 && y > -0.5):
			y -= 0.3
	ball.direction = Vector2(x,y)
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_key_label_pressed(KEY_R)):
		_start_game()
	if (Input.is_key_label_pressed(KEY_ESCAPE)):
		EventBus.emit_signal("pong_board_escape_key_pressed")
	controlPlayer1()
	if ai:
		ai.process_ai(get_node("Ball").global_position)
	else:
		controlPlayer2()
	pass

func controlPlayer1():
	if (Input.is_key_pressed(KEY_W)):
		get_node("Player1").move_up()
	if (Input.is_key_pressed(KEY_S)):
		get_node("Player1").move_down()
		
func controlPlayer2():
	if (Input.is_action_pressed("ui_up")):
		get_node("Player2").move_up()
	if (Input.is_action_pressed("ui_down")):
		get_node("Player2").move_down()

func _on_player_1_field_area_entered(area):
	player2Score += 1
	get_node("Player2Score").text = str(player2Score)
	_play_score_sound()
	if (player2Score >= _winningScore):
		_end_game("Player 2")
	else:
		_start_round(RIGHT)
	pass # Replace with function body.


func _on_player_2_field_area_entered(area):
	player1Score += 1
	get_node("Player1Score").text = str(player1Score)
	_play_score_sound()
	if (player1Score >= _winningScore):
		_end_game("Player 1")
	else:
		_start_round(LEFT)
	pass # Replace with function body.

func _play_score_sound():
	get_node("ScoreSound").play()
	pass
	
func _start_game():
	var labels = get_node("Labels")
	labels.visible = false
	player1Score = 0
	player2Score = 0
	get_node("Player1Score").text = str(player1Score)
	get_node("Player2Score").text = str(player2Score)
	_start_round(LEFT)
	pass
	
func _end_game(winner):
	var ball = get_node("Ball")
	ball.global_position = Vector2(640, 360)
	ball.speed = 0
	ball.visible = false
	
	var WinningLabel = get_node("Labels/WinningLabel")
	WinningLabel.text = winner + " wins!"
	get_node("Labels").visible = true
	pass
