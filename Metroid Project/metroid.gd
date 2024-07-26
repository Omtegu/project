extends CharacterBody2D

var health = 100
const SPEED = 80
const JUMP_VELOCITY = -270.0
var Morph = 0
var Spin = 0
const SHOT =preload("res://shot.gd")
var Dir = 1


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_left"):
		Dir = 1
	if Input.is_action_just_pressed("ui_right"):
		Dir = 0
	move_and_slide()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if Morph == 0:
			if Spin == 0:
				$AnimatedSprite2D.play("Ju")
			if Spin == 1:
				if Dir == 0:
					velocity.x = 200
				if Dir == 1:
					velocity.x = -200
				$AnimatedSprite2D.play("Jump")
		if Morph == 1:
			$AnimatedSprite2D.play("ball")
	if is_on_floor():
		Spin = 0

		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if Input.is_action_pressed("ui_right"):
			Dir = 0
			$AnimatedSprite2D.play("Jump")
			Spin = 1
		if Input.is_action_pressed("ui_left"):
			Dir = 1
			Spin = 1
			$AnimatedSprite2D.play("Jump")
		velocity.y = JUMP_VELOCITY
		$CollisionShape2D.disabled = false
		$AnimatedSprite2D.play("default")
		Morph = 0
		
	if Input.is_action_just_pressed("SHOOT"):
		pass
		
		
	if Input.is_action_just_pressed("downarrow"):
		$CollisionShape2D.disabled = true
		Morph = 1
		$AnimatedSprite2D.play("ball")
		pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if Morph == 0:
			if is_on_floor():
				$AnimatedSprite2D.play("Walk")
	else:
		if is_on_floor():
			if Morph == 0:
				$AnimatedSprite2D.play("default")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		pass
		

