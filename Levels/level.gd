extends Node2D

@onready var day_night_modulate: CanvasModulate = %DayNightModulate


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	day_night_modulate.color = TimeManager.get_day_night_cycle_color()
