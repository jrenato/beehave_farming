extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	var nearest_food_source: Node2D = actor.get_food_source()

	if actor.in_range(nearest_food_source.global_position):
		return SUCCESS

	actor.position = actor.position.move_toward(nearest_food_source.global_position, 5)
	return RUNNING
