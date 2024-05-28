extends Node

var hurt_sound = preload("res://assets/audio/hurt.wav")
var jump_sound = preload("res://assets/audio/jump.wav")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_sound_stream(stream_name: String):
	var stream = null
	if stream_name == "hurt":
		stream = hurt_sound
	elif stream_name == "jump":
		stream = jump_sound
	else:
		print("Invalid stream name")
		return
		
	var audio_stream_player = AudioStreamPlayer.new()	
	audio_stream_player.stream = stream
	audio_stream_player.name = "Player Sound Stream"
	
	add_child(audio_stream_player)
	audio_stream_player.play()
	
	await audio_stream_player.finished
	audio_stream_player.queue_free()
