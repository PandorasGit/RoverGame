extends Node3D


@onready var rover = $VehicleBody3D
@onready var frontRightWheel = $VehicleBody3D/FrontRight
@onready var frontLeftWheel = $VehicleBody3D/FrontLeft
@onready var middleRightWheel = $VehicleBody3D/MiddleRight
@onready var middleLeftWheel = $VehicleBody3D/MiddleLeft
@onready var backRightWheel = $VehicleBody3D/BackRight
@onready var backLeftWheel = $VehicleBody3D/BackLeft
var current_cam := 0

func forward():
	rover.brake = 0
	rover.engine_force = -20
	
	
func reverse():
	rover.brake = 0
	rover.engine_force = 20
	
	
func brake():
	rover.engine_force = 0
	rover.brake = 1
	
	
func spin():
	rover.engine_force = 0
	frontRightWheel.engine_force = 100
	middleRightWheel.engine_force = 100
	backRightWheel.engine_force = 100
	frontLeftWheel.engine_force = -100
	middleLeftWheel.engine_force = -100
	backLeftWheel.engine_force = -100
	
	
func change_camera():
	var cams = $VehicleBody3D/Node.get_children()
	current_cam += 1
	if current_cam > 2:
		current_cam = 0
	cams[current_cam].current = true
	print(cams[current_cam].name)
