extends Node

var roll_result = 0

func die_cast(face_id):
	match face_id:
		"AddDie":
			add_die()
		"Add":
			pass
		"Blank":
			pass
		"Number1":
			pass
		"Number2":
			pass
		"Number3":
			pass
		"Number4":
			pass
		"Number5":
			pass
		"Number6":
			pass
		"Number7":
			pass
		"Number8":
			pass
		"Number9":
			pass
		_:
			print_debug("INVALID FACE ID " + face_id)
	print('die cast')

func roll():
	for die in get_dice():
		die.roll()

func get_dice():
	return $CenterContainer/Dice.get_children()

func add_die():
	var new_die = preload("res://Die.tscn").instance()
	$CenterContainer/Dice.add_child(new_die)
	new_die.connect("die_cast", self, "die_cast")



func _on_Button_pressed():
	roll()
