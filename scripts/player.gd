extends CharacterBody2D

signal killed

@export var planet_center: Vector2
@export var planet_radius := 120
@export var player_height := 70
@export var move_speed := 200

var facing_left := false
var is_slashing := false

const ATTACK_OFFSET := 14

func _start() -> void:
    show()

func _physics_process(delta) -> void:
    if is_slashing:
        return

    if Input.is_action_just_pressed("slash"):
        slash()

    var to_player = global_position - planet_center
    var normal = to_player.normalized()

    global_position = planet_center + normal * (planet_radius + player_height)

    rotation = normal.angle() + PI / 2

    var tangent = Vector2(normal.y, -normal.x) if facing_left else Vector2(-normal.y, normal.x)

    global_position += tangent * move_speed * delta

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
    hide()
    emit_signal("killed")
