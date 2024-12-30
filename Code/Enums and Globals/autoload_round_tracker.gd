extends Node

const FILE_BEGIN = "res://Gameplay/ROUNDS/round"

const STARTING_ROUND: int = 1
const MAX_ROUND: int = 16
var current_round: int

func _ready() -> void:
	_init_round()

func _init_round() -> void:
	current_round = STARTING_ROUND

func _increment_round() -> void:
	current_round += 1
	if current_round > MAX_ROUND - 1:
		_init_round()

func _start_round() -> void:
	print("next round")
	var next_level_path = FILE_BEGIN + str(current_round) + ".tscn"
	get_tree().change_scene_to_file(next_level_path)
