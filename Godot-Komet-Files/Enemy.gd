extends Area2D

const EnemyStrength = 10 # Number of hits required to kill it.
const SpeedOfEnemy = 0.01
var health = EnemyStrength # This will be counted down for each hit.
var a = 0
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize() # Randomize so we don't get the same random number every time we start the game.
	a = rng.randf_range(0,100) # Randomize where in the cycle of the going up and down.
	
func _process(delta):
	# A sine wave makes the enemy ship go up and down
	position.y += sin(a) * 0.5
	a += SpeedOfEnemy

func _on_Enemy_area_entered(area):
	# If a bullet area enter the Enemy area we kill that bullet and...
	area.queue_free()
	# ...flash to indicate a hit and...
	$AnimationPlayer.play("Flash") # The Animationplayer modulates from white (normal color) to red and then back to white. (Speed for ther AnimationPlayer is speed up.
	# ...subscract from health...
	health -= 1
	# ...and kill the enemy if it reaches 0 or below.
	if health <= 0:
		queue_free() # Remove the enemy from scene/memory.
