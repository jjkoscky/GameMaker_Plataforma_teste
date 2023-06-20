/// @description Insert description here
// You can write your code in this editor

//recarregar o dash
if (other.carga <= 0) other.carga++;
//instance_destroy();

//Gerando os pedaços
for(var i =0; i < irandom_range(20, 50); i++)
{
	var ped = instance_create_depth(x, y, depth - 1000, obj_part);
	ped.sprite_index = sprite_index;
}

sumir = true;

alarm[0] = room_speed * 3;