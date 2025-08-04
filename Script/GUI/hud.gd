extends CanvasLayer
class_name UI

@onready var labelPlus = $labelPlus
@onready var labelScore = $Label
@onready var animationPlayerHUD = $AnimationPlayer

@onready var player = $"../Nica"
@onready var yagui = $"../Enemies/Yagui 3D"
@onready var animationPlayer = $UI/labelScorePlus/AnimationPlayer



var labelCoins : Array

var score = 0
var score_plus = 0.2
var score_base = 0.2
var velocity_plus : int = 30
var velocity_plus_enemies : int = 30
var limit_max : int = 200

func _ready() -> void:
	labelPlus.hide()

func _process(delta: float) -> void:
	labelScore.text = str(score)
	
	if score < limit_max and player.is_movie == false:
		score += score_plus
	elif score > limit_max:
		score_plus += score_base
		limit_max = limit_max + score
		if player.velocity_z <= 600:
			player.velocity_z += velocity_plus
		else:
			player.velocity_z = 300
			yagui.velocity_z = 300
		
	labelScore.text = str(int(score))
	
	if player.is_hitt == true:
		if player.life == 2:
			animationPlayerHUD.play("Life3")
		elif player.life == 1:
			animationPlayerHUD.play("Life2")
		elif player.life == 0:
			$UI/Vida.hide()
	
	if player.life_plus == true:
		if player.life == 2:
			animationPlayerHUD.play("+Life2")
		elif player.life == 3:
			animationPlayerHUD.play("+Life3")
	

func add_point():
	var coins : Array
	var clonelabel = labelPlus.duplicate()
	clonelabel.show()
	add_child(clonelabel)
	
	score += 100
	coins = get_tree().get_nodes_in_group("Coins")


func _on_timer_timeout() -> void:
	player.life_plus = false
