extends Node2D


# Declare member variables here. Examples:
export var bpm = 60
export var pulseCurve : Curve

onready var beatTime =  60.0/bpm

var pulseState
var beatWaiter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	beatWaiter += delta
	if beatWaiter > beatTime:
		beatWaiter = fmod(beatWaiter, beatTime)
		pulseState = pulse()
	
	if(pulseState != null && pulseState.is_valid()):
		pulseState = pulseState.resume(delta)
	pass

func pulse():
	var time: float = 0
	while time < 1:
		var scale = pulseCurve.interpolate(time)
		$Sprite.scale = Vector2(scale, scale)
		time += yield()
		print(time)
	$Sprite.scale = Vector2(1, 1)
	pass
