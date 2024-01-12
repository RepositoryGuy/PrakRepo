extends CharacterBody2D

var enemi_attackrange = false
var enemi_attack_cooldown = true
var health = 100
var player_alive = true

const speed = 350
var current_dir = "none"

var attack_ip = false

func _physics_process(delta):
	player_movement(delta)
	enemi_attack()
	attack() 
	
	if health <= 0:
		player_alive = false
		health = 0
		print("du bist tot digga opfer 3$ to revive")
		self.queue_free()
		

func player_movement(delta):
	
	if Input.is_action_pressed("right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_anim(moving):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if moving == 1:
			anim.play("run")
		elif moving == 0:
			if attack_ip == false:
				anim.play("idle")
				
	if dir == "left":
		anim.flip_h = true
		if moving == 1:
			anim.play("run")
		elif moving == 0:
			if attack_ip == false:
				anim.play("idle")
			
	if dir == "up":
		if moving == 1:
			anim.play("run")
		elif moving == 0:
			if attack_ip == false:
				anim.play("idle")
			
	if dir == "down":
		if moving == 1:
			anim.play("run")
		elif moving == 0:
			if attack_ip == false:
				anim.play("idle")

func player():
	pass

	
func _on_hitbox_player_body_entered(body):
	if body.has_method("enemi"):
		enemi_attackrange = true

func _on_hitbox_player_body_exited(body):
	if body.has_method("enemi"):
		enemi_attackrange = false
		
func enemi_attack():
	if enemi_attackrange and enemi_attack_cooldown == true:
		health = health -20
		enemi_attack_cooldown = false
		$attack_cooldown.start()
		print(health)



func _on_attack_cooldown_timeout():
	enemi_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("swing"):
		Globalanal.player_current_attack= true 
		attack_ip = true 
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("swing")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("swing")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("swing_down")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("swing_up")
			$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Globalanal.player_current_attack = false
	attack_ip = false

