extends CanvasLayer

class_name ui
signal game_started
var game_points = 0

@onready var end_of_game_screen = $end_of_game_screen
@onready var during_game_screen = $during_game_screen

func _ready():
	$during_game_screen/points.text = "%d" % 0

func update_points(points: int):
	game_points = points
	$during_game_screen/points.text = "%d" % points

func on_game_over():
	during_game_screen.visible = false
	end_of_game_screen.visible = true
	$end_of_game_screen/end_game_scoreDisplay/points.text = "%d" % game_points

func _on_restart_button_pressed():
	get_tree().reload_current_scene()



func _on_play_button_pressed():
	pass
