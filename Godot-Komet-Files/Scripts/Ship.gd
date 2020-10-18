extends Node2D

# Constant (a value that does not change) for the function lerp_angle used in this script.
const ShipRotationSmoothness : float = 0.075

# So we later can instance a bullet.
onready var _bullet = preload("res://Assets/Bullet.tscn")

var oldAngle : float = 0.0

func _process(delta):
	# Get the angle from the mouse pointer used for rotate the ships sprite towards it
	var angle : float = get_angle_to(get_global_mouse_position())
	# Get the direction Vector2 from The ship and mouse pointer so we let the bullet travel this path
	var theDirection : Vector2 = ( get_global_mouse_position() - self.position ).normalized()
	var toRot : float = lerp_angle(oldAngle,angle,ShipRotationSmoothness) # Smooth out mouse movement using interpolation function lerp_angle (https://docs.godotengine.org/en/3.2/classes/class_@gdscript.html#class-gdscript-method-lerp-angle)
	oldAngle = toRot
	$Sprite.rotation = toRot
	if Input.is_action_just_pressed("click"):
		# If we click the mousebutton we instantiate a new bullet
		var b = _bullet.instance()
		# Call the function in the bullets script which direction it should go
		b.setDirection(theDirection)
		# Fiddle with where the start of the bullet should be (not from the center of the ship but from its tip)
		b.position.x = theDirection.x * 20
		b.position.y = theDirection.y * 20
		# Add it to the sceene
		add_child(b)
