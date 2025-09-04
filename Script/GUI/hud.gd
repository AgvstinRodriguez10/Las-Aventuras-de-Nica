extends CanvasLayer
class_name UI

@onready var labelPlus = $labelPlus
@onready var labelScore = $LifeAndScoreContainer/ScoreBackgraund/Score
@onready var animationPlayerHUD = $AnimationPlayer

@onready var player = $"../Nica"
@onready var yagui = $"../Yagui"

@onready var dangerTimer = $"../Nica/Alert/TimerAlert"
@onready var dangerAnim = $"../DangerAlert/AnimationPlayer"
@onready var dangerCollision = $"../Nica/Alert/CollisionShape3D"

@onready var dictCoinsLbls:Dictionary = {
	"life": $LifeAndScoreContainer/SnCoinsIcon/lbl_snCoins,
	"eco": $CoinsContainer/EcoCoinsIcon/lbl_ecoCoins,
	"rd": $CoinsContainer/RdCoinsIcon/lbl_rdCoins
}
@onready var lifeBar = $LifeAndScoreContainer/LifeBar

var labelCoins : Array

var score = 0
var score_plus = 0.2
var score_base = 0.2
var velocity_plus : int = 30
var velocity_plus_enemies : int = 30
var limit_max : int = 200

var obtainCoin:bool = false
var isInanimationLifebar:bool = false

func _ready() -> void:
	labelPlus.hide()
	#$"../San Nicolas".queue_free()
	#$"../DirectionalLight3D".queue_free()
	#$"../Obstaculos".queue_free()
	#$"../EcoFichas".queue_free()
	#$"../SNFichas".queue_free()
	#$"../RDFichas".queue_free()
	#$"../Yagui".queue_free()
	dictCoinsLbls.life.text = str(3)
	
func _process(delta: float) -> void:
	score += 0.1
	
	labelScore.text = str(int(score))
	if player.is_hitt == true:
		dictCoinsLbls.life.text = str(player.life)
	if player.life_plus == true:
		dictCoinsLbls.life.text = str(player.life)
	
	if obtainCoin:
		obtainCoin = false
		animatedLifeBar()

func animatedLifeBar():
	isInanimationLifebar = true
	if (player.snficha == 3):
		player.life += 1
		player.life_plus = true
		player.snficha = 0
		lifeBar.value = 0
		isInanimationLifebar = false
		return
	elif isInanimationLifebar:
		var fillTarget = player.snficha * 100 / 3
		while lifeBar.value < fillTarget:
			lifeBar.value += 1
			await get_tree().create_timer(0).timeout
			#fillTarget = player.snficha * 100 / 3
			
	isInanimationLifebar = false

func add_point():
	var coins : Array
	var clonelabel = labelPlus.duplicate()
	clonelabel.show()
	add_child(clonelabel)
	
	score += 100
	coins = get_tree().get_nodes_in_group("Coins")

func _on_timer_timeout() -> void:
	player.life_plus = false

func upgradeVelocityZ():
	if player.velocity_z <= 600:
		player.velocity_z += velocity_plus
	else:
		player.velocity_z = 300

func lblCoinsActualizat(coin:String):
	match coin:
		"eco":
			dictCoinsLbls.eco.text = str(int(dictCoinsLbls.eco.text) + 1)
		"rd":
			dictCoinsLbls.rd.text = str(int(dictCoinsLbls.rd.text) + 1)

func _on_alert_body_entered(body: Node3D) -> void:
	if body.name == "Yagui" and dangerCollision.disabled == false:
		dangerAnim.play("ALERT")
		dangerCollision.disabled = true
		dangerTimer.start()


func _on_timer_alert_timeout() -> void:
	$"../Nica/Alert/CollisionShape3D".disabled = false
