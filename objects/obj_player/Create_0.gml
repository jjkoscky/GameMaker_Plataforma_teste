/// @description Insert description here
// You can write your code in this editor

gravidade = .3;
acelera_chao = .1;
acelera_ar = .07;
acelera = acelera_chao;
deslisar = 2;


//----velocidades
veloc_h = 0;
veloc_v = 0;
//-----limite das velocidades
max_veloc_h = 6;
max_veloc_v = 8;
len = 10;

//--Bonus do pulo
limite_pulo = 6;
timer_pulo = 0;

limite_buffer = 6;
timer_queda = 0;
buffer_pulo = false;

limite_parede = 6;
timer_parede = 0;

//--variaveis de controle

chao = false;
parede_dir = false;
parede_esq = false;
xscale = 1;
yscale = 1;
duracao = room_speed/4;
dir = 0;
carga = 1;
ultima_parede = 0;
ver = 1;

//controlando a cor
saturacao = 225;


enum state 
{
	parado, movendo, dash
}

estado = state.parado;