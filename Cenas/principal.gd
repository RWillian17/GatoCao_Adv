extends Node2D

@onready var gato: CharacterBody2D = $Gato
@onready var cao: CharacterBody2D = $Cao
@onready var Barravida_cao: Label = $VidaCao
@onready var Barravida_gato: Label = $VidaGato

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func gatoAcertou() -> void:
	Barravida_cao.text = "Cao: %d" %cao.retornaVida()
	cao.levouDano(1)
	Barravida_gato.text = "Gato: %d" %gato.retornaVida()
