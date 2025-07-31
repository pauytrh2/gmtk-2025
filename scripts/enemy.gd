extends Area2D

@export var planet_center: Vector2
@export var planet_radius := 120
@export var enemy_height := 70

var facing_left := false

func _ready():
    # Pick a random angle around the planet
    var angle = randf() * TAU
    var normal = Vector2(cos(angle), sin(angle))

    # Position the enemy on the surface of the planet
    global_position = planet_center + normal * (planet_radius + enemy_height)

    # Rotate the enemy to match the planet surface
    rotation = normal.angle() + PI / 2

    # Determine whether the enemy is facing left (based on tangent direction)
    var tangent = Vector2(-normal.y, normal.x)
    facing_left = tangent.x < 0
    $AnimatedSprite2D.flip_h = facing_left
