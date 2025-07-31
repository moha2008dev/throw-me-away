extends Control


func _ready():
	$Panel/sfx.pressed = global_vars_funcs.sfx
	$"Panel/v-sync".pressed = global_vars_funcs.vsync
	$"Panel/Show FPS".pressed = global_vars_funcs.show_fps
	$Panel/resolution.clear()
	for i in range(global_vars_funcs.resolutions.size()):
		var res = global_vars_funcs.resolutions[i]
		$Panel/resolution.add_item("%d x %d" % [res.x, res.y])
	for i in range(global_vars_funcs.resolutions.size()):
		if global_vars_funcs.resolutions[i] == OS.window_size:
			$Panel/resolution.select(i)
			break
	$Panel/screen.clear()
	$Panel/screen.add_item("fullscreen")
	$Panel/screen.add_item("windowed fullscreen")
	$Panel/screen.add_item("windowed")
	$Panel/fps.clear()
	$Panel/fps.add_item("unlimited")
	$Panel/fps.add_item("30")
	$Panel/fps.add_item("60")
	$Panel/fps.add_item("144")
	$Panel/screen.select(global_vars_funcs.screen)
	$Panel/resolution.select(global_vars_funcs.resolution)
	$Panel/fps.select(global_vars_funcs.fps)

func _process(delta):
	$Panel/resolution.select(global_vars_funcs.resolution)
#	print(global_vars_funcs.fps)
#	print(global_vars_funcs.sfx)
#	print(global_vars_funcs.resolution)
#	print(global_vars_funcs.screen)
#	print(global_vars_funcs.auto_save)

func _on_exit_pressed():
	Global.change_scene("res://scenes/main_menu.tscn")


func _on_sfx_toggled(button_pressed):
	global_vars_funcs.sfx = button_pressed
	global_vars_funcs.save_options()

func _on_vsync_toggled(button_pressed):
	global_vars_funcs.vsync = button_pressed
	global_vars_funcs.save_options()

func _on_Show_FPS_toggled(button_pressed):
	global_vars_funcs.show_fps = button_pressed
	global_vars_funcs.save_options()

func _on_resolution_item_selected(index):
	global_vars_funcs.resolution = index
	global_vars_funcs.save_options()

func _on_screen_item_selected(index):
	global_vars_funcs.screen = index
	global_vars_funcs.save_options()

func _on_fps_item_selected(index):
	global_vars_funcs.fps = index
	global_vars_funcs.save_options()

func _on_reset_pressed():
	var file = Directory.new()
	if file.file_exists("user://options.cfg"):
		file.remove("user://options.cfg")
	global_vars_funcs.load_options()
	global_vars_funcs.save_options()
	get_tree().reload_current_scene()


