extends Node3D

var speed: int = 100
var direction: Vector3

func _ready():
	$Timer.start()
	
func _process(delta):
	position += direction * speed * delta


func _on_timer_timeout():
	queue_free()
