extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 6

signal fireWeapon(pos, direction)
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var sprint: int
var doublejump: int = 2

var playerdirection: Vector3

@export var sensitivity = 1000


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	#reset double jump counter
	if is_on_floor():
		doublejump = 2

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and doublejump > 0:
		velocity.y = JUMP_VELOCITY
		doublejump -= 1
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
	
	if event.is_action_pressed("quit"):
		get_tree().quit()
	
	if event.is_action_pressed("left_click"):
		playerdirection = -$Camera/Camera3D.get_global_transform().basis.z
		print($Camera/Camera3D.get_global_transform().basis.z)
		#print(global_position)
		fireWeapon.emit(global_position, playerdirection)
