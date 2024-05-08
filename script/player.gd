extends CharacterBody2D

const accel = 500
const max_speed = 80
const friction = 500

var velocity2 = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	input_vector.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity2 = velocity2.move_toward(input_vector * max_speed, accel * delta)
	else:
		velocity2 = velocity2.move_toward(Vector2.ZERO, friction * delta)
		
	move_and_collide(velocity2 * delta)

#const speed = 100
#var current_dir = "none"
#
#func _ready():
	#$AnimatedSprite2D.play("front_idle")
#
#func _physics_process(delta):
	#player_movement(delta)
#
#func player_movement(delta):
	#
	#if Input.is_action_pressed('ui_right'):
		#current_dir = 'right'
		#play_anim(1)
		#velocity.x = speed
		#velocity.y = 0
	#elif Input.is_action_pressed('ui_left'):
		#current_dir = 'left'
		#play_anim(1)
		#velocity.x = -speed
		#velocity.y = 0
	#elif Input.is_action_pressed('ui_down'):
		#current_dir = 'down'
		#play_anim(1)
		#velocity.y = speed
		#velocity.x = 0
	#elif Input.is_action_pressed('ui_up'):
		#current_dir = 'up'
		#play_anim(1)
		#velocity.y = -speed
		#velocity.x = 0
	#else:
		#play_anim(0)
		#velocity.y = 0
		#velocity.x = 0
	#move_and_slide()
#
#func play_anim(movement):
	#var dir = current_dir
	#var anim = $AnimatedSprite2D
	#
	#if dir == 'right':
		#anim.flip_h = false
		#if movement == 1:
			#anim.play('side_walk')
		#elif movement == 0:
			#anim.play('side_idle')
	#if dir == 'left':
		#anim.flip_h = true
		#if movement == 1:
			#anim.play('side_walk')
		#elif movement == 0:
			#anim.play('side_idle')
	#if dir == 'down':
		#anim.flip_h = true
		#if movement == 1:
			#anim.play('front_walk')
		#elif movement == 0:
			#anim.play('front_idle')
	#if dir == 'up':
		#anim.flip_h = true
		#if movement == 1:
			#anim.play('back_walk')
		#elif movement == 0:
			#anim.play('back_idle')
