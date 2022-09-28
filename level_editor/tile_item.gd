extends TextureRect


var tile_id :int

onready var focus = $Focus

func _ready():
	unselect()

func select() -> void:
	focus.show()

func unselect() -> void:
	focus.hide()
