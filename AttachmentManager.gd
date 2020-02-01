extends Node


# Declare member variables here. Examples:
var AvailablePoints: Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func register(soundNode: Node2D):
	AvailablePoints.append(soundNode)
	
func unregister(soundNode: Node2D):
	AvailablePoints.erase(soundNode)
	
func get_closest(point: Vector2, maxDist: float = 10000.0) -> Node2D:
	var leastDistance : float = maxDist
	var closest: Node2D
	for node in AvailablePoints:
		var dist : float = (point - closest.position).length()
		if dist < leastDistance:
			leastDistance = dist
			closest = node
	
	return closest
