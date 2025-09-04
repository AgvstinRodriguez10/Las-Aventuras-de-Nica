extends GoodCoin
class_name CoinSN

func byebye():
	target.collectSnFicha()
	userInterface.obtainCoin = true
	super.byebye()


func _on_body_entered(body: Player) -> void:
	super._on_body_entered(body)
	
