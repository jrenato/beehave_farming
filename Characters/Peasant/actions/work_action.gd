extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.work()
	return RUNNING
