extends Node2D


# Declare member variables here. Examples:
var moving: bool = false
var nearestAttach: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if moving:
		nearestAttach = AttachmentManager.get_closest(global_position)
		
func _draw():
	if nearestAttach != null:
		var from = Vector2(0, 0)
		var to = transform.xform_inv(nearestAttach.global_position)
		draw_line(from, to, Color.red)


func _on_Area2D_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseMotion && \
			event.button_mask & BUTTON_MASK_LEFT:
		position += event.relative
		update()
		get_tree().set_input_as_handled()
		
	if event is InputEventMouseButton:
		moving = event.is_pressed()
		if !moving:
			nearestAttach = null
		update()
		get_tree().set_input_as_handled()
