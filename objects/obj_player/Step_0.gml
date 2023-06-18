/// @description Insert description here
// You can write your code in this editor

//checando se estou tocando o chao
chao = place_meeting(x, y + 1, obj_plat);
parede_dir = place_meeting(x + 1, y, obj_plat);
parede_esq = place_meeting(x - 1, y, obj_plat);
//-- configurando time do pulo
if(chao)
{
	//estou no chao
	timer_pulo = limite_pulo;
	carga = 1;
}
else
{
	if(timer_pulo > 0 )
	{
		timer_pulo--;
		//carga--;
	}
}

if (parede_dir or parede_esq)
{	
	if (parede_dir) ultima_parede = 0;
	else ultima_parede = 1;
	timer_parede = limite_parede;
}
else
{
	if (timer_parede > 0)
	{
		timer_parede--;
	}
}

//--controles

var left, right, jump, jump_s, avanco_h, jump_2, jump_2s, dash, up, down;
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
jump = keyboard_check_pressed(ord("K"));
jump_s = keyboard_check_released(ord("K"));
jump_2 = keyboard_check_pressed(vk_space);
jump_2s = keyboard_check_released(vk_space);
dash = keyboard_check_pressed(ord("L"));


//-- configurando informaçao da movimentacao
avanco_h = (right - left) * max_veloc_h;
//valor da aceleracao
if (chao) acelera = acelera_chao;
else acelera = acelera_ar;

//----STATE MACHINE------
switch(estado)
{
	case state.parado:
		veloc_h = 0;
		veloc_v = 0;
	//posso mudar a velocidade
	//pulando
	if((jump || jump_2) && chao)
	{
		veloc_v = -max_veloc_v;
	}
	//Aplicando gravidade tambem
	if (!chao)
	{
		veloc_v += gravidade;
	}
	//saindo do estado
	//movendo
	if(abs(veloc_h) > 0 || abs(veloc_v) > 0 || left || right || jump)
	{
		estado = state.movendo;
	}
	//Dash
	if (dash && carga > 0)
	{
		//decidindo a direcao
		/*if (up && right) dir  = 45;
		else if (up && left) dir = 135;
		else if (down && right) dir = 315;
		else if (down && left) dir = 225;
		else if (right) dir = 0;
		else if (up) dir = 90;
		else if (left) dir = 180;
		else if (down) dir = 270;*/
		
		dir = point_direction(0, 0, (right - left), (down - up));
		
		estado = state.dash;
		carga--;
	}
		break;
	
	case state.movendo:
	//aplicando a movimentacao
	veloc_h = lerp(veloc_h, avanco_h, acelera);
	
	//Gravidade && parede
	if(!chao && (parede_dir or parede_esq or timer_pulo))
	{
		//não estou no chao mas estou na parede
		if(veloc_v > 0)//estouna parede e estou caindo
		{
			veloc_v = lerp(veloc_v, deslisar, acelera);
		}
		else
		{
			//estou subindo
			veloc_v += gravidade;
		}
		
		//pulando nas paredes
		if (!ultima_parede && jump )//estou na parede e tentei pular
		{
			veloc_v = -max_veloc_v;
			veloc_h = -max_veloc_h;
			xscale = .5;
			yscale = 1.5;
		}
		else if (ultima_parede && jump)
		{
			veloc_v = -max_veloc_v;
			veloc_h = max_veloc_h;
			xscale = .5;
			yscale = 1.5;
		}
	}
	else if (!chao)
		{
			veloc_v += gravidade;
		}
	
	//pulando
	if((chao || timer_pulo) && (jump || jump_2))
	{
		veloc_v = -max_veloc_v;
		//alterando a escala
		xscale = .5;
		yscale = 1.5;
		
		//buffer pulo
		if(jump || jump_2) timer_queda = limite_buffer;
		if(timer_queda > 0 ) buffer_pulo = true;
		else buffer_pulo = false;
		
		if(buffer_pulo)//eu posso pular
		{
			if(chao || timer_pulo)//as demais condições do pulo tambem sao verdadeiras
			{
				veloc_v = -max_veloc_v;
				//alterando a escala
				xscale = .5;
				yscale = 1.5;
				
				timer_pulo = 0;
				timer_queda = 0;
			}
			
			timer_queda--;
		}
	
	}
	//controlando altura do pulo
	if ((jump_s || jump_2s) && veloc_v < 0) veloc_v *= .7;
	
	
	
	//Dash
	if (dash && carga > 0)
	{
		//decidindo a direcao
		/*if (up && right) dir  = 45;
		else if (up && left) dir = 135;
		else if (down && right) dir = 315;
		else if (down && left) dir = 225;
		else if (right) dir = 0;
		else if (up) dir = 90;
		else if (left) dir = 180;
		else if (down) dir = 270;*/
		
		dir = point_direction(0, 0, (right - left), (down - up));
		
		estado = state.dash;
		carga--;
	}
	
	//limitando velocidade
	veloc_v = clamp(veloc_v, -max_veloc_v, max_veloc_v);
	
	break;
	
	case state.dash:
	duracao--;
	
	veloc_h = lengthdir_x(len, dir);
	veloc_v = lengthdir_y(len, dir);
	
	//deformando o player
	if (dir == 90 || dir == 270)
	{
		yscale = 1.5;
		xscale = .5
	}
	else
	{
		yscale = .5;
		xscale = 1.6;
	}
	
	//image_blend = c_red;
	
	// criando rastro
	var rastro = instance_create_layer(x, y, layer, obj_rastro_player);
	rastro.xscale = xscale;
	rastro.yscale = yscale;
	
	//saindo do estado
	if(duracao <= 0)
	{
		estado = state.movendo;
		duracao = room_speed/4;
		//image_blend = c_white;
		
		//diminuindo a velocidade
		veloc_h = (max_veloc_h * sign(veloc_h) * .5);
		veloc_v = (max_veloc_v * sign(veloc_v) * .5);
	}
	break;
}

show_debug_message(estado);

switch(carga)
{
	case 0:
	saturacao = lerp(saturacao, 50, .05);
	break;
	
	case 1:
	saturacao = lerp(saturacao, 255, .05);
	break;
}

//definindo a cor 
image_blend = make_color_hsv(20, saturacao, 255);

//voltando a escala original
xscale = lerp(xscale, 1, .15);
yscale = lerp(yscale, 1, .15);
