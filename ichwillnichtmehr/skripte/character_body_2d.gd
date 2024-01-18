extends CharacterBody2D

var enemi_attackrange = false
var enemi_attack_cooldown = true
var health = 100
var player_alive = true


var powerpotion = false
var speedpotion = false
var armorpotion = false

@onready var power = 20

var slot1 = false
var slot2 = false
var slot3 = false
var slot4 = false

var item_slot1 = "none"
var item_slot2 = "none"
var item_slot3 = "none"
var item_slot4 = "none"

var was_item_collected = false

var item_name = "none"
var speed = 350

var toke_damage = false

var damage_enemi = 20

var slotnumber = 0

var current_dir = "none"

var attack_ip = false

@export var inventory: Inventory

var healshit = true

func _physics_process(delta):
	player_movement(delta)
	attack() 
	update_health()
	
	if healshit == true:
		heal()
	
	
	if was_item_collected == true:
		if Input.is_action_just_pressed("slot1") && slot1 == false:
			slot1 = true
			item_slot1 = item_name
			if item_slot1 == "leandrank":
				$leandrankInventory1.visible = true
			if item_slot1 == "xannydrank":
				$XannydrankInventory1.visible = true
			if item_slot1 == "MDMAdrank":
				$MDMADrankInventory1.visible = true
			print("slot1  ", slot1)
			was_item_collected = false
			
		if Input.is_action_just_pressed("slot2") && slot2 == false:
			slot2 = true 
			item_slot2 = item_name
			if item_slot2 == "leandrank":
				$leandrankInventory2.visible = true
			if item_slot2 == "xannydrank":
				$XannydrankInventory2.visible = true
			if item_slot2 == "MDMAdrank":
				$MDMADrankInventory2.visible = true
			print("slot2  ", slot2)
			was_item_collected = false
			
		if Input.is_action_just_pressed("slot3") && slot3 == false:
			slot3 = true 
			item_slot3 = item_name
			if item_slot3 == "leandrank":
				$leandrankInventory3.visible = true
			if item_slot3 == "xannydrank":
				$XannydrankInventory3.visible = true
			if item_slot3 == "MDMAdrank":
				$MDMADrankInventory3.visible = true
			print("slot3  ", slot3)
			was_item_collected = false
			
		if Input.is_action_just_pressed("slot4") && slot4 == false:
			slot4 = true 
			item_slot4 = item_name
			if item_slot4 == "leandrank":
				$leandrankInventory4.visible = true
			if item_slot4 == "xannydrank":
				$XannydrankInventory4.visible = true
			if item_slot4 == "MDMAdrank":
				$MDMADrankInventory4.visible = true
			print("slot4  ", slot4)
			was_item_collected = false
			
		
	
	if slot1 == true :
		await get_tree().create_timer(0.5).timeout
		if Input.is_action_just_pressed("slot1"):
			if item_slot1 == "leandrank":
				$leandrankInventory1.visible = false
				speed = 600
				speedpotion = true 
			if item_slot1 == "xannydrank":
				$XannydrankInventory1.visible = false
				var ref_a = get_tree().current_scene.get_node("enemi")
				ref_a.power_up()
			if item_slot1 == "MDMAdrank":
				$MDMADrankInventory1.visible = false
				armorpotion = true
			slotnumber = (slotnumber - 1)
			item_slot1 = "none"
			slot1 = false
	if slot2 == true :
		await get_tree().create_timer(0.5).timeout
		if Input.is_action_just_pressed("slot2"):
			if item_slot2 == "leandrank":
				$leandrankInventory2.visible = false
				speed = 600
				speedpotion = true 
			if item_slot2 == "xannydrank":
				$XannydrankInventory2.visible = false
				var ref_a = get_tree().current_scene.get_node("enemi")
				ref_a.power_up()
			if item_slot2 == "MDMAdrank":
				$MDMADrankInventory2.visible = false
				armorpotion = true
			slotnumber = (slotnumber - 1)
			item_slot2 = "none"
			slot2 = false
	if slot3 == true :
		await get_tree().create_timer(0.5).timeout
		if Input.is_action_just_pressed("slot3"):
			if item_slot3 == "leandrank":
				$leandrankInventory3.visible = false
				speed = 600 - 1
				speedpotion = true 
			if item_slot3 == "xannydrank":
				$XannydrankInventory3.visible = false
				var ref_a = get_tree().current_scene.get_node("enemi")
				ref_a.power_up()
			if item_slot3 == "MDMAdrank":
				$MDMADrankInventory3.visible = false
				armorpotion = true
			slotnumber = (slotnumber - 1)
			item_slot3 = "none"
			slot3 = false
	if slot4 == true :
		await get_tree().create_timer(0.5).timeout
		if Input.is_action_just_pressed("slot4"):
			if item_slot4 == "leandrank":
				$leandrankInventory4.visible = false
				speed = 600
				speedpotion = true
			if item_slot4 == "xannydrank":
				$XannydrankInventory4.visible = false
				var ref_a = get_tree().current_scene.get_node("enemi")
				ref_a.power_up()
			if item_slot4 == "MDMAdrank":
				$MDMADrankInventory4.visible = false
				armorpotion = true
			slotnumber = (slotnumber - 1)
			item_slot4 = "none"
			slot4 = false
				
	if speedpotion == true :
		speed_potion_end()
	if armorpotion == true :
		armor_potion_end()
	if health <= 0:
		player_alive = false
		health = 0
		print("du bist tot digga opfer 3$ to revive")
		self.queue_free()
		
