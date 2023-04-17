extends Node3D


@onready var rover = $VehicleBody3D
@onready var frontRightWheel = $VehicleBody3D/FrontRight
@onready var frontLeftWheel = $VehicleBody3D/FrontLeft
@onready var middleRightWheel = $VehicleBody3D/MiddleRight
@onready var middleLeftWheel = $VehicleBody3D/MiddleLeft
@onready var backRightWheel = $VehicleBody3D/BackRight
@onready var backLeftWheel = $VehicleBody3D/BackLeft
@onready var upperLeftClaw = $VehicleBody3D/Rovee/Upper_Arm/Fore_Arm/Claw_Compartment/Claw_Left_Lower/Claw_Left_Upper
@onready var upperRightClaw = $VehicleBody3D/Rovee/Upper_Arm/Fore_Arm/Claw_Compartment/Claw_Right_Lower/Claw_Right_Upper
@onready var durationTimer = $DurationTimer

@onready var forearm = get_node("VehicleBody3D/Rovee/Upper_Arm/Fore_Arm")
@onready var upperarm = get_node("VehicleBody3D/Rovee/Upper_Arm")


var going := false
var current_cam := 0
var last_position := Vector3.ZERO
var traveling := 0


func _ready():
	last_position = rover.global_position
	EventQueue.going_forward.connect(forward)
	EventQueue.reversing.connect(reverse)
	EventQueue.breaking.connect(brake)
	EventQueue.spinning.connect(spin)
	EventQueue.changing_camera.connect(change_camera)
	EventQueue.rotate_forearm.connect(rotate_fore_arm)
	EventQueue.rotate_upperarm.connect(rotate_upperarm)
	EventQueue.open_claw.connect(open)
	EventQueue.close_claw.connect(close)


func _physics_process(_delta):
	if going and rover.global_position.distance_to(last_position) >= traveling:

		brake()


func forward(distance):
	going = true
	last_position = rover.global_position
	traveling = distance
	rover.brake = 0
	rover.engine_force = -10

	
	
	
func reverse(distance):
	going = true
	last_position = rover.global_position
	traveling = distance
	rover.brake = 0
	rover.engine_force = 10
	
	
func brake():
	durationTimer.stop()
	rover.engine_force = 0
	rover.brake = 1
	going = false

	
	
func spin(duration):
	rover.engine_force = 0
	if duration < 0:
		frontRightWheel.engine_force = 100
		middleRightWheel.engine_force = 100
		backRightWheel.engine_force = 100
		frontLeftWheel.engine_force = -100
		middleLeftWheel.engine_force = -100
		backLeftWheel.engine_force = -100
	else:
		frontRightWheel.engine_force = -100
		middleRightWheel.engine_force = -100
		backRightWheel.engine_force = -100
		frontLeftWheel.engine_force = 100
		middleLeftWheel.engine_force = 100
		backLeftWheel.engine_force = 100
	durationTimer.stop()
	durationTimer.start(abs(duration))
	
	
func change_camera():
	var cams = $VehicleBody3D/Cameras.get_children()
	current_cam += 1
	if current_cam > cams.size()-1:
		current_cam = 0
	cams[current_cam].current = true


func rotate_fore_arm(rotation_degree):
	if rotation_degree >= -60 and rotation_degree <= 10:
		var tween = get_tree().create_tween()
		var target_vector = Vector3(deg_to_rad(rotation_degree),0,0) 
		tween.tween_property(forearm, "rotation", target_vector, 2)
		

func rotate_upperarm(rotation_degree):
	if rotation_degree >= -45 and rotation_degree <= 30:
		var tween = get_tree().create_tween()
		var target_vector = Vector3(deg_to_rad(rotation_degree),0,0) 
		tween.tween_property(upperarm, "rotation", target_vector, 2)


func open():
	var tween = get_tree().create_tween()
	var right_target_vector = Vector3(0,-PI/8,0) 
	var left_target_vector = Vector3(0,PI/8,0) 
	tween.parallel().tween_property(upperLeftClaw, "rotation", left_target_vector, 1)
	tween.parallel().tween_property(upperRightClaw, "rotation", right_target_vector, 1)



func close():
	var tween = get_tree().create_tween()
	var right_target_vector = Vector3(0,0,0) 
	var left_target_vector = Vector3(0,0,0) 
	tween.parallel().tween_property(upperLeftClaw, "rotation", left_target_vector, 1)
	tween.parallel().tween_property(upperRightClaw, "rotation", right_target_vector, 1)


func _on_duration_timer_timeout():
	brake()
