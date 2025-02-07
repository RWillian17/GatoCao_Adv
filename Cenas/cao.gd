extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim_cao: AnimatedSprite2D = $SAnimCao #contem as animações para o que apertamos, andar, parado e ataque
@onready var animation_player: AnimationPlayer = $AnimationPlayer #esse coloca um efeito que pode usar qualquer coisa, como rotacionar, aumentar, diminuir ou o que for
@onready var colisao_ataque_cao: CollisionShape2D = $AreaCao/ColisaoAtaqueCao #esse é referente a colisão para surgir quando for apertado algo
																				#lembrem de deixar desativado no modo normal
@onready var timer_reset: Timer = $TimerReset #como ao trocar para outra animação ele não vai parar, coloquei um timer para voltar ao normal após um tempo
@onready var timer_ataque: Timer = $TimerAtaque

var vida: int = 100
signal caoAcertou


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("esqCao", "dirCao")
	if direction:
		velocity.x = direction * SPEED 
		############################### até aqui em cima, nada diferente do normal ##################
		anim_cao.play("correr") #o AnimatedSprite2D possui três tipos de ações que eu coloquei, nesse caso mandei executar uma delas
		animation_player.play("Cao/anda_pulo") #usei essa animação apenas como demonstrativo que pode, esse fica linkado ao AnimationPlayer, não é necessário fazer
		timer_reset.start() #faz o timer começar a contar para após um tempo a ação feita poder voltar ao normal
		
	else:  # sem mudanças
		velocity.x = move_toward(velocity.x, 0, SPEED)  #sem mudanças
		
	if Input.is_action_just_pressed("ataqueCao"): #ataque normal caso necessário, sem mudanças
		anim_cao.play("ataque") #mesma da animação do AnimatedSprite2D, ao fazer algo ele para o normal padrão e faz essa pra sempre
		timer_reset.start() #inicia o timer para poder resetar a animação do AnimatedSprite2D convencional
		
		####### ------- ADICIONEI AQUI EMBAIXO PARA FAZER OS ATAQUES ------------- #########
		
		colisao_ataque_cao.disabled = false #faz surgir a area de colisão para avaliar se ocorreu
		timer_ataque.start() #ligo o timer para tirar essa colisão apos o ataque ocorrer
	

	move_and_slide() #sem diferenças


func resetapeloTimer() -> void: #lembrar de linkar o timer a esse script, clica no CharacterBody2D Cao, Clica em Nó no canto direito para ver os sinais, 
								#em seguida clica no timer, dois cliques no timeout() para criar a função e coloca o nome dessa que fiz
								#no caso foi resetapeloTimer
	anim_cao.play("default") #observem que aqui mando o AnimatedSprite2D voltar a animação padrão


func caboAtaque() -> void:
	colisao_ataque_cao.disabled = true #corresponde ao fim do timer para fazer mais nada
	
	
func retornaVida() -> int: #serve para ver na função principal o valor da vida desse elemento
	return vida

func levouDano(valor: int) -> void: #aqui uma função para a PRINCIPAL chamar avisando que esse cara tomou um dano
	vida -= valor #vida dele é diminuida
	velocity.x = SPEED*3 #faz um movimento para tras para simular que levou um hit
	move_and_slide() #como foi dada uma nova velocidade, precisamos fazer a chamada de move_and_slide para ele fazer 
					#a movimentação
					
