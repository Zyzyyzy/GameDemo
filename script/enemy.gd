extends CharacterBody2D

var speed = 30
var player_chase = false
var player = null
var player_back = false

func _physics_process(delta):
	if player_chase:
		if player_back:
			position += -(player.position).normalized() * 10
		else:
			position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
		

func _on_detection_aera_body_entered(body):
	player = body
	player_chase = true
	player_back = false


func _on_detection_aera_body_exited(body):
	player = null
	player_chase = false



func _on_hurtbox_hurt(hitbox: Hitbox) -> void:
	stats.health -= 1
	if stats.health == 0:
		queue_free()
@onready var stats: Node = $Stats#2024/5/9 23:01制作血量时添加——Buryn
#连接节点触发之后 史莱姆碰到玩家会被击退
func _on_hitbox_area_entered(area):
	print(area)
	player = area
	player_back = true
