/// @description Insert description here
// You can write your code in this editor

//checando se eu acabei de bater no chao

var temp = place_meeting(x, y + 1, obj_plat);


if (temp && !chao)//acabei de tocar no chao
{
	xscale = 1.6;
	yscale = .5;
	
	//criando a poeira
	for (var i =0; i < irandom_range(4, 10); i++ )
	{
		var xx = random_range(x - sprite_width, x + sprite_width);
		instance_create_depth(xx, y, depth - 1000, obj_vel);
	}
}

//reset do jogo
if (keyboard_check_pressed(vk_enter)) room_restart();               