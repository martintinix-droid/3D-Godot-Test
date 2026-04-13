extends CharacterBody3D
# comentario
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x*0.5
		%Head.rotation_degrees.x-=event.relative.y*0.2
		%Head.rotation_degrees.x=clamp(%Head.rotation_degrees.x,-90,90)
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
func _physics_process(delta): 
	const SPEED=5.5
	
	var input_direction_2D=Input.get_vector(
		"move_left",
		"move_rigth",
		"move_foward",
		"move_back"
	)
	var input_direction_3D=Vector3(
		input_direction_2D.x, 0.0,input_direction_2D.y
	)
	var direction=transform.basis*input_direction_3D
	
	velocity.x=direction.x*SPEED
	velocity.z=direction.z*SPEED
	
	velocity.y-=20.0*delta
	if Input.is_action_just_pressed("jump")and is_on_floor():
		velocity.y=10.0
	elif Input.is_action_just_released("jump")and velocity.y>0.0:
		velocity.y=0.0
	move_and_slide()
	

