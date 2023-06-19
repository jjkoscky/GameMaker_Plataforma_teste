/// @description Insert description here
// You can write your code in this editor
//draw_self();

if (veloc_h != 0)
{
	ver = sign(veloc_h);
}								//sprite_height/2 quanto maior o numero menos ele amassa quando cai
draw_sprite_ext(sprite_index, image_index, x, y+ (sprite_height/3 - sprite_height/3 *yscale), xscale * ver, yscale, image_angle, image_blend, image_alpha);