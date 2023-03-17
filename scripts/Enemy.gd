extends CharacterBody2D

@export var speed : int = 50

@onready var sprite = $AnimatedSprite2D
@onready var ledge_detector = $RayCast2D

var direction : Vector2 = Vector2.LEFT

func _ready():
	sprite.play()
	
func _physics_process(delta):
	if is_on_wall() or not ledge_detector.is_colliding():
		direction *= -1
		sprite.flip_h = !sprite.flip_h
	velocity = direction * speed
	move_and_slide()
