extends Node3D


@export var target: Node3D # Glisse ton Player ici

func _physics_process(_delta):
	if target:
		global_position = target.global_position
