extends ParallaxBackground

@export var scroll_speed = 20

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
