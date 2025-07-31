extends Node

@onready var score_label: Label = %Score

var enemy_scene := preload("res://scene/enemy.tscn")

func _ready() -> void:
    spawn_enemy()

func _on_enemy_killed() -> void:
    Globals.increase_score(1)
    score_label.text = str(Globals.score)
    
    spawn_enemy()

func _on_area_entered(area: Area2D) -> void:
    print(area.name)

func spawn_enemy() -> void:
    var enemy_instance = enemy_scene.instantiate()
    enemy_instance.add_to_group("enemies")
    enemy_instance.killed.connect(_on_enemy_killed)
    enemy_instance.area_entered.connect(_on_area_entered)
    add_child(enemy_instance)
