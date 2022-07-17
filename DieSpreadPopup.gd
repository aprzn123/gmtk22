extends Node2D

func _process(delta):
	var target_faces = null
	for die in get_tree().get_nodes_in_group("Dice"):
		if die.has_mouse:
			target_faces = die.faces
	if target_faces == null:
		visible = false
	else:
		visible = true
		$Sprite.texture = target_faces[0].texture
		$Sprite2.texture = target_faces[1].texture
		$Sprite3.texture = target_faces[2].texture
		$Sprite4.texture = target_faces[3].texture
		$Sprite5.texture = target_faces[4].texture
		$Sprite6.texture = target_faces[5].texture
