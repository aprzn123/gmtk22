tool

extends GridContainer

export (bool) var spread = false

func _process(delta):
	columns = ceil(sqrt(get_child_count()) * 1.77)
