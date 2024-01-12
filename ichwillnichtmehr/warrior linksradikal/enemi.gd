extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null
var player_attak = false 

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed

		$AnimationSprite2D.play("run")
		
		if(player.position.x - position.x) < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
	else:
		$AnimationSprite2D.play("idle")
	
	if player_attak:
		var speed = 0
		$AnimationSprite3D.play("attak")
		
		
		
		






func _on_area_2d_body_entered(body):
	player = body
	player_chase = true

func _on_area_2d_body_exited(body):
	player = null
	player_chase = false


func _on_angriff_body_entered(body):
	player = body
	player_attak = true

func _on_angriff_body_exited(body):
	player = null
	player_attak = false
	








