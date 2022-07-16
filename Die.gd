tool
extends Node2D

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

func roll():
	face_swaps_left_anim = rand_range(5,10)
	$RollTimer.start()
