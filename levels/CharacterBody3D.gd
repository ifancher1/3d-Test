extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 6

var sprint: int
var doublejump: int = 2

@export var sensitivity = 1000

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_on_floor():
		doublejump = 2
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and doublejump > 0:
		velocity.y = JUMP_VELOCITY
		doublejump -= 1
		print(doublejump)

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
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / sensitivity
		$CameraPivot.rotation.x -= event.relative.y / sensitivity
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x, deg_to_rad(-45), deg_to_rad(90))
