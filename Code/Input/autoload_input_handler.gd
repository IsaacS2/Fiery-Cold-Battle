extends Node
class_name InputHandler

signal input_start_direction(direction: Common.Direction)
signal input_cancel_direction(direction: Common.Direction)
signal input_start_grab()
signal input_start_fire()

func _process(delta: float) -> void:
	_listen_for_direction_start()
	_listen_for_direction_cancel()
	_listen_for_grab_start()
	_listen_for_fire_start()

func _listen_for_direction_start() -> void:
	if Input.is_action_just_pressed("ui_up"):
		_process_direction_input_start(Common.Direction.UP)
	if Input.is_action_just_pressed("ui_right"):
		_process_direction_input_start(Common.Direction.RIGHT)
	if Input.is_action_just_pressed("ui_down"):
		_process_direction_input_start(Common.Direction.DOWN)
	if Input.is_action_just_pressed("ui_left"):
		_process_direction_input_start(Common.Direction.LEFT)
func _process_direction_input_start(direction: Common.Direction):
	if direction != Common.Direction.NONE:
		input_start_direction.emit(direction)

func _listen_for_direction_cancel() -> void:
	if Input.is_action_just_released("ui_up"):
		_process_direction_input_cancel(Common.Direction.UP)
	if Input.is_action_just_released("ui_right"):
		_process_direction_input_cancel(Common.Direction.RIGHT)
	if Input.is_action_just_released("ui_down"):
		_process_direction_input_cancel(Common.Direction.DOWN)
	if Input.is_action_just_released("ui_left"):
		_process_direction_input_cancel(Common.Direction.LEFT)
func _process_direction_input_cancel(direction: Common.Direction):
	if direction != Common.Direction.NONE:
		input_cancel_direction.emit(direction)

func _listen_for_grab_start() -> void:
	if Input.is_action_just_pressed("Grab"):
		print("Input Handler hears Grab")
		input_start_grab.emit()

func _listen_for_fire_start() -> void:
	if Input.is_action_just_pressed("Fire"):
		print("Fire input")
		input_start_fire.emit()
