extends Area2D

func can_move_into(_direction: Vector2, entity: Area2D) -> bool:
	return entity.is_in_group("player")



func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return

	var tilemap : TileMapLayer = get_parent()
	var tile_postion = tilemap.local_to_map(self.position)
	tilemap.set_cell(tile_postion, 0, Vector2i(0,0))
	self.queue_free()
