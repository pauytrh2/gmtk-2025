extends Node

@onready var score_label: Label = %Score

var enemy_scene := preload("res://scene/enemy.tscn")

func _ready() -> void:
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
    add_child(enemy_instance)
