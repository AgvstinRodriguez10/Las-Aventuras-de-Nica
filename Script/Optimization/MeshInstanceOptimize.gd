extends MeshInstance3D

func _ready():
	# Obtener el nodo hijo
	var visibility_notifier: VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D
	
	if visibility_notifier:
		# Conectar señales correctamente
		visibility_notifier.screen_entered.connect(_on_visible_on_screen_notifier_3d_screen_entered)
		visibility_notifier.screen_exited.connect(_on_visible_on_screen_notifier_3d_screen_exited)

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	# Habilitar procesamiento
	set_process(true)

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
		# Deshabilitar procesamiento para optimizar
	set_process(false)
