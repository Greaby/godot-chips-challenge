extends Node2D

const CAMERA_SPEED = 400
const CAMERA_ZOOM_SPEED = 0.1

const CAMERA_MAX_ZOOM = 2
const CAMERA_MIN_ZOOM = 0.5

var drag_initial_position := Vector2()

var selected_tile :int = -1

@onready var camera := $Camera2D
@onready var tilemap := $TileMap
@onready var export_file_dialog := $UI/Control/ExportFileDialog
@onready var import_file_dialog := $UI/Control/ImportFileDialog

@onready var tile_list := $UI/Control/MarginContainer/TileList


func _ready() -> void:
	load_tiles()

func load_tiles() -> void:
	var tileset :TileSet = load("res://levels/tileset.tres")

	for id in tileset.get_tiles_ids():
		var tile_item = preload("res://level_editor/tile_item.tscn").instantiate()
		tile_item.tile_id = id
		tile_item.texture = tileset.tile_get_texture(id)
		tile_item.connect("gui_input", Callable(self, "_on_tile_item_gui_input").bind(tile_item))

		tile_list.add_child(tile_item)


func _process(delta: float) -> void:
	handle_camera_move(delta)



func handle_camera_move(delta: float) -> void:
	if Input.is_action_just_pressed("ui_drag"):
		drag_initial_position = get_global_mouse_position()

	if Input.is_action_pressed("ui_drag"):
		camera.position_smoothing_enabled = false
		camera.position += drag_initial_position - get_global_mouse_position()
		return
	else:
		camera.position_smoothing_enabled = true

	var camera_move := Vector2()
	camera_move.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	camera_move.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	camera.position += camera_move * CAMERA_SPEED * delta


func _unhandled_input(event: InputEvent) -> void:
	handle_tilemap()

	var zoom = int(Input.is_action_pressed("ui_zoom_out")) - int(Input.is_action_pressed("ui_zoom_in"))
	camera.zoom = Vector2.ONE * clamp(camera.zoom.x + zoom * CAMERA_ZOOM_SPEED, CAMERA_MIN_ZOOM, CAMERA_MAX_ZOOM)


func handle_tilemap() -> void:
	if selected_tile != -1 and Input.is_action_pressed("ui_place"):
		var position = get_global_mouse_position()
		tilemap.set_cell(floor(position.x / 64), floor(position.y / 64), selected_tile)

	if Input.is_action_pressed("ui_delete"):
		var position = get_global_mouse_position()
		tilemap.set_cell(floor(position.x / 64), floor(position.y / 64), -1)


func _on_tile_item_gui_input(event: InputEvent, tile_item) -> void:
	if not event is InputEventMouseButton or not event.is_action_pressed("ui_place"):
		return

	for item in tile_list.get_children():
		item.deselect()

	selected_tile = tile_item.tile_id
	tile_item.select()



func _on_ExportButton_pressed() -> void:
	export_file_dialog.popup()

func _on_ImportButton_pressed() -> void:
	import_file_dialog.popup()


func _on_FileDialog_file_selected(path: String) -> void:
	var file = File.new()
	var error = file.open(path, File.WRITE)

	if error != OK:
		print("Error opening file!")
		return

	var data = export_level()
	file.store_string(JSON.stringify(data))
	file.close()

func export_level() -> Dictionary:
	var terrain := tilemap.get("tile_data") as PackedInt32Array

	var data = {
		"version" : 1,
		"data": {
			"terrain" : terrain
		}
	}

	return data


func _on_ImportFileDialog_file_selected(path: String) -> void:
	var file = File.new()
	if not file.file_exists(path):
		print("File doesn't exists")
		return

	var error = file.open(path, File.READ)
	if error != OK:
		print("Error opening the file")
		return

	var test_json_conv = JSON.new()
	test_json_conv.parse(file.get_as_text())
	var json_level = test_json_conv.get_data()
	file.close()

	if json_level.error != OK:
		print("Error reading level")

	tilemap.set("tile_data", json_level.result.data.terrain)
