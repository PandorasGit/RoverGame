extends TextEdit



var command := [0, 0, 0, 0, 0]


func _on_text_changed():
	if text.ends_with("\n"):
		_parse()


func _parse():
	var current_line = get_line(get_caret_line() - 1)
	var command_array = current_line.split(",")
	for commands in command_array:
		
		if commands=="forward":
			command[0] = 1
			print("SiS")
		if commands == "reverse":
			print("SOS")
		if commands == "brake":
			print("SUS")
		if commands == "spin":
			print("SAS")


func _backspace(line_number):
	var current_line = get_caret_line()
	var current_line_content = get_line(current_line)

	var current_column = get_caret_column()
	
	if current_line_content.length() > 0:
		text = text.rstrip(text[text.length()-1])
		set_caret_column(current_column)
		set_caret_line(current_line)
		print(text)


