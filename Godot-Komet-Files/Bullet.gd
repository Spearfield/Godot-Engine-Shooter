extends Area2D

const SPEED = 100
const MODULATE_ANIMATION_SPEED = 0.05
var direction = Vector2(0,0)
var a = 0

# This function is called from the Ships script.
func setDirection(dir):
	direction = dir

func _process(delta):
	# Make the glowsprite modulate the alpha (opacity) property to make it "blink" a little.
	$Glow.modulate.a = sin(a)
	a += MODULATE_ANIMATION_SPEED
	# Make it move.
	position += SPEED*delta*direction
	# Check if the bullet is outside the screen, then kill it.
	if not get_node("VisibilityNotifier2D").is_on_screen():
		print("Bullet exited screen")
		queue_free() # Destroy the bullet and remove it fmemory.
