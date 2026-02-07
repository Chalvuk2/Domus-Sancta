extends Control

#used to call Animation player, the node used to fade the screen in and out
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
var enabled = false
#_ready playes whenever the game starts, making the menu disappear
func _ready():
	animation_player.play("RESET")

#resume is used to unpause the game back to its normal state
func resume():
	if enabled:
		get_tree().paused = false;
		animation_player.play_backwards("blur")
		enabled = false
	
#pause is used to freeze the game then pull up menu
func pause():
	if !enabled:
		get_tree().paused = true;
		animation_player.play("blur")
		enabled = true 

#checks if esc is pressed, then calling the corrosponding function
func testEsc():
	if Input.is_action_just_pressed("esc") && !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") && get_tree().paused:
		resume()

#calls the resume function by pressing the resume button
func _on_resume_pressed() -> void:
	resume()


func _on_help_pressed() -> void:
	#Will be used to pull up movement screen
	pass # Replace with function body.

#quits the game whenever you want to quit the game
func _on_quit_pressed() -> void:
	if enabled:
		get_tree().quit();

#called whenever a key is pressed
func _process(_delta: float) -> void:
	testEsc()
