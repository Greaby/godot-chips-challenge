extends Node2D

signal completed
signal game_over

export var time_limit : int = 0

onready var finish = $Finish
onready var timer = $Timer

func _ready() -> void:
	finish.connect("entered", self, "on_finish_entered")
	
	if time_limit > 0:
		timer.start()


func on_finish_entered() -> void:
	emit_signal("completed")


func _on_Timer_timeout() -> void:
	time_limit -= 1
	
	if time_limit <= 0:
		timer.stop()
		emit_signal("game_over")
		
