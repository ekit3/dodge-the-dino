extends Node

@export var mob_scene: PackedScene
var score
# Called when the node enters the scene tree for the first time.


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()


func new_game() -> void:
	score = 0
	$Music.play()
	$Player.start($StartPosition.global_position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("GET READY")
	get_tree().call_group("mobs", "queue_free")


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout() -> void:
	# new mob
	var mob = mob_scene.instantiate()
	
	# Choose a random location on Path2d
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mod postion to this location
	mob.position = mob_spawn_location.position
	
	# set mob direction perpendicular to the direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	# randomize the direction
	direction += randf_range(- PI / 4, PI / 4)
	mob.rotation = direction
	
	# Velocity of th mob 
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
