extends Node2D

class_name BeltMover

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var pixelsPerSecond = 200;
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		child.position += Vector2(0,pixelsPerSecond * delta);
		if child.global_position.y > 780:
			child.position = Vector2(0,-100)
