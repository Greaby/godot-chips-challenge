extends TextureRect


var tile_id :int

@onready var focus = $Focus

func _ready():
	deselect()

func select() -> void:
	focus.show()

func deselect() -> void:
	focus.hide()
