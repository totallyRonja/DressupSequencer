extends Node2D
class_name SoundNode

export var has_input = true

var moving: bool = false
var nearest_attach: AttachPoint
var drag_offset: Vector2

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
		
func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		if !(event.button_mask & BUTTON_MASK_LEFT):
			moving = false
		if moving:
			global_position = event.position + drag_offset
			if has_input:
				nearest_attach = \
				AttachmentManager.get_closest(global_position, self, 100)
			update()
			get_tree().set_input_as_handled()

func _on_Area2D_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton:
		var is_dragging = event.is_pressed() && event.button_mask & BUTTON_MASK_LEFT
		if moving && !is_dragging:
			if nearest_attach != null:
				reparent(nearest_attach)
				nearest_attach.set_child(self)
		if !moving && is_dragging:
			drag_offset = global_position - event.position
			if get_parent().has_method("loose_child"):
					get_parent().loose_child()
			reparent(get_tree().root)
		moving = is_dragging
		
		update()
		get_tree().set_input_as_handled()

func reparent(parent: Node):
	var trans = global_transform
	get_parent().remove_child(self)
	parent.add_child(self)
	global_transform = trans
	
