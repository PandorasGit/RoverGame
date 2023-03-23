extends Node3D


var speed = 0


func _process(delta):
	global_position.z += speed

func forward():
	speed = -0.01
	
	
func reverse():
	speed = 0.01
	
	
func brake():
	speed = 0
	
	
func spin(degrees : int):
	pass
	
	
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
