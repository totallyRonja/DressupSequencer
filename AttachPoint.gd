extends Node2D
class_name AttachPoint

var child: Node2D

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
	AttachmentManager.register(self)

func pulse():
	if child != null && child.has_method("child"):
		child.pulse()
