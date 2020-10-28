extends CPUParticles2D

func _ready():
	pass # Replace with function body.

# Clean up instance.
func _on_Timer_timeout():
	queue_free()
