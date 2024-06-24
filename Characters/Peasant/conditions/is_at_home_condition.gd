extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.is_at_home():
		return SUCCESS
	else: 
		return FAILURE
