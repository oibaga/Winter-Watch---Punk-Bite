extends StaticBody3D 
# Texto que será mostrado quando o jogador apontar para a cadeira
const HINT_TEXT = "Pressione [LMB] para Sentar"

func mostrar_hint():
	print("HINT: ", HINT_TEXT)
	pass 
	
func esconder_hint():
	print("HINT: Limpo")
	pass
