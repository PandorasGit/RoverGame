extends Control

@onready var command_history = $History
@onready var terminal = $Terminal
var terminal_text


func _on_terminal_text_submitted(new_text):
	command_history.text += terminal.text + "\n"
	parse_terminal()
	terminal.clear()


func parse_terminal():
	terminal_text = terminal.text.split(",")
	for command in terminal_text:
		if command == "forward":
			print("forward")
		if command == "reverse":
			print("reverse")
		if command == "brake":
			print("brake")
		if command == "spin":
			print("spin")
		if command == "camera":
			print("camera")
