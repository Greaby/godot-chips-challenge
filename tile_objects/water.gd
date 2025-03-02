extends Area2D


func can_move_into(_direction: Vector2, entity: Area2D) -> bool:
	return true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("block"):
		_interact_block(area)

	if area.is_in_group("mob"):
		_interact_mob(area)

	if area.is_in_group("player"):
		_interact_player(area)

func _interact_block(block: Area2D) -> void:
	var dirt = load("res://tile_objects/dirt.tscn").instantiate()

	dirt.position = self.position
	get_parent().add_child(dirt)

	block.queue_free()
	self.queue_free()

func _interact_mob(mob: Area2D) -> void:
	mob.queue_free()

func _interact_player(player: Area2D) -> void:
	if not Inventory.has(Inventory.TYPES.PALMS):
		player.drown()
