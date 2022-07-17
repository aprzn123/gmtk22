extends Node

var roll_result = 0
var action_queue = []

func die_cast(face_id):
	match face_id:
		"AddDie":
			add_die()
		"Add":
			pass
		"Blank":
			pass
		"Number1":
			roll_result += 1
		"Number2":
			roll_result += 2
		"Number3":
			roll_result += 3
		"Number4":
			roll_result += 4
		"Number5":
			roll_result += 5
		"Number6":
			roll_result += 6
		"Number7":
			roll_result += 7
		"Number8":
			roll_result += 8
		"Number9":
			roll_result += 9
		_:
			print_debug("INVALID FACE ID " + face_id)
	print('die cast')

func roll():
	roll_result = 0
	var action_queue = []
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
