extends Node
class_name InputRouter

signal pass_input_direction_started(direction: Common.Direction)
signal pass_input_direction_cancelled(direction: Common.Direction)
signal pass_input_grab_started()
signal pass_input_fire_started()

func _ready() -> void:
	_connect_input_handler()

func _connect_input_handler() -> void:
	var handler: InputHandler = AutoloadInputHandler
	handler.input_start_direction.connect(_accept_input_direction_started)
	handler.input_cancel_direction.connect(_accept_input_direction_cancelled)
	handler.input_start_grab.connect(_accept_input_grab_started)
	handler.input_start_fire.connect(_accept_input_fire_started)

func _accept_input_direction_started(direction: Common.Direction) -> void:
	pass_input_direction_started.emit(direction)
func _accept_input_direction_cancelled(direction: Common.Direction) -> void:
	pass_input_direction_cancelled.emit(direction)
func _accept_input_grab_started() -> void:
	print("Input Router passing Grab")
	pass_input_grab_started.emit()
func _accept_input_fire_started() -> void:
	pass_input_fire_started.emit()
