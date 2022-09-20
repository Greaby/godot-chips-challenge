extends CanvasLayer

signal closed

onready var animation_player = $AnimationPlayer
onready var label = $ColorRect/Label


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		hide()


func display(text: String) -> void:
	label.text = text
	animation_player.play("show")


func hide() -> void:
	animation_player.play("hide")
	yield(animation_player, "animation_finished")
	emit_signal("closed")
