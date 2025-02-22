extends Area2D

var velocity = Vector2(700, -250)


func _process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()


func _on_BallisticBullet_body_entered(body):
	queue_free()


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	position += transform.x * speed * delta

#func _on_Bullet_body_entered(body):
	# special behavior if the projectile hits something in the "structure" group
#	if body.is_in_group("structure"):
#		body.queue_free()
#	queue_free()
	
