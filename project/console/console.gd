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
		if command == "forward":
			EventQueue.emit_signal("going_forward")
		if command == "reverse":
			EventQueue.emit_signal("reversing")
		if command == "brake":
			EventQueue.emit_signal("breaking")
		if command == "spin":
			EventQueue.emit_signal("spinning")
		if command == "camera":
			EventQueue.emit_signal("changing_camera")
