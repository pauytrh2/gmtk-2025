extends Node

var score := 0
var player_speed := 200

func increase_score(number: int) -> void:
    score += number

func increase_player_speed(number: int) -> void:
    player_speed += number
