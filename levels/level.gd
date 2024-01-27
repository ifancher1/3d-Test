extends Node3D
class_name LevelParent

#initialize all required scenes
var projectile_scene: PackedScene = preload("res://projectiles/projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_fp_fire_weapon(pos, direction):
	_create_projectile(pos, direction)

#creates a projectile object with a starting position and a direction vector
func _create_projectile(pos, direction):
	var proj = projectile_scene.instantiate() as Node3D
	proj.position = pos
	proj.direction = direction
	$Projectiles.add_child(proj)
