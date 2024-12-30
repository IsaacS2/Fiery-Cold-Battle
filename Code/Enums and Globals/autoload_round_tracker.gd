extends Node

#const FILE_BEGIN = 
const STARTING_ROUND: int = 1
const MAX_ROUND: int = 16
var current_round: int
var rounds : Array = []

func _ready() -> void:
	_init_round()

func _init_round() -> void:
	current_round = STARTING_ROUND

func _increment_round() -> void:
	current_round += 1
