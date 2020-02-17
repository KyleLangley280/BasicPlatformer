image_angle =  point_direction(x,y,hero.x,hero.y);

if bulletLatency <= 0{
	instance_create_layer(x,y,"BulletLayer",enemyBullet);
	bulletLatency = 25;
}
bulletLatency = bulletLatency - 1;

if enemyHealth <= 0{
	instance_destroy();	
}
