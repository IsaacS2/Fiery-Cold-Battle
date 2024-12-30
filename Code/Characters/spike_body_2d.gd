extends EnemyBody2D
class_name SpikeBody2D

const SPEED: float = 25
const ROTATION_RATE: float = 50

var anim: AnimatedSprite2D
var player: PlayerCharacter2D
var is_chasing: bool = false

func _enemy_specific_ready_override() -> void:
	player = get_tree().get_first_node_in_group(Groups.player_character)
	anim = $AnimatedSprite2D
	hit_points = 10000
	print(player)

func _physics_process(delta: float) -> void:
	if _should_chase() and not is_chasing:
		_start_chasing()
	
	if not _should_chase() and is_chasing:
		_stop_chasing()
	
	if is_chasing:
		anim.rotation_degrees += ROTATION_RATE * delta
		velocity = _update_chase(delta)
		
		move_and_slide()

func _should_chase() -> bool:
	if not player:
		return false
	if not player.grabber:
		return false
	if not player.grabber.currently_grabbing:
		return false
	return true

func _start_chasing() -> void:
	is_chasing = true

func _stop_chasing() -> void:
	is_chasing = false

func _update_chase(delta: float) -> Vector2:
	var path_vector: Vector2 = (player.global_position - global_position).normalized()
	velocity = path_vector * SPEED
	return velocity
