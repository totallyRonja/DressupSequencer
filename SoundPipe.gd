extends SoundNode

var state: GDScriptFunctionState
var sprite: Sprite

func _ready():
	for kid in get_children():
		if kid is Sprite:
			sprite = kid
	
	if !$Area2D.is_connected("input_event", self, "_on_Area2D_input_event"):
# warning-ignore:return_value_discarded
		$Area2D.connect("input_event", self, "_on_Area2D_input_event")

func _process(delta):
	if state != null && state.is_valid():
		state = state.resume(delta)

func pulse():
	$Sound.play()
	forward_sound()
	state = scalePulse()
	
func forward_sound():
	$Timer.start()
	yield($Timer, "timeout")
	$Timer.stop()
	# pulse all attachpoints
	for node in get_children():
		if node.has_method("pulse"):
			node.pulse()

func scalePulse():
	var time = 0
	while time < 0.25:
		var pulseScale = 1 + 0.5 * sin(time * PI*2*2)
		sprite.scale = Vector2(pulseScale, pulseScale)
		time += yield()
