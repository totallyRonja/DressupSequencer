extends SoundNode

var state: GDScriptFunctionState
var sprite: Sprite

func _ready():
	for kid in get_children():
		if kid is Sprite:
			sprite = kid

func _process(delta):
	if state != null && state.is_valid():
		state = state.resume(delta)

func pulse():
	$Sound.play()
# warning-ignore:function_may_yield
	state = scalePulse()

func scalePulse():
	var time = 0
	while time < 0.25:
		var pulseScale = 1 + 0.5 * sin(time * PI*2*2)
		sprite.scale = Vector2(pulseScale, pulseScale)
		time += yield()
	
