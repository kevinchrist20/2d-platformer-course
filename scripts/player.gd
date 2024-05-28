extends CharacterBody2D

class_name Player

@export var SPEED = 200.0
const JUMP_VELOCITY = -400.0
var is_input_active = true

@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500

	var direction = 0
	if is_input_active:
	## Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump(JUMP_VELOCITY)

		direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.flip_h = direction == -1
	
	velocity.x =  direction * SPEED
	move_and_slide()
	
	update_animations(direction)


func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
			
			
func jump(force):
	AudioPlayer.play_sound_stream("jump")
	velocity.y = force
	
