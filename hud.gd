extends CanvasLayer

signal start_game

signal move_up
signal move_down
signal move_left
signal move_right
signal stop_vertical
signal stop_horizontal

func update_score(value):
	$MarginContainer/Score.text = str(value)


func update_timer(value):
	$MarginContainer/Time.text = str(value)


func show_message(text):
	$Message.text = text
	$Message.show()
	$Timer.start()


func _on_timer_timeout():
	$Message.hide()


func _on_start_button_pressed():
	$StartButton.hide()
	show_touch_controls()
	$Message.hide()
	start_game.emit()

func show_game_over():
	show_message("Game Over")
	await $Timer.timeout
	$StartButton.show()
	hide_touch_controls()
	$Message.text = "Coin Dash!"
	$Message.show()


func hide_touch_controls():
	$B_Up.hide()
	$B_Down.hide()
	$B_Right.hide()
	$B_Left.hide()

func show_touch_controls():
	$B_Up.modulate.a = 0.5  # 50% transparencia
	$B_Down.modulate.a = 0.5
	$B_Right.modulate.a = 0.5
	$B_Left.modulate.a = 0.5
	
	$B_Up.show()
	$B_Down.show()
	$B_Right.show()
	$B_Left.show()

# "ui_left", "ui_right", "ui_up", "ui_down"
func _on_b_up_pressed():
	print("Up pressed")
	move_up.emit()

func _on_b_down_pressed():
	print("Down pressed")
	move_down.emit()

func _on_b_right_pressed():
	print("Right pressed")
	move_right.emit()

func _on_b_left_pressed():
	print("Left pressed")
	move_left.emit()

func _on_b_up_released():
	print("Up released")
	stop_vertical.emit()

func _on_b_down_released():
	print("Down released")
	stop_vertical.emit()

func _on_b_right_released():
	print("Right released")
	stop_horizontal.emit()

func _on_b_left_released():
	print("Left released")
	stop_horizontal.emit()
