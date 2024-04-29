extends Control


func _on_resume_button_pressed():
	visible = false
	get_tree().paused = false

func _on_exit_button_pressed():
	get_tree().quit()
