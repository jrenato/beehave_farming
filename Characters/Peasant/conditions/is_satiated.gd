extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.is_satiated():
		return SUCCESS

	return FAILURE
