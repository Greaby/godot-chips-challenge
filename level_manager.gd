extends Node2D


const LEVELS = {
	1 : "res://levels/level1.tscn",
	2 : "res://levels/level2.tscn"
}


var level_number : int = 1
var level = null

@onready var alert_box = $AlertBox


func _ready() -> void:
	load_level()

func load_level() -> void:
	if not LEVELS.has(level_number):
		return

	level = load(LEVELS[level_number]).instantiate()
	level.connect("completed", Callable(self, "on_level_completed"))
	level.connect("game_over", Callable(self, "on_level_game_over"))
	add_child(level)

func unload_level() -> void:
	if level:
		level.queue_free()


func on_level_completed() -> void:
	alert_box.display("Level completed")
	await alert_box.closed

	unload_level()
	level_number += 1
	load_level()

func on_level_game_over() -> void:
	alert_box.display("Game over")
	await alert_box.closed

	unload_level()
	load_level()
