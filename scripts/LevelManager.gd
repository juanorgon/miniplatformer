extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var obstacles = get_tree().get_nodes_in_group("obstacle")
	for obstacle in obstacles:
		obstacle.body_entered.connect(_on_deadzone_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_deadzone_entered(arg1):
	get_tree().reload_current_scene()
