extends CharacterBody2D
class_name PlayerCharacter2D

signal on_player_death()

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
var previous_frame: int

const ACCELERATION = 200.0
const DECELERATION = 600.0
const MAX_SPEED = 300.0
const REVERSE_DECELERATION = 1200.0
const JUMP_VELOCITY = -300.0
const ZONE_TRIGGER_DELAY: float = 4.0
const RESPAWN_INVULNERABILITY_TIME: float = 3.0
const INVULNERABILITY_SPRITE_FLICKER_DELAY: float = 0.15

var grabber: Grabber2D
var anim: AnimatedSprite2D

var isRightInput: bool = false
var isLeftInput: bool = false

var isFacingRight: bool = true
var isGrounded: bool = false

var current_element: Common.Elements = Common.Elements.FIRE
var zone_trigger_countup: float

var is_invulnerable: bool = false
var invulernable_countdown: float = 0
var sprite_flicker_countdown: float = 0


func _ready() -> void:
	print("character ready")
	var children: Array = get_children()
	for child in children:
		if child is Grabber2D:
			grabber = child
			break
	anim = $AnimatedSprite2D
	on_spawn()

func on_spawn() -> void:
	zone_trigger_countup = ZONE_TRIGGER_DELAY
	velocity = Vector2.ZERO

func accept_grab_input_start() -> void:
	grabber.start_grabbing()

func accept_fire_input_start() -> void:
	grabber.fire_projectiles()

func accept_zone_trigger_input_start() -> void:
	if zone_trigger_countup < ZONE_TRIGGER_DELAY:
		return
	var element_areas = get_tree().get_nodes_in_group(Groups.element_areas)
	for area in element_areas:
		area.accept_trigger_input(current_element)
	zone_trigger_countup = 0
	_swap_element()

func _swap_element() -> void:
	if current_element == Common.Elements.FIRE:
		current_element = Common.Elements.ICE
		SoundManager.switch_elemental_state('ice')
	elif current_element == Common.Elements.ICE:
		current_element = Common.Elements.FIRE
		SoundManager.switch_elemental_state('fire')

func _accept_direction_input_start(direction: Common.Direction) -> void:
	if direction == Common.Direction.RIGHT:
		isRightInput = true
	if direction == Common.Direction.LEFT:
		isLeftInput = true
	anim.animation = "walking"

func _accept_direction_input_cancel(direction: Common.Direction) -> void:
	if direction == Common.Direction.RIGHT:
		isRightInput = false
	if direction == Common.Direction.LEFT:
		isLeftInput = false

func _physics_process(delta: float) -> void:
	var previously_airborn = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	_invulnerable_logic(delta)
	_zone_trigger_countup_logic(delta)
	
	_check_facing()

	# Handle jump
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SoundManager.play_player_jump()
		previously_airborn = true

	_process_horizontal_movement(delta)
	
	move_and_slide()
	
	#handle footsteps
	
	if (animator.animation == 'walking' or 'walking_magnet') and velocity.x != 0 and is_on_floor():
		if (animator.frame == 3 or 5) and previous_frame != animator.frame:
				SoundManager.play_player_footstep()
				print(animator.frame, "sound played") 
	previous_frame = animator.frame
	
	if is_on_floor() and previously_airborn == true :
		SoundManager.play_player_footstep()
		previously_airborn == false
		

func _zone_trigger_countup_logic(delta: float) -> void:
	if zone_trigger_countup < ZONE_TRIGGER_DELAY:
		zone_trigger_countup += delta
	elif zone_trigger_countup > ZONE_TRIGGER_DELAY:
		zone_trigger_countup = ZONE_TRIGGER_DELAY

func _check_facing() -> void:
	if not velocity.y < 0 and isFacingRight and isLeftInput and not isRightInput:
		_swap_facing()
	elif not velocity.y < 0 and not isFacingRight and isRightInput and not isLeftInput:
		_swap_facing()

func _swap_facing() -> void:
	isFacingRight = not isFacingRight
	var anim = $AnimatedSprite2D
	scale.x = -scale.x

func _process_horizontal_movement(delta: float) -> void:
	var current_direction: Common.Direction = Common.Direction.NONE
	if isRightInput == true and isLeftInput == true:
		current_direction = Common.Direction.NONE
		anim.animation = "idle"
	elif isRightInput == true:
		current_direction = Common.Direction.RIGHT
		anim.animation = "walking"
	elif isLeftInput == true:
		current_direction = Common.Direction.LEFT
		anim.animation = "walking"
	else:
		anim.animation = "idle"
	
	var direction_value: int = Common.direction_to_value_horizontal(current_direction)
	if direction_value == 0:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
	elif not direction_value * velocity.x < 0:
		velocity.x = move_toward(velocity.x, direction_value * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, REVERSE_DECELERATION * delta)

func _start_invulnerability() -> void:
	anim.self_modulate = Color(.8, .1, .1, 1)
	invulernable_countdown = RESPAWN_INVULNERABILITY_TIME
	is_invulnerable = true
	collision_layer = 5
	set_collision_layer_value(1, false)

func _end_invulnerability() -> void:
	anim.self_modulate = Color(1,1,1,1)
	anim.visible = true
	is_invulnerable = false
	collision_layer = 1

func _invulnerable_logic(delta: float) -> void:
	if not is_invulnerable:
		return
	if invulernable_countdown < 0:
		_end_invulnerability()
		return
	
	invulernable_countdown -= delta
	sprite_flicker_countdown -= delta
	print(sprite_flicker_countdown)
	if sprite_flicker_countdown < 0:
		sprite_flicker_countdown = INVULNERABILITY_SPRITE_FLICKER_DELAY
		anim.visible = !anim.visible 

func on_hit():
	if is_invulnerable:
		return
	_die()

func _die() -> void:
	grabber.fire_projectiles()
	_start_invulnerability()
	on_player_death.emit()
