extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.exit_building()
	return SUCCESS
