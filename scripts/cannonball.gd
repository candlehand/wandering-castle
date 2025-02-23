extends Area2D

var velocity = Vector2(700, -250)
signal keep_hit
signal structure_hit

func _process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()


func _ready():
	self.body_entered.connect(_on_Area_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	position += transform.x * speed * delta


func _on_Area_body_entered(body):
	# special behavior if the projectile hits something in the "structure" group
	if body.is_in_group("structure"):
		self.queue_free()
		# print("Ball has hit the structure")
		structure_hit.emit(body)
		pass
	# behavior if it hits the keep
	if body.is_in_group("keep"):
		self.queue_free()
		# lower the hp
		# print("Ball has hit the keep")
		keep_hit.emit(body)
		pass
	
