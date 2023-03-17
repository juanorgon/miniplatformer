extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var climbing = false
@onready var sprite = $Sprite
@onready var ladder_detector = $LadderDetector


func _physics_process(delta):	
	var movement = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))	
	if climbing:
		climbing = ladder_detector.has_overlapping_bodies()
		velocity = movement * SPEED * .7
		if movement.x or movement.y:
			sprite.play("climb")
		else: sprite.pause()
	else:
		climbing = ladder_detector.has_overlapping_bodies() and movement.y
		if not is_on_floor():
			velocity.y += gravity * delta
			if (velocity.y <= 0):
				sprite.play("jump")
			else:
				sprite.play("fall")
		else:
			if velocity.x == 0:
				sprite.play("idle")
			else:
				sprite.play("run")

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		if movement.x:
			velocity.x = movement.x * SPEED
			sprite.flip_h = velocity.x < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

