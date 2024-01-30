extends Node3D

var speed: int = 10
var direction: Vector3

@onready var mesh = $Area3D/MeshInstance3D
@onready var particles = $GPUParticles3D

func _ready():
	$Timer.start()
	
func _process(delta):
	position += direction * speed * delta

func _on_timer_timeout():
	queue_free()



func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("hit")
	mesh.visible = false
	particles.emitting = true
	await get_tree().create_timer(1.0).timeout
	queue_free()
