extends GoodCoin
class_name CoinRD

func byebye():
	userInterface.upgradeVelocityZ()
	super.byebye()


func _on_body_entered(body: Node3D) -> void:
	super._on_body_entered(body)
