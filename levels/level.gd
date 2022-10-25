extends Node2D

signal completed
signal game_over

@export var time_limit : int = 0

@onready var timer = $Timer
@onready var objects_tilemap: TileMap = $Objects


func _ready() -> void:
	spawn_objects()

	if time_limit > 0:
		timer.start()
		

func spawn_objects() -> void:
	var scenes = {
		0 : "res://objects/chips.tscn",
		1 : "res://objects/blue_key.tscn",
		2 : "res://objects/green_key.tscn",
		3 : "res://objects/red_key.tscn",
		4 : "res://objects/yellow_key.tscn",
		5 : "res://objects/door_blue.tscn",
		6 : "res://objects/door_green.tscn",
		7 : "res://objects/door_red.tscn",
		8 : "res://objects/door_yellow.tscn",
		9 : "res://player.tscn",
		10 : "res://objects/finish.tscn"
	}
	
	
	
	for cell_position in objects_tilemap.get_used_cells(0):
		var id = objects_tilemap.get_cell_source_id(0, cell_position)
		var object = load(scenes[id]).instantiate()
		object.position = cell_position * objects_tilemap.tile_set.tile_size.x + objects_tilemap.tile_set.tile_size / 2
		add_child(object)
		
		if id == 10:
			object.connect("entered",Callable(self,"on_finish_entered"))

	objects_tilemap.queue_free()


func on_finish_entered() -> void:
	emit_signal("completed")


func _on_Timer_timeout() -> void:
	time_limit -= 1
	
	if time_limit <= 0:
		timer.stop()
		emit_signal("game_over")
		
