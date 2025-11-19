extends CanvasLayer

@onready var lbl_eco: Label = $Panel/Puntaje/lbl_eco
@onready var lblx_life: Label = $Panel/Puntaje/lblx10
@onready var lblx_rd: Label = $Panel/Puntaje/lblx5
@onready var lbl_total: Label = $Panel/Puntaje/lbl_total
@onready var hud: UI = $"../HUD"
@onready var nica: Player = $"../Nica"


var puntajeBase: float
var puntajeTotal: float
var puntajeTotalMostrado: float

var fadeInFinish := false

var currentState
enum STATE { 
	OFF,
	PUNTAJE_BASE,
	PUNTAJE_ECOFICHA,
	PUNTAJE_VIDAS,
	PUNTAJE_RD,
	PUNTAJE_TOTAL
}

func _ready() -> void:
	hide()
	currentState = STATE.OFF
	
func _process(delta: float) -> void:
	if !fadeInFinish:
		return
	
	match  currentState:
		STATE.OFF:
			return
		STATE.PUNTAJE_BASE:
			if actualizarTotal(puntajeBase,delta):
				return
			else:
				currentState = STATE.PUNTAJE_ECOFICHA
		STATE.PUNTAJE_ECOFICHA:
			calcularMultiplicadores(lbl_eco, 2.0, float(hud.dictCoinsLbls.eco.text), STATE.PUNTAJE_VIDAS)
		STATE.PUNTAJE_VIDAS:
			calcularMultiplicadores(lblx_life, 10.0, float(hud.dictCoinsLbls.life.text),STATE.PUNTAJE_RD)
		STATE.PUNTAJE_RD:
			calcularMultiplicadores(lblx_rd, 5.0, float(hud.dictCoinsLbls.rd.text), STATE.PUNTAJE_TOTAL)
		STATE.PUNTAJE_TOTAL:
			if actualizarTotal(puntajeTotal ,delta):
				return
			else:
				currentState = STATE.OFF
			
	
func calcularMultiplicadores(lbl:Label, multi:float, points:float, siguienteState:STATE):
	lbl.text = lbl.text + str(int(points))
	lbl.text = str(int(multi * points))
	puntajeTotal = puntajeTotal + multi * points
	currentState = siguienteState
	
	
func actualizarTotal(objetivo:float, delta) -> bool:
	if puntajeTotalMostrado <= objetivo - 0.1:
		puntajeTotalMostrado = lerpf(puntajeTotalMostrado, objetivo, 10 * delta)
		lbl_total.text = str(int(round(puntajeTotalMostrado)))
		return true
	else:
		return false
	
func _on_reintentar_pressed() -> void:
	get_tree().reload_current_scene()

func _on_salir_pressed() -> void:
	get_tree().quit()

func finished():
	show()
	$AnimationPlayer.play("PuntajeFinal")
	puntajeBase = float(hud.labelScore.text)
	puntajeTotal = puntajeBase

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	fadeInFinish = true
	currentState = STATE.PUNTAJE_BASE
