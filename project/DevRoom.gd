extends Node3D


func _process(delta):
	if $Collectables.get_child_count() < 1:
		get_tree().paused = true
