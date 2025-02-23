extends RigidBody2D


var health = 10

func ready():
  pass

func _process(delta):
  if health <= 0:
	queue_free()
	pass
