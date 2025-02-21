extends Area2D

var speed = 750

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	# special behavior if the projectile hits something in the "structure" group
	if body.is_in_group("structure"):
		body.queue_free()
	queue_free()
	
