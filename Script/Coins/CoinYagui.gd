extends CoinBase
class_name CoinYagui

func byebye():
	target.lostLife(1)
	super.byebye()
	
func _on_body_entered(body: Node3D) -> void:
	super._on_body_entered(body)
