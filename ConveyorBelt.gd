extends Node2D

class_name BeltMover

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var children = []
export var pixelsPerSecond = 200;
# Called when the node enters the scene tree for the first time.
func _ready():
	children = get_children();
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in children:
		child.position += Vector2(0,pixelsPerSecond * delta);
