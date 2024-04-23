extends Control


func _on_resume_button_click_end():
	visible = false
	get_tree().paused = false

func _on_exit_button_click_end():
	get_tree().quit()
