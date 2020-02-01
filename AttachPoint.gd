extends Node2D
class_name AttachPoint

var child: Node2D
var active: bool = false setget set_active

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_child(newChild: Node2D):
	assert(newChild != null)
	child = newChild
	AttachmentManager.unregister(self)

func loose_child(assertHasChild: bool = true):
	if(assertHasChild):
		assert(child != null)
	child = null
	AttachmentManager.register(self)
	
func set_active(value: bool):
	if value && !active:
		AttachmentManager.register(self)
	if !value:
		#danger! can still have a kid if inactive, just not get assigned a new one
		AttachmentManager.unregister(self)
	active = value
	pass

func pulse():
	if child != null && child.has_method("pulse"):
		child.pulse()
