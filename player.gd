extends Node3D

@export var speed_walk:float = 5
@export var speed_run:float = 10
@onready var animation_tree: AnimationTree = $CharacterBody3D/AnimationTree
@onready var character_body3D: CharacterBody3D = $CharacterBody3D
var velocity:Vector2
var shift_pressed:bool
var left_rotation:Vector3= Vector3.ZERO
var right_rotation:Vector3 =Vector3(0,180,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active=true; # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction:Vector2=Input.get_vector("Left","Right","Back","Forward").normalized()
	shift_pressed=Input.is_action_just_pressed("Run_Modify",true)
	if(direction):
		if(shift_pressed):
			velocity=direction*speed_run*delta
		else:
			velocity=direction*speed_walk*delta
	else:
		velocity=Vector2.ZERO
	if(direction==Vector2.LEFT):
		character_body3D.rotation_degrees=Vector3(0,0,0)
	if(direction==Vector2.RIGHT):
		character_body3D.rotation_degrees=Vector3(0,180,0)
	update_animation()

func update_animation():
	if(velocity==Vector2.ZERO):
		animation_tree["parameters/conditions/idle"]=true
		animation_tree["parameters/conditions/walk"]=false
		animation_tree["parameters/conditions/run"]=false
	else:
		animation_tree["parameters/conditions/idle"]=false
		if(!shift_pressed):
			animation_tree["parameters/conditions/walk"]=true
			animation_tree["parameters/conditions/run"]=false
		else:
			animation_tree["parameters/conditions/walk"]=false
			animation_tree["parameters/conditions/run"]=true
