
// keep me out of things horizontally
if place_meeting(x+hspeed, y, wall){
    if hspeed < 0 {  // i'm about to hit on the left
        move_contact_solid(180, hspeed)
    }
    else { // i'm about to hit on the right
        move_contact_solid(0, hspeed)
    }
    hspeed = 0
}

// keep me out of things vertically
if place_meeting(x, y+vspeed, wall) {
    if vspeed < 0 {  // i'm about to hit on the top
        move_contact_solid(90, vspeed)
    }
    else {  // i'm about to hit on the bottom
        move_contact_solid(270, vspeed)
        gravity = 0
    }
    vspeed = 0
}

// if i'm off the ground, give me gravity
else if !place_meeting(x, y+normalGravity, wall) {
	if keyboard_check_direct(ord("A")) and place_meeting (x-normalSpeed,y,wall) {		
		gravity = 0
		vspeed = 0
		onWall = 1
		
	}
	else if keyboard_check_direct(ord("D")) and place_meeting (x+normalSpeed,y,wall){
		gravity = 0
		vspeed = 0
		onWall = 1
		
	}
	else{
	
    gravity = normalGravity
	onWall = 0
	}
}
 
// moving right
if keyboard_check_direct(ord("D")) and jumpLatency <= 0{
    // is there space for me to move right?
    if !place_meeting(x+normalSpeed, y, wall){
        hspeed = normalSpeed	
    }
}
// moving left
if keyboard_check_direct(ord("A")) and jumpLatency <= 0{
    // is there space for me to move left?
    if !place_meeting(x-normalSpeed, y, wall){
        hspeed = -normalSpeed

    }
}

// jumping
// am i on the ground, and is there space above my head to jump?
if keyboard_check_pressed(vk_space) and place_meeting(x, y+normalGravity, wall)
and !place_meeting(x, y-jumpSpeed, wall) {
    vspeed = -jumpSpeed
}

else if keyboard_check_pressed(vk_space) and place_meeting(x+normalSpeed,y,wall) and onWall = 1{
	vspeed = -jumpSpeed
	hspeed = -normalSpeed*2
	jumpLatency = 5
}
else if keyboard_check_pressed(vk_space) and place_meeting(x-normalSpeed,y,wall) and onWall = 1{
	vspeed = -jumpSpeed
	hspeed = normalSpeed*2
	jumpLatency = 5

}

// friction to slow me down horizontally
hspeed *= .9;
jumpLatency = jumpLatency - 1;
bulletLatency = bulletLatency -1;

if mouse_check_button(mb_left) and bulletLatency <= 0{
	instance_create_layer(x,y,"BulletLayer",playerBullet);
	bulletLatency = 3;
}

if heroHealth <= 0{
	room_restart()	
}

//targetAmount = instance_count(target);
targetAmount = instance_number(target)
if (targetAmount = 1){
	room_goto_next()	
}