extends Node2D

@onready var day_night_modulate: CanvasModulate = %DayNightModulate
@onready var hour_label: Label = %HourLabel
@onready var activity_label: Label = %ActivityLabel
@onready var health_progress_bar: ProgressBar = %HealthProgressBar
@onready var hunger_progress_bar: ProgressBar = %HungerProgressBar
@onready var energy_progress_bar: ProgressBar = %EnergyProgressBar


func _ready() -> void:
	TimeManager.time_updated.connect(_on_time_updated)
	Events.updated_peasant_activity.connect(_on_updated_peasant_activity)
	Events.updated_peasant_health.connect(_on_updated_peasant_health)
	Events.updated_peasant_hunger.connect(_on_updated_peasant_hunger)
	Events.updated_peasant_energy.connect(_on_updated_peasant_energy)


func _process(delta: float) -> void:
	day_night_modulate.color = TimeManager.get_day_night_cycle_color()


func _on_time_updated(hour: int, minute: int) -> void:
	# If current_minute is a multiple of 10, update time
	if fmod(minute, 10) == 0:
		hour_label.text = "%02d:%02d" % [hour, minute]


func _on_updated_peasant_activity(peasant: Peasant, activity: String) -> void:
	activity_label.text = activity


func _on_updated_peasant_health(peasant: Peasant, max_health: float, current_health: float) -> void:
	health_progress_bar.value = current_health / max_health


func _on_updated_peasant_hunger(peasant: Peasant, max_hunger: float, current_hunger: float) -> void:
	hunger_progress_bar.value = current_hunger / max_hunger


func _on_updated_peasant_energy(peasant: Peasant, max_energy: float, current_energy: float) -> void:
	energy_progress_bar.value = current_energy / max_energy
