extends Node

var currentMainScene

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("main_menu_start_game_button_pressed", start_game)
	EventBus.connect("pong_board_escape_key_pressed", back_to_menu)
	EventBus.connect("main_menu_credits_button_pressed", open_credits)
	EventBus.connect("credits_back_button_pressed", back_to_menu)
	currentMainScene = get_node("main_menu")
	pass # Replace with function body.

func back_to_menu():
	currentMainScene.queue_free()
	var main_menu = preload("res://main_menu.tscn").instantiate()
	add_child(main_menu)
	currentMainScene = main_menu
	pass
	
func open_credits():
	currentMainScene.queue_free()
	var credits = preload("res://credits.tscn").instantiate()
	add_child(credits)
	currentMainScene = credits

func start_game():
	var settings = currentMainScene.get_game_settings()
	var pongBoardScene = preload("res://pong_board.tscn")
	var pongBoard = pongBoardScene.instantiate()
	var difficulty = PongBoard.Difficulty.EASY
	match settings["difficulty"].to_lower():
		"easy":
			difficulty = PongBoard.Difficulty.EASY
		"medium":
			difficulty = PongBoard.Difficulty.MEDIUM
		"impossible":
			difficulty = PongBoard.Difficulty.IMPOSSIBLE
	pongBoard.init_parameters(settings["winningScore"], difficulty, settings["againstAi"])
	
	currentMainScene.queue_free()
	add_child(pongBoard)
	currentMainScene = pongBoard
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
