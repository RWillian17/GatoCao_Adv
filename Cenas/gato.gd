extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim_gato: AnimatedSprite2D = $SAnimGato #contem as animações para o que apertamos, andar, parado e ataque
@onready var animation_player: AnimationPlayer = $AnimationPlayer #esse coloca um efeito que pode usar qualquer coisa, como rotacionar, aumentar, diminuir ou o que for
@onready var colisao_ataque_gato: CollisionShape2D = $AreaGato/ColisaoAtaqueGato #esse é referente a colisão para surgir quando for apertado algo
																				#lembrem de deixar desativado no modo normal
@onready var timer_reset: Timer = $TimerReset #como ao trocar para outra animação ele não vai parar, coloquei um timer para voltar ao normal após um tempo



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("esqGat", "dirGat")
	if direction:
		velocity.x = direction * SPEED
		############################### até aqui em cima, nada diferente do normal ##################
		anim_gato.play("correr") #o AnimatedSprite2D possui três tipos de ações que eu coloquei, nesse caso mandei executar uma delas
		animation_player.play("Gato/anda_pulo") #usei essa animação apenas como demonstrativo que pode, esse fica linkado ao AnimationPlayer, não é necessário fazer
		timer_reset.start() #faz o timer começar a contar para após um tempo a ação feita poder voltar ao normal
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("ataqueGato"):  #ataque normal caso necessário, sem mudanças
		anim_gato.play("ataque") #mesma da animação do AnimatedSprite2D, ao fazer algo ele para o normal padrão e faz essa pra sempre
		timer_reset.start() #inicia o timer para poder resetar a animação do AnimatedSprite2D convencional
		
	move_and_slide()


func resetapeloTimer() -> void: #lembrar de linkar o timer a esse script, clica no CharacterBody2D Cao, Clica em Nó no canto direito para ver os sinais, 
								#em seguida clica no timer, dois cliques no timeout() para criar a função e coloca o nome dessa que fiz
								#no caso foi resetapeloTimer
	anim_gato.play("default") #observem que aqui mando o AnimatedSprite2D voltar a animação padrão
