extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if !blackboard.has_value("target_building"):
		return FAILURE

	if !actor.in_range(blackboard.get_value("target_building").get_door_location()):
		return FAILURE

	actor.enter_building(blackboard.get_value("target_building"))
	blackboard.erase_value("target_building")
	return SUCCESS
