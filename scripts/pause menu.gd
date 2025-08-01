extends Control

signal resume
signal restart
signal options
signal main_menu



func _on_resume_pressed():
	emit_signal("resume")

func _on_options_pressed():
	emit_signal("restart")
	


func _on_restart_pressed():
	emit_signal("options")
	


func _on_main_menu_pressed():
	emit_signal("main_menu")
	
