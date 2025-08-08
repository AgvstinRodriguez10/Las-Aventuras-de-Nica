extends CanvasLayer

@onready var fpslabel = $Panel/FPS
@onready var drawCalls = $Panel/DrawCalls
@onready var objectsInFrame = $Panel/objectInFrame
@onready var vRam = $Panel/MemVRAM
@onready var textMem = $Panel/MemoryText

var fps_on : bool = false
var number = 1_000_000
var formated_number = format_number(number)

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	fpslabel.text = "FPS: " + str(Engine.get_frames_per_second())
	drawCalls.text = "DRAW CALLS: " + str(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME))
	objectsInFrame.text = "OBJECT COUNT: " + str(Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME))
	vRam.text = "VRAM: " + str(format_number(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED)))
	textMem.text = "MTexture: " + str(format_number(Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED)))
	
	if Input.is_action_just_pressed("FPS") and fps_on == false:
		fps_on = true
		show()
	elif Input.is_action_just_pressed("FPS") and fps_on == true:
		fps_on = false
		hide()
	
func format_number(n: int) -> String:
	if n >= 1_000_000:
		var i:float = snapped(float(n)/1000000, .01)
		return str(i).replace(",", ".") + "MB"
	elif n >= 1_000:
		var i:float = snapped(float(n)/1000, .01)
		return str(i).replace(",", ".") + "B"
	else:
		return str(n)
