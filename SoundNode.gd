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
		var to = global_transform.xform_inv(nearest_attach.global_position) / \
				(global_scale * global_scale)
		draw_line(from, to, Color.aqua)
		
func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		if !(event.button_mask & BUTTON_MASK_LEFT):
			attach(nearest_attach)
			moving = false
		if moving:
			global_position = event.position + drag_offset
			if has_input:
				nearest_attach = \
					AttachmentManager.get_closest(\
						global_position, self, 100)
				if nearest_attach != null:
					var diff: Vector2 = global_position - nearest_attach.global_position
					global_rotation = atan2(diff.x, -diff.y)
					
			update()
			get_tree().set_input_as_handled()

func _on_Area2D_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton:
		var is_dragging = event.is_pressed() && event.button_mask & BUTTON_MASK_LEFT
		if moving && !is_dragging:
			attach(nearest_attach)
		if !moving && is_dragging:
			detatch()
			drag_offset = global_position - event.position
		moving = is_dragging
		
		update()
		get_tree().set_input_as_handled()

func attach(attach_point: AttachPoint):
	if attach_point != null:
		reparent(attach_point)
		attach_point.set_child(self)
		for node in get_children():
			if node.has_method("set_active"):
				node.set_active(true)

func detatch():
	for node in get_children():
		if node.has_method("set_active"):
			node.set_active(false)
	if get_parent().has_method("loose_child"):
		get_parent().loose_child()
	reparent(get_tree().root)
	

func reparent(parent: Node):
	var trans = global_transform
	get_parent().remove_child(self)
	parent.add_child(self)
	global_transform = trans
	
