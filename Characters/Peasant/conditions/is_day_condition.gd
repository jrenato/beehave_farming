extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if TimeManager.is_day():
		return SUCCESS

	return FAILURE
