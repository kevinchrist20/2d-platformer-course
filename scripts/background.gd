extends ParallaxBackground

@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/Blue.png")
@export var scroll_speed = 20

@onready var background_sprite = $ParallaxLayer/Sprite2D

func _ready():
	background_sprite.texture = bg_texture

func _process(delta):
	background_sprite.region_rect.position += delta * Vector2(scroll_speed, -scroll_speed)
	
	# background_sprite.region_rect.position should not go beyond the image's original size
	if background_sprite.region_rect.position >= Vector2(64, 64):
		background_sprite.region_rect.position = Vector2.ZERO
