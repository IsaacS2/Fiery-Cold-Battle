extends EnemyBody2D
class_name JerboaBody2D

const JUMP_DELAY: float = 3
const JUMP_VELOCITY: float = -400.0

var jump_countdown: float
var jump_reset: bool = true

var fire_reset: bool = false

func _enemy_specific_ready_override() -> void:
	element_vulnerable = Common.Elements.ICE

func _physics_process(delta: float) -> void:
	velocity.x = 0
	
	if not is_on_floor() and velocity.y > 0 and fire_reset == true:
		_fire_projectile()
		fire_reset = false
	
	_jump_logic(delta)
	move_and_slide()

func _jump_logic(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_on_floor() and jump_reset == false:
		jump_countdown = JUMP_DELAY
		jump_reset = true
	elif is_on_floor and jump_reset == true and jump_countdown > 0:
		jump_countdown -= delta
	elif is_on_floor and jump_reset == true and jump_countdown <= 0:
		velocity.y = JUMP_VELOCITY
		fire_reset = true
		jump_reset = false

func _fire_projectile() -> void:
	var projectile: Projectile2D = pool.get_projectile()
	if projectile:
		projectile.global_position = fire_point.global_position
		projectile.activate()
		projectile.set_path()
