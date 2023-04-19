extends Control

@onready var command_history = $History
@onready var terminal = $Terminal

@export var average_linear_speed := 2
@export var average_angular_speed := 5.365
var terminal_text

var camera_names = ["Orbit Cam", "Selfie Cam", "Ground Cam"]
var current_cam = 0

func _on_terminal_text_submitted(_new_text):
	command_history.text += terminal.text + "\n"
	parse_terminal()
	terminal.clear()


func parse_terminal():
	terminal_text = terminal.text.split(",")
	for command in terminal_text:
		var command_with_paramater = command.split("=")
		if command_with_paramater.size() > 1:
			var paramater = float(command_with_paramater[1])
			if command_with_paramater[0] == "rotate_forearm":
				EventQueue.emit_signal("rotate_forearm", paramater)
			if command_with_paramater[0] == "rotate_upperarm":
				EventQueue.emit_signal("rotate_upperarm", paramater)
			if command_with_paramater[0] == "forward":
				EventQueue.emit_signal("going_forward", paramater)
			if command_with_paramater[0] == "reverse":
				EventQueue.emit_signal("reversing", paramater)
			if command_with_paramater[0] == "spin":
				EventQueue.emit_signal("spinning", paramater/5.365)
		if command_with_paramater[0] == "brake":
			EventQueue.emit_signal("breaking")
		if command_with_paramater[0] == "camera":
			if current_cam < 2:
				current_cam += 1
				$CameraName.text = camera_names[current_cam]
			else:
				current_cam = 0  
				$CameraName.text = camera_names[current_cam]
			EventQueue.emit_signal("changing_camera")
		if command_with_paramater[0] == "open":
			EventQueue.emit_signal("open_claw")
		if command_with_paramater[0] == "close":
			EventQueue.emit_signal("close_claw")
