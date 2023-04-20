extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/LineEdit.grab_focus()
	$rover.forward(100000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_line_edit_text_submitted(new_text):
	if $Control/LineEdit.text == "play":
		get_tree().change_scene_to_file("res://DevRoom.tscn")
	else:
		$Control/LineEdit.clear()
