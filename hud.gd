extends CanvasLayer

signal  start_game


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	#wait until message timer has counted down
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the creeps !"
	$Message.show()	
	# Make a one-shot timer and wait for it to finish
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)
	$ScoreLabel.show()

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()
