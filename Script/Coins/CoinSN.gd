extends GoodCoin
class_name CoinSN

func byebye():
	target.life += 1
	target.life_plus = true
	super.byebye()


func _on_body_entered(body: Node3D) -> void:
	super._on_body_entered(body)
	
