extends CharacterBody2D

var speed = 65
var player_chase = false
var player = null

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
	
	if health <= 0:
			death()
	
	if player_chase && dead == false:
		if attackiert == true:
			await get_tree().create_timer(1.8).timeout
		else:
			if attackiert == false:
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
				if player_attack_zone == true && attackiert == false:
					attackiert = true 
					speed = 400
					$bla.play("swing_down")
					await get_tree().create_timer(0.3).timeout
					$hitbox_position.position.y = 50
					$animationtimer.start()
			if (player.position.x < position.x  && (player.position.x - position.x) < (player.position.y - position.y)):
				$bla.flip_h = true
				if player_attack_zone == true && attackiert == false: 
					attackiert = true 
					speed = 400
					$bla.play("swing")
					await get_tree().create_timer(0.3).timeout
					$hitbox_position.position.x = -50
					$animationtimer.start()
			if (player.position.y < position.y):
				if player_attack_zone == true && attackiert == false: 
					attackiert = true 
					speed = 400
					$bla.play("swing_up")
					await get_tree().create_timer(0.3).timeout
					$hitbox_position.position.y = -50
					$animationtimer.start()
			if (player.position.y > position.y):
				if player_attack_zone == true && attackiert == false: 
					attackiert = true 
					speed = 400
					$bla.play("swing")
					await get_tree().create_timer(0.3).timeout
					$hitbox_position.position.x = 50
					$animationtimer.start()
	else:
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
		if health <= 0:
			drop_leandrank()
			
func drop_leandrank():
	leandrank.visible = true

func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	attack_ip2 = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func power_up():
	power = 40
	await get_tree().create_timer(20).timeout
	power = 20

func death():
	dead = true
	await get_tree().create_timer(0.5).timeout
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
