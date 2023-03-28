extends Node3D


func forward():
	$VehicleBody3D.brake = 0
	$VehicleBody3D.engine_force = -10
	
	
func reverse():
	$VehicleBody3D.brake = 0
	$VehicleBody3D.engine_force = 10
	
	
func brake():
	$VehicleBody3D.engine_force = 0
	$VehicleBody3D.brake = 0.5
	
	
func spin():
	pass
