extends HelicopterBody2D
class_name FirecopterBody2D

func _enemy_specific_ready_override() -> void:
	element_vulnerable = Common.Elements.ICE
