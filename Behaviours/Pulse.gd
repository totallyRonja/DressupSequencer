extends "res://SoundNode.gd"

export var bpm = 60
export var pulseCurve : Curve

onready var beatTime =  60.0/bpm

var pulseState: GDScriptFunctionState
var beatWaiter = 0

func _ready():
	for kid in get_children():
		if kid.has_method("loose_child"):
			kid.loose_child(false)

func _process(delta):
	beatWaiter += delta
	if beatWaiter > beatTime:
		beatWaiter = fmod(beatWaiter, beatTime)
# warning-ignore:function_may_yield
		pulseState = pulse()
	
	if(pulseState != null && pulseState.is_valid()):
		pulseState = pulseState.resume(delta)

func pulse():
	var time: float = 0
	$Sound.play()
	while time < 1:
		var scale = pulseCurve.interpolate(time)
		$Sprite.scale = Vector2(scale, scale)
		time += yield()
		print(time)
	$Sprite.scale = Vector2(1, 1)
