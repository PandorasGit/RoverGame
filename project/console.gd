extends Control

@onready var text_box = $TextEdit

func _on_text_edit_text_changed():
	if _parse():
		text_box.modulate = Color.GREEN
	else:
		text_box.modulate = Color.WHITE


func _parse():
	if text_box.text == "forward":
		return true
