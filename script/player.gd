extends CharacterBody2D

const accel = 800
#最大速度
const max_speed = 110
const friction = 600

var velocity2 = Vector2.ZERO

enum{
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

@onready var state_machine = $AnimationTree.get("parameters/playback")

func _ready():
	$AnimationTree.active = true
	$AnimationTree.set("parameters/idel/blend_position", Vector2.DOWN)

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		ROLL:
			pass
		
		ATTACK:
			attack_state(delta)
			
#玩家行动逻辑
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	input_vector.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		$AnimationTree.set("parameters/idel/blend_position", input_vector)
		$AnimationTree.set("parameters/move/blend_position", input_vector)
		$AnimationTree.set("parameters/attack/blend_position", input_vector)
		state_machine.travel("move")
		velocity2 = velocity2.move_toward(input_vector * max_speed, accel * delta)
	else:
		velocity2 = velocity2.move_toward(Vector2.ZERO, friction * delta)
		state_machine.travel("idel")
		
	move_and_collide(velocity2 * delta)
	
	#攻击
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
#攻击
func attack_state(delta):
	state_machine.travel("attack")
	
func attack_animation_finished():
	state = MOVE
	
func roll_state():
	pass
