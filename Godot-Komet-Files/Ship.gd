extends Node2D

# So we later can instance a bullet.
onready var _bullet = preload("res://Bullet.tscn")

func _process(delta):
	# Get the angle from the mouse pointer used for rotate the ships sprite towards it
	var angle = get_angle_to(get_global_mouse_position())
	# Get the direction Vector2 from The ship and mouse pointer so we let the bullet travel this patch
	var theDirection = ( get_global_mouse_position() - self.position ).normalized()
	$Sprite.rotation = angle
	if Input.is_action_just_pressed("click"):
		# If we click the mousebutton we instantiate a new bullet
		var b = _bullet.instance()
		# Call the function in the bullets script which direction it should go
		b.setDirection(theDirection)
		# Fiddle with where the start of the bullet should be (not from the center of the ship but from its tip)
		b.position.x = theDirection.x * 20
		b.position.y = theDirection.y * 20
		# Ad it to the sceene
		add_child(b)
