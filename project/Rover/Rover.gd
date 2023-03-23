extends CharacterBody3D


var speed = 0


func _physics_process(delta):
	velocity = Vector3.FORWARD.rotated(Vector3.UP, rotation.y) * speed
	move_and_slide()

func forward():
	speed = 100
	
	
func reverse():
	speed = -100
	
	
func brake():
	speed = 0
	
	
func spin(degrees : int):
	rotation_degrees.y += degrees
	
	
func switch_camera(camera : Camera3D):
	pass
	
	
func rotate_camera(degress : int):
	pass
	
	
func pitch_shoulder(degrees : int):
	pass
	
	
func pitch_elbow(degrees : int):
	pass
	
	
func open_claw():
	pass
	
	
func close_claw():
	pass
