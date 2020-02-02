extends Node2D

export var things: Array = []


func _ready():
	$Timer.start()
# warning-ignore:return_value_discarded
	$Timer.connect("timeout", self, "spawn")
	
	var user_seed: int
	if OS.has_environment("USERNAME"):
		var name = OS.get_environment("USERNAME")
		user_seed = name.hash()
	else:
		user_seed = OS.get_unix_time()
	seed(user_seed)

func spawn():
	var clone: Node2D
	while !clone is SoundNode:
		if clone != null:
			clone.queue_free()
		var packed: PackedScene = things[rand_range(0, len(things))]
		clone = packed.instance()
		
	get_tree().root.add_child(clone)
	clone.global_position = global_position
	clone.on_belt = true
	clone.rotation = rand_range(-.5, .5)
