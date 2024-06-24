extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.is_hungry():
		return SUCCESS

	return FAILURE
