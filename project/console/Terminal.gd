extends LineEdit

func _ready():
	grab_focus()


func _on_text_submitted(new_text):
	clear()
