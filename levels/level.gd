extends Node2D

signal completed
signal game_over

@export var time_limit : int = 0

@onready var timer = $Timer

func _ready() -> void:
	if time_limit > 0:
		timer.start()

	$Player.die.connect(_game_over)

	for object in $Objects.get_children():
		if object.is_in_group("finish"):
			object.entered.connect(on_finish_entered)

	for mob in $Mobs.get_children():
		$Tick.timeout.connect(mob.tick)
		mob.attack.connect(_game_over)

func on_finish_entered() -> void:
	completed.emit()

func _on_Timer_timeout() -> void:
	time_limit -= 1

	if time_limit <= 0:
		timer.stop()
		game_over.emit()

func _game_over() -> void:
	timer.stop()
	$Tick.stop()
	game_over.emit()
