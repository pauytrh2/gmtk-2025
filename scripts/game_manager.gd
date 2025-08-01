extends Node

@onready var score_label: Label = %Score
@onready var player: CharacterBody2D = %Player

var enemy_scene := preload("res://scenes/enemy.tscn")

func _ready() -> void:
    await get_tree().create_timer(3).timeout
    spawn_enemy()

func _on_enemy_killed() -> void:
    Globals.increase_score(1)
    Globals.increase_player_speed(5)

    score_label.text = str(Globals.score)

    spawn_enemy()

func spawn_enemy() -> void:
    var enemy_instance = enemy_scene.instantiate()
    enemy_instance.add_to_group("enemies")
    enemy_instance.killed.connect(_on_enemy_killed)
    enemy_instance.player = player
    add_child(enemy_instance)
