extends Area2D
class_name Bullet

const SPEED : float = 100.0
const MODULATE_ANIMATION_SPEED: float = 0.05
var direction : Vector2 = Vector2(0,0)
var a : float = 0.0

# This function is called from the Ships script.
func setDirection(direction):
	self.direction = direction

func _process(delta):
	# Make the glowsprite modulate the alpha (opacity) property to make it "pulse" a little.
	$Glow.modulate.a = sin(a)
	a += MODULATE_ANIMATION_SPEED
	# Make it move.
	position += SPEED*delta*direction
	# Check if the bullet is outside the screen, then remove it.
	if not get_node("VisibilityNotifier2D").is_on_screen():
		queue_free() # Destroy the bullet and remove it from memory.
