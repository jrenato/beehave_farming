extends Area2D

@export var current_building: Building
@export var home_location: Building
@export var work_location: Building
@export var sleep_icon: Node2D
@export var work_icon: Node2D
@export var food_node: Node2D

var energy_level: float = 1.0


func _ready() -> void:
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
	return energy_level <= 0.3


func is_satiated() -> bool:
	return energy_level >= 1.0


func sleep() -> void:
	#sleep_icon.position = Vector2(position.x - 50, position.y - 100)
	if sleep_icon and not sleep_icon.visible:
		#await get_tree().create_timer(0.5).timeout
		sleep_icon.show()


func work() -> void:
	#work_icon.position = Vector2(position.x - 50, position.y - 100)
	energy_level = clampf(energy_level - 0.01, 0.0, 1.0)
	if work_icon and not work_icon.visible:
		#await get_tree().create_timer(0.5).timeout
		work_icon.show()


func eat() -> void:
	energy_level = clampf(energy_level + 0.1, 0.0, 1.0)


func get_work() -> Building:
	return work_location


func get_home() -> Building:
	return home_location


func get_food_source() -> Node2D:
	return food_node


func get_current_building() -> Building:
	return current_building
