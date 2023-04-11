extends Control

@onready var command_history = $History
@onready var terminal = $Terminal
var terminal_text


func _on_terminal_text_submitted(_new_text):
	command_history.text += terminal.text + "\n"
	parse_terminal()
	terminal.clear()


func parse_terminal():
	terminal_text = terminal.text.split(",")
	for command in terminal_text:
		var command_with_paramater = command.split("=")
		
		if command_with_paramater[0] == "forward" and command_with_paramater.size() > 1:
			
			EventQueue.emit_signal("going_forward", float(command_with_paramater[1]))
		if command_with_paramater[0] == "reverse" and command_with_paramater.size() > 1:
			EventQueue.emit_signal("reversing", float(command_with_paramater[1]))
		if command_with_paramater[0] == "brake":
			EventQueue.emit_signal("breaking")
		if command_with_paramater[0] == "spin" and command_with_paramater.size() > 1:
			EventQueue.emit_signal("spinning", float(command_with_paramater[1]))
		if command_with_paramater[0] == "camera":
			EventQueue.emit_signal("changing_camera")
