extends Node3D

class_name WeaponParent

#Amount of ammunition a weapon can hold in a magazine
var Capacity: int = 20

#0 for meelee, 1 for pistols, 2 for rifles, 3 for special
#2 includes shotguns and smgs
var WeaponType: int = 2

var FireRate: int = 5

var CanFire: bool = true

func _ready():
	$flash.visible = false

func _input(event):
	if event.is_action_pressed("left_click") and CanFire:
		print("fire")
		$flash.visible = true
		CanFire = false
		$Timer.start()



func _on_timer_timeout():
	$flash.visible = false
	CanFire = true
	
