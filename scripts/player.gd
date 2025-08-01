extends CharacterBody2D

signal enemy_close
signal enemy_not_close

@onready var score_label: Label = %Score

@export var planet_center: Vector2
@export var planet_radius := 120
@export var player_height := 70

var facing_left := false
var is_slashing := false
var had_passed_tutorial := false

const MIN_ZOOM := Vector2(0.9, 0.9)
const MAX_ZOOM := Vector2(1.1, 1.1)
const ZOOM_THRESHOLD := 200.0
const ATTACK_OFFSET := 14

func _physics_process(delta) -> void:
    if is_slashing:
        return
    if Input.is_action_just_pressed("slash"):
        slash()

    zoom(delta)

    movement(delta)

func _on_hurtbox_area_entered(area: Area2D) -> void:
    if area.is_in_group("enemies"):
        die()

func slash() -> void:
    is_slashing = true

    kill_enemies()
    await play_attack_animation()

    is_slashing = false

func flip() -> void:
    facing_left = !facing_left
    $AnimatedSprite2D.flip_h = facing_left
    $AttackArea.position = Vector2(-ATTACK_OFFSET, 0) if facing_left else Vector2.ZERO

func kill_enemies() -> void:
    for area in $AttackArea.get_overlapping_areas():
        if area.is_in_group("enemies"):
            area.die()
            flip()

func play_attack_animation() -> void:
    $AnimatedSprite2D.play("attack")
    await $AnimatedSprite2D.animation_finished
    $AnimatedSprite2D.play("walk")

func die() -> void:
    Globals.player_speed = 200
    Globals.score = 0
    score_label.text = str(Globals.score)

    position.x = 600
    position.y = 125

func movement(delta) -> void:
    var to_player := global_position - planet_center
    var normal := to_player.normalized()

    global_position = planet_center + normal * (planet_radius + player_height)
    rotation = normal.angle() + PI / 2
    var tangent := Vector2(normal.y, -normal.x) if facing_left else Vector2(-normal.y, normal.x)
    global_position += tangent * Globals.player_speed * delta

func zoom(delta) -> void:
    var t: float = clamp(get_closet_enemy_dist() / ZOOM_THRESHOLD, 0.0, 1.0)
    var desired_zoom := MIN_ZOOM.lerp(MAX_ZOOM, 1.0 - pow(t, 2))
    $Camera2D.zoom = $Camera2D.zoom.lerp(desired_zoom, delta * 5.0)

func get_closet_enemy_dist() -> float:
    var closest_enemy_dist := INF

    for enemy in get_tree().get_nodes_in_group("enemies"):
        var dist := global_position.distance_to(enemy.global_position)
        if dist < closest_enemy_dist:
            closest_enemy_dist = dist

    process_enemy_close(closest_enemy_dist)

    return closest_enemy_dist

func process_enemy_close(closest_enemy_dist: float) -> void:
    if closest_enemy_dist < 150:
        if had_passed_tutorial:
            emit_signal("enemy_close", true)
        else:
            emit_signal("enemy_close", false)
            had_passed_tutorial = true
    else:
        emit_signal("enemy_not_close")
