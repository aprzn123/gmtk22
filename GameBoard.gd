extends Node

var roll_result = 0
var action_queue = {}

func die_cast(face_id, face_value):
	match face_id:
		"AddDie":
			add_die()
		"MinusDie", "Add", "Minus", "Flip", "Reroll":
			action_queue[face_id] += 1
		"Number":
			roll_result += face_value
		"Blank":
			pass
		_:
			print_debug("INVALID FACE ID " + face_id)
	print('die cast')

func roll():
	roll_result = 0
	action_queue = {
		'MinusDie': 0,
		'Add': 0,
		'Minus': 0,
		'Flip': 0,
		'Reroll': 0
	}
	for die in get_dice():
		die.roll()

func get_dice():
	return $CenterContainer/Dice.get_children()

func add_die(fake=false):
	var new_die = preload("res://Die.tscn").instance()
	$CenterContainer/Dice.add_child(new_die)
	new_die.connect("die_cast", self, "die_cast")
	if fake:
		new_die.add_to_group("Fake")

func _on_Button_pressed():
	roll()
	$Button.disabled = true
	$RollTimer.start()

func resolve_actions():
	if action_queue['Add']:
		action_queue['Add'] -= 1
	elif action_queue['Minus']:
		action_queue['Minus'] -= 1
	elif action_queue['Flip']:
		action_queue['Flip'] -= 1
	elif action_queue['Reroll']:
		action_queue['Reroll'] -= 1
	elif action_queue['MinusDie']:
		action_queue['MinusDie'] -= 1
	update_result()
	if action_queue.values() != [0,0,0,0,0]:
		resolve_actions()
	else:
		for die in get_tree().get_nodes_in_group("Fake"):
			die.remove_from_group("Fake")

func update_result():
	roll_result = 0
	for die in get_tree().get_nodes_in_group("Dice"):
		if !die.is_in_group("Fake"):
			roll_result += die.current_face().value
