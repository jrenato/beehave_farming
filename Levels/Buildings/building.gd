class_name Building extends Node2D

@export var door_sprite: Sprite2D


func get_door_location() -> Vector2:
	if door_sprite:
		return door_sprite.global_position

	return global_position
