extends Node3D

# O Marker3D dentro da Cadeira que indica a posição/rotação de sentar.
@onready var sit_marker: Marker3D = $Marker3D
# Variável para rastrear se a cadeira está ocupada (opcional, mas recomendado).
var is_occupied: bool = false
# Variável para rastrear quem está sentado.
var sitter: CharacterBody3D = null

# Função chamada quando o jogador interage com a cadeira
func interagir():
	if is_occupied:
		# Se já houver alguém sentado, pede para a pessoa se levantar.
		if sitter and is_instance_valid(sitter) and sitter.has_method("levantar"):
			sitter.levantar()
	else:
		# Se a cadeira estiver livre, sinaliza para o objeto que interagiu que ele pode se sentar.
		# O objeto que interage é o que chama obj.interagir(), que no seu caso é o próprio player.
		var player = get_tree().get_first_node_in_group("player") # Assumindo que o player está no grupo "player"
		if player and player.has_method("sentar"):
			player.sentar(self)
			
# Funções para o feedback visual de interação (assumindo que Label3D é o hint)
func mostrar_hint():
	if $Label3D:
		$Label3D.visible = true

func esconder_hint():
	if $Label3D:
		$Label3D.visible = false

# Função que o Player chama quando se senta com sucesso
func ocupar(player: CharacterBody3D):
	is_occupied = true
	sitter = player

# Função que o Player chama quando se levanta
func liberar():
	is_occupied = false
	sitter = null

# Propriedades de sentar para o Player usar
func get_sit_transform() -> Transform3D:
	# Retorna a transformação global do Marker3D (posição e rotação).
	return sit_marker.global_transform
