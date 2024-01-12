extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null

var health = 100
var player_attack_zone = false
var can_take_damage

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/speed
		$bla.play("run")
		
		if(player.position.x - position.x) < 0:
			$bla.flip_h = true
		else:
			$bla.flip_h = false
	else:
		$bla.play("idle")
	
func _on_chase_body_entered(body):
	player = body
	player_chase = true

func _on_chase_body_exited(body):
	player = null
	player_chase = false


func enemi():
	pass


func _on_hitbox_enemi_body_entered(body):
	if body.has_method("player"):
		player_attack_zone = true 
	


func _on_hitbox_enemi_body_exited(body):
		if body.has_method("player"):
			player_attack_zone = false
		
func deal_with_damage():
	if player_attack_zone and Globalanal.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20 
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health =", health)
			if health <= 0:
				self.queue_free()
		


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
