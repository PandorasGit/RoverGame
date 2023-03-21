extends Control

@export var rover : Node3D

signal going


func _process(delta):
	if Input.is_action_just_pressed("confirm_input"):
		if $TextEdit.text.rstrip("\n") == "go":
			emit_signal("going")
		$TextEdit.clear()
