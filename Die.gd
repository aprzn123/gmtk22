tool
extends Control

signal die_cast(face_id, face_value)

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

func roll():
	face_swaps_left_anim = int(rand_range(5,10))
	$RollTimer.start()

func random_face():
	randomize()
	var target_faces = range(6)
	target_faces.remove(opposite_face(current_face_idx))
	target_faces.erase(current_face_idx)
	target_faces.shuffle()
	current_face_idx = target_faces[0]

func _on_RollTimer_timeout():
	random_face()
	face_swaps_left_anim -= 1
	if face_swaps_left_anim == 0:
		emit_signal("die_cast", faces[current_face_idx].face_id, faces[current_face_idx].value)
	else:
		$RollTimer.start()

func _on_Die_mouse_entered():
	has_mouse = true

func _on_Die_mouse_exited():
	has_mouse = false
