extends Node3D

var speed: int = 1

func _ready():
	pass
	
func _process(delta):
	var Tdirection = Vector3(1, 0, 0)
	position += Tdirection * speed * delta
