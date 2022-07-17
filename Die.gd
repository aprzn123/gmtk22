tool
extends Control

signal die_selected(die)
signal new_used_die
signal flip_die

export (Array, Resource) var faces = [
	load("res://DieFaces/BlankFace.tres"), 
	load("res://DieFaces/BlankFace.tres"), 
	load("res://DieFaces/BlankFace.tres"),
	load("res://DieFaces/BlankFace.tres"), 
	load("res://DieFaces/BlankFace.tres"), 
	load("res://DieFaces/BlankFace.tres")
]

export (int) var current_face_idx = 0

var face_swaps_left_anim = 0
var has_mouse = false

func current_face():
	return faces[current_face_idx]

func opposite_face(n):
	return 5 - n

func _process(delta):
	$Sprite.texture = faces[current_face_idx].texture
	if is_actionable() and ModeTracker.mode == ModeTracker.CHOOSE_ACTION:
		select()
	else:
		deselect()

func roll():
	face_swaps_left_anim = int(rand_range(5,10))
	$RollTimer.start()

func random_face():
	var target_faces = range(6)
	target_faces.remove(opposite_face(current_face_idx))
	target_faces.erase(current_face_idx)
	target_faces.shuffle()
	current_face_idx = target_faces[0]

func _on_RollTimer_timeout():
	random_face()
	face_swaps_left_anim -= 1
	if face_swaps_left_anim == 0:
		add_to_group("Unused")
	else:
		$RollTimer.start()

func _on_Die_mouse_entered():
	has_mouse = true

func _on_Die_mouse_exited():
	has_mouse = false

func is_actionable():
	return current_face().has_action and is_in_group("Unused")

func select():
	if $AnimationPlayer.current_animation == "Base":
		$AnimationPlayer.play("Glow")

func deselect():
	if $AnimationPlayer.current_animation == "Glow":
		$AnimationPlayer.play("Base")

func _input(event):
	if event.is_action_pressed("click") and is_actionable() and ModeTracker.mode == ModeTracker.CHOOSE_ACTION:
		remove_from_group("Unused")
		add_to_group("Used")
		match current_face().face_id:
			"AddDie":
				emit_signal("new_used_die")
			"Add":
				pass
			"Flip":
				emit_signal("flip_die")
			"MinusDie":
				pass
			"Minus":
				pass
			"Reroll":
				pass
			_:
				print_debug("How did " + current_face().face_id + " get in here?")
	elif event.is_action_pressed("click") and ModeTracker.mode == ModeTracker.SELECT_DIE:
		emit_signal("die_selected", self)
