extends Area2D
class_name ElementArea2D

const ZONE_ON_DURATION: float = 0.5

var anim: AnimatedSprite2D

var this_element: Common.Elements = Common.Elements.FIRE
var zone_on_countdown: float = 1
var is_on: bool = false

func _ready() -> void:
	set_physics_process(false)
	anim = $AnimatedSprite2D
	_zone_specific_ready_override()

func _zone_specific_ready_override() -> void:
	pass

func accept_trigger_input(element: Common.Elements) -> void:
	print("input received")
	print(element)
	if element == this_element:
		_trigger()

func _trigger() -> void:
	if not is_on:
		_turn_on()

func _turn_on() -> void:
	is_on = true
	anim.visible = true
	zone_on_countdown = ZONE_ON_DURATION
	set_physics_process(true)

func _turn_off() -> void:
	is_on = false
	set_physics_process(false)
	anim.visible = false

func _physics_process(delta: float) -> void:
	if is_on:
		zone_on_countdown -= delta
		if zone_on_countdown < 0:
			_turn_off()
		_check_zone()

func _check_zone() -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is EnemyBody2D:
			body.on_hit_elemental(this_element)
