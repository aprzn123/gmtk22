extends Node

enum actions {NONE, FLIP}

var selection_action = actions.NONE

func _ready():
	randomize()

func roll_result():
	var sum = 0
	for die in get_dice():
		sum += die.current_face().value
	return sum

func roll():
	for die in get_dice():
		die.roll()

func get_dice():
	return $CenterContainer/Dice.get_children()

func add_die():
	var new_die = preload("res://Die.tscn").instance()
	$CenterContainer/Dice.add_child(new_die)

	return new_die

func _process(delta):
	$SelectDieLabel.visible = ModeTracker.mode == ModeTracker.SELECT_DIE

func _on_Button_pressed():
	roll()
	$Button.disabled = true
	$RollingFinished.start()


#func resolve_actions():
#	if action_queue['Add']:
#		action_queue['Add'] -= 1
#	elif action_queue['Minus']:
#		action_queue['Minus'] -= 1
#	elif action_queue['Flip']:
#		action_queue['Flip'] -= 1
#	elif action_queue['Reroll']:
#		action_queue['Reroll'] -= 1
#	elif action_queue['MinusDie']:
#		action_queue['MinusDie'] -= 1
#	update_result()
#	if action_queue.values() != [0,0,0,0,0]:
#		resolve_actions()
#	else:
#		for die in get_tree().get_nodes_in_group("Fake"):
#			die.remove_from_group("Fake")

#func update_result():
#	roll_result = 0
#	for die in get_tree().get_nodes_in_group("Dice"):
#		if !die.is_in_group("Fake"):
#			roll_result += die.current_face().value

func refresh_dice():
	pass

func rolling_finished():
	ModeTracker.mode = ModeTracker.CHOOSE_ACTION

func new_used_die():
	add_die().add_to_group("Used")

func flip_die():
	ModeTracker.mode = ModeTracker.SELECT_DIE
	selection_action = actions.FLIP

func select_die(die):
	match selection_action:
		actions.NONE:
			print(die)
		actions.FLIP:
			die.current_face_idx = die.opposite_face(die.current_face_idx)
			refresh_dice()
			selection_action = actions.NONE
			ModeTracker.mode = ModeTracker.CHOOSE_ACTION
