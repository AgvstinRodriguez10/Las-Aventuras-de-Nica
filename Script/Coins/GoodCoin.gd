extends CoinBase
class_name GoodCoin

var baseShape:BoxShape3D

var powerUpBigArea:bool = false
var durationPowerUp = 10
var currentTimePowerUp

func _ready() -> void:
	super._ready()
	baseShape = collision.shape

func _physics_process(delta: float) -> void:
	if powerUpBigArea:
		if currentTimePowerUp > 0:
			currentTimePowerUp -= delta
		else:
			powerUpBigArea = false
			collision.shape = baseShape
	super._physics_process(delta)

func powerUp():
	if !powerUpBigArea:
		var newBoxShape = BoxShape3D.new()
		newBoxShape.size.x = 4
		newBoxShape.size.y = 2
		newBoxShape.size.z = 2
		collision.shape = newBoxShape
		currentTimePowerUp = durationPowerUp
		powerUpBigArea = true
