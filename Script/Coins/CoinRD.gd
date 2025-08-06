extends GoodCoin
class_name CoinRD

func byebye():
	#userInterface.upgradeVelocityZ()
	target.setPower(target.POWERUPSTATE.SPEEDUP)
	super.byebye()

func _on_body_entered(body: Node3D) -> void:
	super._on_body_entered(body)
