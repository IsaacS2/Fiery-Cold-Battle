extends Node

@onready var element_state: AudioStreamPlayer = $Elemental/element_state
@onready var adaptive_music: AudioStreamPlayer = $adaptive_music


func play_music():
	#$music.play()
	adaptive_music.play()
#region Test Tones

func play_test_loop():
	$test_tones/test_loop.play()

func play_test_sine():
	$test_tones/test_sine.play()

func play_test_saw():
	$test_tones/test_saw.play()

func play_test_square():
	$test_tones/test_square.play()
#endregion

#region Projectiles

func play_projectile_bounce():
	$Projectiles/projectile_bounce.play()

func play_player_gun_fire():
	$Projectiles/player_gun_fire.play()

func play_enemy_gun_fire():
	$Projectiles/enemy_gun_fire.play()

func play_projectile_absorbed():
	$Projectiles/projectile_absorbed.play()
	
func play_projectile_destroyed():
	$Projectiles/projectile_destroyed.play()
#endregion

#region Elemental

func play_fire_attack():
	$Elemental/fire_attack.play()

func play_ice_attack():
	$Elemental/ice_attack.play()
	
func play_zone_activation(zone_type):
	if zone_type == 'fire':
		play_fire_attack()
	elif zone_type == 'ice':
		play_ice_attack()
	else:
		pass
		
func play_elemental_state():
	pass

func switch_elemental_state(new_state):
	element_state['parameters/switch_to_clip'] = new_state
	adaptive_music['parameters/switch_to_clip'] = new_state
	
#endregion



#region Player
func play_player_footstep():
	$Player/player_fs.play()

func play_player_jump():
	$Player/player_jump.play()

func play_player_hurt():
	$Player/player_hurt.play()

func play_absorb_on():
	$Player/absorb_on.play()
	
func stop_absorb_on():
	$Player/absorb_on.stop()
	
	
#endregion

#region Enemies
func play_penguin_honk():
	$Enemies/penguin_honk.play()

func play_jerboa_squeal():
	$Enemies/jerboa_squeal.play()

func play_helicopter_explosion():
	$Enemies/helilcopter_explosion.play()

func play_enemy_footstep():
	$Enemies/enemy_fs.play()

func play_enemy_jump():
	$Enemies/enemy_jump.play()

func play_helicopter_loop():
	$Enemies/helicopter_blades.play()
	#pass
	
func stop_helicopter_loop():
	$Enemies/helicopter_blades.stop()

func play_enemy_death(death_cry):
	if death_cry == 'jerboa' :
		play_jerboa_squeal()
		print('jerrrrb')
	elif death_cry == 'penguin' :
		play_penguin_honk()
		print('honknhonk')
	elif death_cry == 'helicopter':
		stop_helicopter_loop()
		play_helicopter_explosion()
		print('da choppa')
		
		
	
#endregion

	
#func _ready() -> void:
	#play_music()
 
