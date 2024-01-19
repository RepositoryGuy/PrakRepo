extends CharacterBody2D

var speed = 65
var player_chase = false
var player = null

var itemdrop = 0

var dead = false

var power = 20

var health = 80
var player_attack_zone = false
var can_take_damage = true
var enemi

@onready var leandrank = $leandrank
@onready var itemRes: InventoryItem

var attackiert = false

var attack_ip2
func _ready():
	$bla.play("idle")
	$AnimationPlayer.play("hitboxgehweg")

func _physics_process(delta):
	update_health()
	
	if health <= 0 && dead == false:
		death()
	
	if player_chase && dead == false:
		$AnimationPlayer.play("idle")
		if attackiert == true:
			await get_tree().create_timer(1.8).timeout
	if player_chase == true && dead == false:
			if attackiert == false && dead == false:
				position += (player.position - position)/speed
				$bla.play("run")
			
			$AnimationPlayer.play("hitboxkommwieder")
			if player.position.x == null:
				return
			if player.position.y == null:
				return
			if (player.position.x < position.x):
				$bla.flip_h = true
			else:
				$bla.flip_h = false
			if (player.position.x > position.x && (player.position.x - position.x) < (player.position.y - position.y)):
				$bla.flip_h = false
				if player_attack_zone == true && attackiert == false && dead == false:
					attackiert = true 
					speed = 400
					$bla.play("swing_down")
					await get_tree().create_timer(0.3).timeout
					$hitbox_position.position.y = 50
					$animationtimer.start()
			if (player.position.x < position.x  && (player.position.x - position.x) < (player.position.y - position.y)):
				$bla.flip_h = true
				if player_attack_zone == true && attackiert == false && dead == false:
					attackiert = true 
					speed = 400
					$bla.play("swing")
					await get_tree().create_timer(0.3).timeout
					$hitbox_position.position.x = -50
					$animationtimer.start()
			if (player.position.y < position.y):
				if player_attack_zone == true && attackiert == false && dead == false:
					attackiert = true 
					speed = 400
					$bla.play("swing_up")
					await get_tree().create_timer(0.3).timeout
					$hitbox_position.position.y = -50
					$animationtimer.start()
			if (player.position.y > position.y):
				if player_attack_zone == true && attackiert == false && dead == false:
					attackiert = true 
					speed = 400
					$bla.play("swing")
					await get_tree().create_timer(0.3).timeout
					$hitbox_position.position.x = 50
					$animationtimer.start()
	else:
		if dead == false:
			$bla.play("idle")

func _on_chase_body_entered(body):
		player = body
		player_chase = true

func _on_chase_body_exited(body):
	player = null
	player_chase = false

func _on_animationtimer_timeout():
	$animationtimer.stop
	$hitbox_position.position.x = 0
	$hitbox_position.position.y = 0
	$AnimationPlayer.play("hitboxgehweg")
	await get_tree().create_timer(0.3).timeout
	attackiert = false
	speed = 65

func _on_player_attack_zone_body_entered(body):
	if body.has_method("player"):
		player_attack_zone = true 

func _on_player_attack_zone_body_exited(body):
		if body.has_method("player"):
			player_attack_zone = false
		
func deal_with_damage():
	if can_take_damage == true:
		health = health - power 
		$take_damage_cooldown.start()
		can_take_damage = false
		print("slime health =", health)
			

func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	attack_ip2 = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 80 or health < 1 :
		healthbar.visible = false
	else:
		healthbar.visible = true

func power_up():
	power = 40
	await get_tree().create_timer(20).timeout
	power = 20

func death():
	dead = true
	$bla.play("death")
	$AnimationPlayer.play("hitboxgehweg")
	var itemdrop = randf_range(0, 30)
	if (itemdrop >= 0 && itemdrop < 12 ):
		$AnimationPlayer.play("hitboxgehweg")
		await get_tree().create_timer(1.5).timeout
		self.queue_free()
	if (itemdrop >= 12 && itemdrop < 18 ):
		$AnimationPlayer.play("hitboxgehweg")
		await get_tree().create_timer(1).timeout
		$leandrank.monitorable = true
		$leandrank.visible= true
		print("lean")
	if (itemdrop >= 18 && itemdrop < 24 ):
		$AnimationPlayer.play("hitboxgehweg")
		await get_tree().create_timer(1).timeout
		$xannydrank.monitorable = true
		$xannydrank.visible = true
		print("xanny")
	if (itemdrop >= 24 && itemdrop < 30 ):
		$AnimationPlayer.play("hitboxgehweg")
		await get_tree().create_timer(1).timeout
		$MDMAdrank.monitorable = true
		$MDMAdrank.visible = true
		print("mdma")
	await get_tree().create_timer(0.6).timeout
	$bla.visible = false
	$CollisionShape2D.disabled = true
	$healthbar.visible = false
	

func _on_area_2d_area_entered(area):
	if "hitbox_player" in area.name:
		deal_with_damage()



func _on_leandrank_body_entered(body):
	if "player" in body.name:
		await get_tree().create_timer(0.3).timeout
		self.queue_free()
func _on_mdm_adrank_body_entered(body):
	if "player" in body.name:
		await get_tree().create_timer(0.3).timeout
		self.queue_free()
func _on_xannydrank_body_entered(body):
	if "player" in body.name:
		await get_tree().create_timer(0.3).timeout
		self.queue_free()

func _on_despawn_body_exited(body):
	self.queue_free()