func armor_potion_end():
	armorpotion = false
	damage_enemi = 10
	await get_tree().create_timer(30).timeout
	damage_enemi = 20
	


func speed_potion_end():
	speedpotion = false
	$Camera2D.zoom.x = 0.8
	$Camera2D.zoom.y = 0.8
	await get_tree().create_timer(10).timeout
	speed = 350
	$Camera2D.zoom.x = 1
	$Camera2D.zoom.y = 1
	print("eeee")
	

func player_movement(delta):
	if attack_ip == false:
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


func enemi_attack():
	if  enemi_attack_cooldown == true:
		health = health - damage_enemi
		enemi_attack_cooldown = false
		print("health =", health)
		if health <= 0:
			self.queue_free()
		await get_tree().create_timer(0.7).timeout
		enemi_attack_cooldown = true
		toke_damage = true
		tokedamage()
		

func tokedamage():
	await get_tree().create_timer(14).timeout
	toke_damage = false

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("swing"):
		Globalanal.player_current_attack = true 
		attack_ip = true 
		$AnimationPlayer.play("hitboxkommwieder")
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("swing")    
			await get_tree().create_timer(0.3).timeout
			$sword_hitbox_position.position.x = 60
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("swing")
			$sword_hitbox_position.position.x = -60
			await get_tree().create_timer(0.3).timeout
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("swing_down")
			$sword_hitbox_position.position.y = 60
			await get_tree().create_timer(0.3).timeout
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("swing_up")
			$sword_hitbox_position.position.y = -60
			await get_tree().create_timer(0.3).timeout
			$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	$AnimationPlayer.play("hitboxgehweg")
	$sword_hitbox_position.position.x = 0
	$sword_hitbox_position.position.y = 0
	Globalanal.player_current_attack = false
	attack_ip = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
	
func heal():
	healshit = false 
	await get_tree().create_timer(5).timeout
	if toke_damage == true:
		pass
		healshit = true
	else:
		if health < 100:
			health = health + 20
			if health > 100:
				health = 100
		if health <= 0:
			health = 0
		healshit = true


func collectlean():
	slotnumber = (slotnumber + 1)
	item_name = "leandrank"
	was_item_collected = true
func collectxanny():
	slotnumber = (slotnumber + 1)
	item_name = "xannydrank"
	was_item_collected = true
func collectMDMA():
	slotnumber = (slotnumber + 1)
	item_name = "MDMAdrank"
	was_item_collected = true


func _on_hurtbox_area_entered(area):
	if "enemi_hitbox" in area.name:
		enemi_attack()
	if "leandrank" in area.name && slotnumber < 4 && was_item_collected == false:
		area.collectlean()
		collectlean()
	if "xannydrank" in area.name && slotnumber < 4 && was_item_collected == false:
		area.collectxanny()
		collectxanny()
	if "MDMAdrank" in area.name && slotnumber < 4 && was_item_collected == false:
		area.collectMDMA()
		collectMDMA()
	
