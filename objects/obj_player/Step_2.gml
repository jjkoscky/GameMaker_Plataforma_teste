/// @description Insert description here
// You can write your code in this editor

//--colisao horizontal
if(place_meeting(x + veloc_h, y, obj_plat))
{
	while(!place_meeting(x + sign(veloc_h), y, obj_plat))
	{
			x += sign(veloc_h);
	}
	veloc_h = 0;
}

//-- colisao vertical

if(place_meeting(x, y + veloc_v, obj_plat))
{
	while(!place_meeting(x, y + sign(veloc_v), obj_plat))
	{
			y += sign(veloc_v);
	}
	veloc_v = 0;
}


x += veloc_h;
y += veloc_v;