extends Node

var enemy_scene := preload("res://scene/enemy.tscn")

func _ready() -> void:
    spawn_enemy()

func _on_enemy_killed() -> void:
    spawn_enemy()

func spawn_enemy() -> void:
    var enemy_instance = enemy_scene.instantiate()
    enemy_instance.add_to_group("enemies")
    enemy_instance.killed.connect(_on_enemy_killed)
    add_child(enemy_instance)
