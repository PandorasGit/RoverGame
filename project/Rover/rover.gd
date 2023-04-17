extends Node3D


@onready var rover = $VehicleBody3D
@onready var frontRightWheel = $VehicleBody3D/FrontRight
@onready var frontLeftWheel = $VehicleBody3D/FrontLeft
@onready var middleRightWheel = $VehicleBody3D/MiddleRight
@onready var middleLeftWheel = $VehicleBody3D/MiddleLeft
@onready var backRightWheel = $VehicleBody3D/BackRight
@onready var backLeftWheel = $VehicleBody3D/BackLeft
@onready var durationTimer = $DurationTimer
@onready var forearm = get_node("VehicleBody3D/Rovee/Upper_Arm/Fore_Arm")
@onready var upperarm = get_node("VehicleBody3D/Rovee/Upper_Arm")

var going_forward = false
var going_reverse = false
var current_cam := 0

func _process(_delta):
	
	if abs(rover.linear_velocity.z) >= 2.001 and (going_forward or going_reverse):
		rover.engine_force = 0
	elif abs(rover.linear_velocity.z) <= 1.99 and (going_forward or going_reverse):
		if going_forward:
			rover.engine_force = -20
		elif going_reverse:
			rover.engine_force = 20

func _ready():
	EventQueue.going_forward.connect(forward)
	EventQueue.reversing.connect(reverse)
	EventQueue.breaking.connect(brake)
	EventQueue.spinning.connect(spin)
	EventQueue.changing_camera.connect(change_camera)
	EventQueue.rotate_forearm.connect(rotate_fore_arm)
	EventQueue.rotate_upperarm.connect(rotate_upperarm)


func forward(duration):
	going_forward = true
	rover.brake = 0
	rover.engine_force = -10
	durationTimer.stop()
	durationTimer.start(duration)
	
	
	
func reverse(duration):
	going_reverse = true
	rover.brake = 0
	rover.engine_force = 10
	durationTimer.stop()
	durationTimer.start(duration)
	
	
func brake():
	durationTimer.stop()
	rover.engine_force = 0
	rover.brake = 1
	going_forward = false
	going_reverse = false
	
	
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


func rotate_fore_arm(rotation_degrees):
	if rotation_degrees >= -60 and rotation_degrees <= 10:
		var tween = get_tree().create_tween()
		var target_vector = Vector3(deg_to_rad(rotation_degrees),0,0) 
		tween.tween_property(forearm, "rotation", target_vector, 2)
		

func rotate_upperarm(rotation_degrees):
	if rotation_degrees >= -45 and rotation_degrees <= 30:
		var tween = get_tree().create_tween()
		var target_vector = Vector3(deg_to_rad(rotation_degrees),0,0) 
		tween.tween_property(upperarm, "rotation", target_vector, 2)

func _on_duration_timer_timeout():
	brake()
