extends Node2D
class_name SoundNode

export var has_input = true

var moving: bool = false
var nearest_attach: AttachPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
		
func _draw():
	if nearest_attach != null:
		var from = Vector2(0, 0)
		var to = global_transform.xform_inv(nearest_attach.global_position) / (scale * scale)
		draw_line(from, to, Color.aqua)

func _on_Area2D_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseMotion && \
			event.button_mask & BUTTON_MASK_LEFT:
		global_position += event.relative
		if has_input:
			nearest_attach = AttachmentManager.get_closest(global_position, self)
		update()
		get_tree().set_input_as_handled()
		
	if event is InputEventMouseButton:
		moving = event.is_pressed()
		if !moving:
			if nearest_attach != null:
				reparent(nearest_attach)
				nearest_attach.set_child(self)
		
		update()
		get_tree().set_input_as_handled()

func reparent(parent: Node2D):
	var trans = global_transform
	get_parent().remove_child(self)
	parent.add_child(self)
	global_transform = trans
	
