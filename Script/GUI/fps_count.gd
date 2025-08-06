extends CanvasLayer

@onready var fpslabel = $Panel/FPS
@onready var fpsdraw = $Panel/FPSD

var fps_on : bool = false

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	fpslabel.text = "FPS: " + str(Engine.get_frames_per_second())
	if Input.is_action_just_pressed("FPS") and fps_on == false:
		fps_on = true
		show()
	elif Input.is_action_just_pressed("FPS") and fps_on == true:
		fps_on = false
		hide()
