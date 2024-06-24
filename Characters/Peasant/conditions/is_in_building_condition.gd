extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.in_building():
		return SUCCESS

	return FAILURE
