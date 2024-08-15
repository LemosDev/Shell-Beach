extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Cenas/Mapa.tscn")


func _on_sair_pressed():
	get_tree().quit()
