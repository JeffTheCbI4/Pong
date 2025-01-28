extends Node2D

var maxScore:int = 1
var againstAi:bool = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("GameSettings/MaxScoreValueLabel").text = str(maxScore)
	get_node("GameSettings/AICheckBox").button_pressed = againstAi
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_node("MainButtons").visible = false
	get_node("GameSettings").visible = true
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
	pass # Replace with function body.

func setMaxScore(newScore):
	if (newScore < 1):
		maxScore = 1
	elif(newScore > 9):
		maxScore = 9
	else:
		maxScore = newScore
	get_node("GameSettings/MaxScoreValueLabel").text = str(maxScore)

func _on_max_score_up_button_button_down():
	setMaxScore(maxScore + 1)
	pass # Replace with function body.


func _on_max_score_down_button_button_down():
	setMaxScore(maxScore - 1)
	pass # Replace with function body.


func _on_ai_check_box_toggled(toggled_on):
	againstAi = toggled_on
	get_node("GameSettings/AICheckBox").button_pressed = againstAi
	get_node("GameSettings/Chooser").visible = toggled_on
	pass # Replace with function body.


func _on_start_game_button_button_down():
	EventBus.emit_signal("main_menu_start_game_button_pressed")
	pass # Replace with function body.

func _on_cancel_button_button_down():
	get_node("MainButtons").visible = true
	get_node("GameSettings").visible = false
	pass # Replace with function body.


func _on_play_button_button_down():
	get_node("MainButtons").visible = false
	get_node("GameSettings").visible = true
	pass # Replace with function body.
	
func get_game_settings():
	return {
		"againstAi": againstAi,
		"difficulty": get_node("GameSettings/Chooser").get_choice_string(),
		"winningScore": maxScore
	}


func _on_credits_button_down():
	EventBus.emit_signal("main_menu_credits_button_pressed")
	pass # Replace with function body.
