/// @description Insert description here
// You can write your code in this editor

//checando se eu acabei de bater no chao

var temp = place_meeting(x, y + 1, obj_plat);


if (temp && !chao)//acabei de tocar no chao
{
	xscale = 1.6;
	yscale = .5;
}

//reset do jogo
if (keyboard_check_pressed(vk_enter)) room_restart();