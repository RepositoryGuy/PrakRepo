extends Node2D

var enemi = preload("res://skripte/enemi.tscn")

var enemi_can_spawn = false

var enemi_spawn_rate = 8

var where_spawn = 1 

func _ready():
	enemi_can_spawn = true

func _physics_process(delta):
	if enemi_can_spawn == true:
		enemispawn()

func enemispawn():
	enemi_can_spawn = false
	
	var instance = enemi.instantiate()
	
	var where_spawn = randf_range(0, 4)
	
	var Yenemi_spawn_up = randf_range(-600, -900)
	var Xenemi_spawn_up = randf_range(-400, 400)
	
	var Yenemi_spawn_down = randf_range(600, 900)
	var Xenemi_spawn_down = randf_range(-400, 400)
	
	var Yenemi_spawn_right = randf_range(-700, 700)
	var Xenemi_spawn_right = randf_range(800, 900)
	
	var Yenemi_spawn_left = randf_range(300, -400)
	var Xenemi_spawn_left = randf_range(-800, -900)
	
	
	
	if  (where_spawn >= 0 &&  where_spawn < 1 ):
		print("up")
		instance.position.y = $CharacterBody2D.position.y + Yenemi_spawn_up
		instance.position.x = $CharacterBody2D.position.x + Xenemi_spawn_up
	if (where_spawn >= 1 &&  where_spawn < 2 ):
		print("down")
		instance.position.y = $CharacterBody2D.position.y + Yenemi_spawn_down
		instance.position.x = $CharacterBody2D.position.x + Xenemi_spawn_down
	if (where_spawn >= 2 &&  where_spawn < 3 ):
		print("right")
		instance.position.y = $CharacterBody2D.position.y + Yenemi_spawn_right
		instance.position.x = $CharacterBody2D.position.x + Xenemi_spawn_right
	if (where_spawn >= 3 &&  where_spawn < 4 ):
		print("left")
		instance.position.y = $CharacterBody2D.position.y + Yenemi_spawn_left
		instance.position.x = $CharacterBody2D.position.x + Xenemi_spawn_left
		
	add_child(instance)
	
	print("hi")
	print(where_spawn)
	
	await get_tree().create_timer(enemi_spawn_rate).timeout
	enemi_can_spawn = true
	
	
	
