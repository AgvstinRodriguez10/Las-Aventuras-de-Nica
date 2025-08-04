extends CanvasLayer

@onready var animationPlayer = $AnimationPlayer

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false:
		get_tree().paused = true
		animationPlayer.play("animPause")
	elif Input.is_action_just_pressed("Escape") and get_tree().paused == true:
		get_tree().paused = false
		hide()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/GUI/menu_inicio.tscn")
