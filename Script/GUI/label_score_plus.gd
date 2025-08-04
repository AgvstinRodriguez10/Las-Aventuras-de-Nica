extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var this_animation : AnimationPlayer = $AnimationPlayer
	if visible :
		this_animation.play("scorePlus")

func delete_label():
	queue_free()
	
