extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.eat()
	return RUNNING
