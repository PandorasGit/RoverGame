extends Node3D


@onready var rover = $VehicleBody3D
@onready var frontRightWheel = $VehicleBody3D/FrontRight
@onready var frontLeftWheel = $VehicleBody3D/FrontLeft
@onready var middleRightWheel = $VehicleBody3D/MiddleRight
@onready var middleLeftWheel = $VehicleBody3D/MiddleLeft
@onready var backRightWheel = $VehicleBody3D/BackRight
@onready var backLeftWheel = $VehicleBody3D/BackLeft
@onready var durationTimer = $DurationTimer


var current_cam := 0

func _process(_delta):
	if abs(rover.linear_velocity.z) >= 2:
		rover.engine_force = 0


func _ready():
	EventQueue.going_forward.connect(forward)
	EventQueue.reversing.connect(reverse)
	EventQueue.breaking.connect(brake)
	EventQueue.spinning.connect(spin)
	EventQueue.changing_camera.connect(change_camera)


func forward(duration):
	
	rover.brake = 0
	rover.engine_force = -20
	durationTimer.stop()
	durationTimer.start(duration)
	
	
	
func reverse(duration):
	
	rover.brake = 0
	rover.engine_force = 20
	durationTimer.stop()
	durationTimer.start(duration)
	
	
func brake():
	durationTimer.stop()
	rover.engine_force = 0
	rover.brake = 1
	
	
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



func _on_duration_timer_timeout():
	brake()
