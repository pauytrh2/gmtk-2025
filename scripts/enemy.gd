extends Area2D

signal killed

@export var planet_center: Vector2
@export var planet_radius := 120
@export var enemy_height := 70

var facing_left := false

func _ready() -> void:
    # Pick a random angle around the planet
    var angle = randf() * TAU
    var normal = Vector2(cos(angle), sin(angle))

    global_position = planet_center + normal * (planet_radius + enemy_height)

    rotation = normal.angle() + PI / 2
    
func die() -> void:
    emit_signal("killed")
    queue_free()
