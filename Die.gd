tool
extends Control

signal die_cast(face_id)

export (Array, Resource) var faces = [
	load("res://DieFaces/BlankFace.tres"), 
	load("res://DieFaces/BlankFace.tres"), 
	load("res://DieFaces/BlankFace.tres"),
	load("res://DieFaces/BlankFace.tres"), 
	load("res://DieFaces/BlankFace.tres"), 
	load("res://DieFaces/BlankFace.tres")
]
export (bool) var spread = false

export (int) var current_face_idx = 0

var face_swaps_left_anim = 0

func opposite_face(n):
	return 5 - n

func _process(delta):
	$Sprite.texture = faces[current_face_idx].texture
	$Spread/Sprite.texture = faces[0].texture
	$Spread/Sprite2.texture = faces[1].texture
	$Spread/Sprite3.texture = faces[2].texture
	$Spread/Sprite4.texture = faces[3].texture
	$Spread/Sprite5.texture = faces[4].texture
	$Spread/Sprite6.texture = faces[5].texture
	if spread: 
		$Spread.visible = true
		$Sprite.visible = false
	else:
		$Spread.visible = false
		$Sprite.visible = true

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
		emit_signal("die_cast", faces[current_face_idx].face_id)
	else:
		$RollTimer.start()


