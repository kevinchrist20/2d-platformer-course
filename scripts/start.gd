extends StaticBody2D

@onready var spawn_position_node = $SpawnPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_spawn_position():
	return spawn_position_node.global_position
