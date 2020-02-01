extends Node2D

var child: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_child(newChild: Node2D):
	assert(newChild == null)
	child = newChild
	AttachmentManager.unregister(self)

func loose_child(assertHasChild: bool = true):
	if(assertHasChild):
		assert(child != null)
	AttachmentManager.register(self)
