extends CharacterBody3D

var health: int = 100

func _process(delta):
	if (health <= 0):
		queue_free()
