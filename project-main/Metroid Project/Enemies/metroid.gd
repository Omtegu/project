extends CharacterBody2D

var health = 100
var SPEED = 80
const JUMP_VELOCITY = -270.0
var Morph = 0
var MorphCollect = 1
var Spin = 0
var Dir = 1
var direction := 1
const SHOT = preload("res://Samus/shot.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	$Camera2D/Label.text = str(health)
	direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("SHOOT"):
		var shot = SHOT.instantiate()
		shot.global_position = global_position
		shot.direction = Vector2i(direction, 0)
		get_parent().add_child(shot)
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
	
	if Input.is_action_just_pressed("up arrow"):
		Morph = 0
		Spin = 0

# Run Button
	if Input.is_action_pressed("RUN"):
		SPEED = 240
	else:
		SPEED = 80
		

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
	if Input.is_action_just_pressed("ui_accept") and is_on_wall_only():
		if Dir == 0:
			$AnimatedSprite2D.flip_h = true
			Dir = 1
		else:
			$AnimatedSprite2D.flip_h = false
			Dir = 0
		if Spin == 1:
			velocity.y = -180
		
	if Input.is_action_just_pressed("SHOOT"):
		pass
		
		
	if Input.is_action_just_pressed("downarrow"):
		if MorphCollect == 1:
			Spin = 0
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
	if Spin == 1:
		if Dir == 1:
			velocity.x = -160
		if Dir == 0:
			velocity.x = 160
		pass
		

func _on_morph_collect_area_entered(area):
	var MorphCollect = 1
	pass # 
