extends Area2D

const EnemyStrength : int = 10 # Number of hits required to kill it.
const SpeedOfEnemy : float = 0.01
var health : int = EnemyStrength # This will be counted down for each hit.
var a : float = 0.0
var rng := RandomNumberGenerator.new()

onready var _explosion = preload("res://Assets/ShipExplosion.tscn")

func _ready():
	rng.randomize() # Randomize so we don't get the same random number every time we start the game.
	a = rng.randf_range(0,100) # Randomize where in the cycle of the going up and down.
	$TextureProgress.min_value = 0
	$TextureProgress.max_value = EnemyStrength
	
func _process(delta):
	# A sine wave makes the enemy ship go up and down
	position.y += sin(a) * 0.5
	a += SpeedOfEnemy
	$TextureProgress.value = health

func _on_Enemy_area_entered(area):
	# We shall only react to instances of bullets.
	if area is Bullet:
		# If a bullet area enter the Enemy area we kill that bullet and...
		area.queue_free()
		# ...flash to indicate a hit and...
		$AnimationPlayer.play("Flash") # The Animationplayer modulates from white (normal color) to red and then back to white. (Speed for the AnimationPlayer is speed up.
		# ...subscract from health...
		health -= 1
		# ...and kill the enemy if it reaches 0 or below.
		if health <= 0:
			# Instansiate an particle explosion
			var explo = _explosion.instance()
			# Position it as this ship
			explo.position = position
			explo.restart()
			# Pop goes the veasle.
			explo.set_emitting(true)
			get_parent().add_child(explo)
			# The  particle has a timer that removes the instance after 4 seconds.
			queue_free() # Remove the enemy from scene/memory.
