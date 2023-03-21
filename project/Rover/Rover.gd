extends Node3D

@export var console : Control

var rover_moving = false


func _process(delta):
	if rover_moving == true:
		self.global_position.z += -0.1


func _on_console_going():
	rover_moving = true
