extends GoodCoin
class_name CoinEcoFicha


func byebye():
	userInterface.add_point()
	super.byebye()
	

func _on_body_entered(body: Node3D) -> void:
	super._on_body_entered(body)
