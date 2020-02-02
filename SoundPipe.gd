extends SoundNode

func _ready():
	# connect to area2d if not already
	if !$Area2D.is_connected("input_event", self, "_on_Area2D_input_event"):
# warning-ignore:return_value_discarded
		$Area2D.connect("input_event", self, "_on_Area2D_input_event")

func pulse():
	$Sound.play()
	forward_sound()
	
func forward_sound():
	$Timer.start()
	yield($Timer, "timeout")
	# pulse all attachpoints
	for node in get_children():
		if node.has_method("pulse"):
			node.pulse()

