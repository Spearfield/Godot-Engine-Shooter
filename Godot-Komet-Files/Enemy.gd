extends Area2D

const EnemyStrength = 10
var health
var a = 0
var rng = RandomNumberGenerator.new()

func _ready():
	health = EnemyStrength
	rng.randomize() # Randomize so we don't get the same random number every time we start the game.
	a = rng.randf_range(0,100) # Randomize where in the cycle of the going up and down.
	
func _process(delta):
	# A sine wave makes the enemy ship go up and down
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
		queue_free() # Remove the enemy from memory.
