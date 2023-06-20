/// @description Insert description here
// You can write your code in this editor
image_angle += rotacao;

switch(estado)
{
	case "avanca" :
	//descobrindo a direcao limite
	var limite_x = lengthdir_x(limite, direc);
	var limite_y = lengthdir_y(limite, direc);
	
	//movendo
	x += lengthdir_x(veloc,direc);
	y += lengthdir_y(veloc,direc);
	
	//trocando de estado X
	if(limite_x > 0)
	{
		//ir para a direita
		if (x >= xstart + limite_x) estado = "recua";
	}else if(limite_x < 0)
	{
		//ir para a esquerda
		if (x <= xstart + limite_x) estado = "recua";
	}
	//trocando de estado Y
	if(limite_y > 0)
	{
		//ir para a direita
		if (y >= xstart + limite_y) estado = "recua";
	}else if(limite_y < 0)
	{
		//ir para a esquerda
		if (y <= ystart + limite_y) estado = "recua";
	}	
		break;
	case "recua" :
		//movendo
		x -= lengthdir_x(veloc,direc);
		y -= lengthdir_y(veloc,direc);
		
		//mudando estado
		if (x == xstart && y == ystart) estado = "avanca";
		
		break;
	case "parado" :
		break;
		
	default:
		show_message("vc digitou o nome do estado errado!");
		break;
}
show_debug_message(estado);
