extends CharacterBody3D

@onready var camera_3d = $Pivot/Camera3D
@onready var pivot = $Pivot
# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	#if direction != Vector3.ZERO:
		#direction = direction.normalized()
		#$Pivot.basis = Basis.looking_at(direction)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	
	
	
#func _input(event):
	#if event is InputEventMouseButton:
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#elif Input.is_action_just_pressed("ui_cancel"):
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		#
	#if event is InputEventMouseMotion:
		#camera_3d.rotate_x(-event.relative.y *0.005)
		#pivot.rotate_y(-event.relative.x*0.005)
		#camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))
