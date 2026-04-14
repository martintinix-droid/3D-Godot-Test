extends CharacterBody3D
# Get mouse input
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
# input handler for the mouse motion
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		#horizontal rotation
		rotation_degrees.y -= event.relative.x*0.5
		#vertical rotation and clamping
		%Head.rotation_degrees.x-=event.relative.y*0.2
		%Head.rotation_degrees.x=clamp(%Head.rotation_degrees.x,-90,90)
		# UI inputs for future menu
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#handling physics		
func _physics_process(delta): 
	const SPEED=5.5
	#Steing up controller
	var input_direction_2D=Input.get_vector(
		"move_left",
		"move_rigth",
		"move_foward",
		"move_back"
	)
	#truning input into 3D vector
	var input_direction_3D=Vector3(
		input_direction_2D.x, 0.0,input_direction_2D.y
	)
	#translating the vector into the player's base
	var direction=transform.basis*input_direction_3D
	#move the player
	velocity.x=direction.x*SPEED
	velocity.z=direction.z*SPEED
	#jumping vertical speed
	velocity.y-=20.0*delta
	#jumping
	if Input.is_action_just_pressed("jump")and is_on_floor():
		velocity.y=10.0
	#cancling jumping momentum if not held
	elif Input.is_action_just_released("jump")and velocity.y>0.0:
		velocity.y=0.0
	move_and_slide()
	
