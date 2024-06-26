class_name Peasant extends Area2D

enum ACTIVITY {
	IDLE,
	GOING_TO_WORK,
	WORKING,
	GOING_TO_EAT,
	EATING,
	GOING_TO_SLEEP,
	SLEEPING,
}

@export_group("Peasant")
@export var max_health: float = 100.0
@export var max_hunger: float = 100.0
@export var max_energy: float = 100.0
@export var move_speed: float = 1.0
## The energy cost to walk
@export var energy_cost_idle: float = 0.01
## The energy cost to walk
@export var energy_cost_to_walk: float = 0.05
## The energy cost to work
@export var energy_cost_to_work: float = 0.1
## The energy regained during sleep
@export var energy_gained_in_sleep: float = 0.3
## The hunger cost while awake
@export var hunger_cost_awake: float = 0.16
## The hunger cost while sleeping
@export var hunger_cost_sleep: float = 0.04
## The hunger regained while eating
@export var hunger_gained_eating: float = 0.5
## The health cost for working tired
@export var health_cost_while_working_tired: float = 0.05
## The health regained while sleeping
@export var health_gained_in_sleep: float = 0.01
@export_group("Simulation")
@export var current_building: Building
@export var home_location: Building
@export var work_location: Building
@export var sleep_icon: Node2D
@export var work_icon: Node2D
@export var food_node: Node2D

var current_activity: ACTIVITY = ACTIVITY.IDLE

var current_health: float: set = _update_health
var current_hunger: float: set = _update_hunger
var current_energy: float: set = _update_energy


func _ready() -> void:
	set_deferred("current_health", max_health)
	#set_deferred("current_hunger", max_hunger)
	set_deferred("current_hunger", 0)
	set_deferred("current_energy", max_energy)
	hide_icons()

	if current_building:
		enter_building(current_building)


func hide_icons() -> void:
	if sleep_icon:
		sleep_icon.hide()

	if work_icon:
		work_icon.hide()


func enter_building(building : Building) -> void:
	global_position = building.get_door_location()
	hide() 
	current_building = building


func exit_building() -> void:
	if !current_building: # can't exit a building if not in one
		print("attempting to exit when not in building")
		return

	hide_icons()
	current_building = null
	show()


func in_range(building_position : Vector2) -> bool:
	return building_position.distance_to(position) < 1


func is_at_home() -> bool:
	return current_building == home_location


func is_at_work() -> bool:
	return current_building == work_location


func in_building() -> bool:
	return current_building != null


func is_hungry() -> bool:
	# 30% of hunger or lower
	return (current_hunger / max_hunger) <= 0.3


func is_satiated() -> bool:
	# 100% of hunger
	return (current_hunger / max_hunger) >= 1.0


func sleep() -> void:
	Events.updated_peasant_activity.emit(self, "sleeping")
	#sleep_icon.position = Vector2(position.x - 50, position.y - 100)
	current_energy += energy_gained_in_sleep
	current_health += health_gained_in_sleep
	current_hunger -= hunger_cost_sleep
	if sleep_icon and not sleep_icon.visible:
		#await get_tree().create_timer(0.5).timeout
		sleep_icon.show()


func work() -> void:
	Events.updated_peasant_activity.emit(self, "working")
	#work_icon.position = Vector2(position.x - 50, position.y - 100)
	current_energy -= energy_cost_to_work
	current_hunger -= hunger_cost_awake

	if current_energy <= 0:
		current_health -= health_cost_while_working_tired

	if current_hunger <= 0:
		current_health -= health_cost_while_working_tired

	if work_icon and not work_icon.visible:
		#await get_tree().create_timer(0.5).timeout
		work_icon.show()


func walk() -> void:
	Events.updated_peasant_activity.emit(self, "walking")
	current_energy -= energy_cost_to_walk
	current_hunger -= hunger_cost_awake


func eat() -> void:
	Events.updated_peasant_activity.emit(self, "eating")
	current_hunger += hunger_gained_eating


func get_work() -> Building:
	return work_location


func get_home() -> Building:
	return home_location


func get_food_source() -> Node2D:
	return food_node


func get_current_building() -> Building:
	return current_building


func _on_time_updated(hour: int, minute: int) -> void:
	pass


func _update_health(new_value: float) -> void:
	current_health = clampf(new_value, 0.0, max_health)
	Events.updated_peasant_health.emit(self, max_health, current_health)


func _update_hunger(new_value: float) -> void:
	current_hunger = clampf(new_value, 0.0, max_hunger)
	Events.updated_peasant_hunger.emit(self, max_hunger, current_hunger)


func _update_energy(new_value: float) -> void:
	current_energy = clampf(new_value, 0.0, max_energy)
	Events.updated_peasant_energy.emit(self, max_energy, current_energy)
