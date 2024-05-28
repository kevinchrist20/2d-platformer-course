extends Node2D

@export var next_level: PackedScene = null
@export var level_time = 5
@export var is_final_level: bool = false

@onready var player_spawn_position = $Start
@onready var player = $Player

@onready var exit = $Exit
@onready var deathzone = $Deathzone

@onready var hud = $UILayer/HUD
@onready var ui_layer = $UILayer

var timer_node = null
var time_left
var hasWonGame = false

func _ready():
	player.global_position = player_spawn_position.get_spawn_position()
	var traps_group = get_tree().get_nodes_in_group("traps")
	for trap in traps_group:
		# trap.connect("touched_player", _on_trap_touched_player)
		trap.touched_player.connect(_on_trap_touched_player)
		
	exit.body_entered.connect(_on_exit_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)
	
	time_left = level_time
	hud.set_time_label(time_left)
	
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	
	add_child(timer_node)
	timer_node.start()

func _process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()
		

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = player_spawn_position.get_spawn_position()

# Signals
func _on_deathzone_body_entered(body):
	AudioPlayer.play_sound_stream("hurt")
	reset_player()

func _on_trap_touched_player():
	AudioPlayer.play_sound_stream("hurt")
	reset_player()
	
func _on_level_timer_timeout():
	if !hasWonGame:
		time_left -= 1
		if time_left < 0:
			AudioPlayer.play_sound_stream("hurt")
			reset_player()
			time_left = level_time
		
		hud.set_time_label(time_left)
	
func _on_exit_body_entered(body):
	if body is Player && (is_final_level || next_level != null):
		exit.animate()
		player.is_input_active = false
		hasWonGame = true
		await get_tree().create_timer(1.5).timeout
		
		if is_final_level:
			ui_layer.show_win_screen(true)
		else:
			get_tree().change_scene_to_packed(next_level)
