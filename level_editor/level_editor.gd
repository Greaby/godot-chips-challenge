extends Node2D

const CAMERA_SPEED = 400
const CAMERA_ZOOM_SPEED = 0.1

const CAMERA_MAX_ZOOM = 2
const CAMERA_MIN_ZOOM = 0.5

var drag_initial_position := Vector2()

var selected_tile :int = -1

onready var camera := $Camera2D
onready var tilemap := $TileMap

onready var tile_list := $UI/Control/MarginContainer/TileList


func _ready() -> void:
	load_tiles()
	
func load_tiles() -> void:
	var tileset :TileSet = load("res://levels/tileset.tres")
	
	for id in tileset.get_tiles_ids():
		var tile_item = preload("res://level_editor/tile_item.tscn").instance()
		tile_item.tile_id = id
		tile_item.texture = tileset.tile_get_texture(id)
		tile_item.connect("gui_input", self, "_on_tile_item_gui_input", [tile_item])
		
		tile_list.add_child(tile_item)


func _process(delta: float) -> void:
	handle_camera_move(delta)
	
	

func handle_camera_move(delta: float) -> void:
	if Input.is_action_pressed("ui_drag"):
		camera.position += drag_initial_position - get_global_mouse_position()
		return 
	
	var camera_move := Vector2()
	camera_move.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	camera_move.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	camera.position += camera_move * CAMERA_SPEED * delta
	

func _unhandled_input(event: InputEvent) -> void:
	handle_tilemap()
	
	if Input.is_action_just_pressed("ui_drag"):
		drag_initial_position = get_global_mouse_position()
		
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
	if not event is InputEventMouseButton:
		return

	if event.is_action_pressed("ui_place"):
		selected_tile = tile_item.tile_id

