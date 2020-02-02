extends Node2D
class_name ConveyorBelt

const move_speed = 50
export var tile_size = 156

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Mover.position.y += move_speed * delta
	var first_child: Node2D = $Mover.get_child(0)
	while first_child.global_position.y - tile_size/2 >= 0:
		var last: Sprite = $Mover.get_child($Mover.get_child_count()-1)
		$Mover.move_child(last, 0)
		last.position.y = first_child.position.y - tile_size
		first_child = last
