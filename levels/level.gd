extends Node3D
class_name LevelParent

#initialize all required scenes
var projectile_scene: PackedScene = preload("res://projectiles/projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	$Crosshair.visible = false
	#print($PlayerFp/Camera/Camera3D.global_transform.basis.z)
	#print($PlayerFp/Camera/Camera3D/Weapon/Barrel.global_transform.basis.z)
	#print($PlayerFp/Camera/Camera3D/Weapon/Barrel.global_transform.basis.z - $PlayerFp/Camera/Camera3D.global_transform.basis.z)


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
	#print(direction)
	$Projectiles.add_child(proj)


func _on_player_fp_open_ui():
	$Crosshair.visible = !$Crosshair.visible
	$UI.visible = !$UI.visible
	if $UI.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_ui_close():
	get_tree().quit()
