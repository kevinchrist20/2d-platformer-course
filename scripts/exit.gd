extends Area2D

@onready var sprite = $AnimatedSprite2D

func animate():
	sprite.play("default")
