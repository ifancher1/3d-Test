extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 6

signal fireWeapon(pos, direction)
signal openUI()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var sprint: int
var doublejump: int = 2
var airborne: bool

var playerdirection: Vector3

@export var sensitivity = 1000

#raycast representing the direction and position of the gun barrel
@onready var gunDir = $Camera/Camera3D/Weapon/Barrel
@onready var camera = $Camera/Camera3D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		airborne = true
	#reset double jump counter
	if is_on_floor():
		doublejump = 2
		airborne = false

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and doublejump > 0:
		velocity.y = JUMP_VELOCITY
		doublejump -= 1
	
	# Get the input direction and handle the movement/deceleration.
	
	var input_dir = Input.get_vector("right", "left", "backward", "forward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#player will eneter a sprint when the shift key is pressed
	if Input.is_action_pressed("sprint"):
		sprint = 5
	else:
		sprint = 0
	
	if direction:
		velocity.x = direction.x * (SPEED + sprint)
		velocity.z = direction.z * (SPEED + sprint)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
func _input(event):
	#use the mouse movement to rotate the camera and player
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / sensitivity
		$Camera/Camera3D.rotation.x -= event.relative.y / sensitivity
		$Camera/Camera3D.rotation.x = clamp($Camera/Camera3D.rotation.x, deg_to_rad(-70), deg_to_rad(90))
	
	#quit the game if ` key is pressed
	if event.is_action_pressed("quit"):
		get_tree().quit()
	
	#open the menu if the esc key is pressed
	if event.is_action_pressed("openMenu"):
		openUI.emit()
	
	#fire a projectile from the barrel of the gun when the player left clicks
	if event.is_action_pressed("left_click"):
		#subtract the camera direction from the gun barrel direction in order to create a vector
		#that goes from the barrel to the center of the screen. This ensures that the projectile
		#is always traveling to where the player is aiming 
		fireWeapon.emit(gunDir.global_position, gunDir.global_transform.basis.z - camera.global_transform.basis.z)
