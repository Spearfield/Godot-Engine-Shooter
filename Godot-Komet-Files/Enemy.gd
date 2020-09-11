extends Area2D

const EnemyStrength = 10
var health
var a = 0
var rng = RandomNumberGenerator.new()

func _ready():
	health = EnemyStrength
	rng.randomize()
	a = rng.randf_range(0,100) # Make wwhere in the cycle of the going up and down random.
	
func _process(delta):
	# A nice sine wave makes the enemy ship go up and down
	position.y += sin(a) * 0.5
	a += 0.01
	pass

func _on_Enemy_area_entered(area):
	# If a bullet enter the Enemy area we kill that bullet and
	area.queue_free()
	# Flash to indicate a hit and
	$AnimationPlayer.play("Flash") # The Animationplayer modulates from white (normal color) to red and then back to white. (Speed for ther AnimationPlayer is speed up.
	# Subscract from health
	health -= 1
	# And kill the enemy if it reaches 0 or below.
	if health <= 0:
		queue_free()
