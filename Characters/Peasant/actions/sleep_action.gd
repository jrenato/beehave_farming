extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.sleep()
	return RUNNING
