boolean moveLeft = false;
boolean moveRight = false;
boolean moveUp = false;
boolean moveDown = false;

void keyPressed() {

	if (key == CODED)
	{
		if(keyCode == RIGHT)
			moveRight = true;
		if(keyCode == LEFT)
			moveLeft = true;
		if(keyCode == UP)
			moveUp = true;
		if(keyCode == DOWN)
			moveDown = true;
	}

	if (key == 'd')
		moveRight = true;
	if (key == 'a')
		moveLeft = true;
	if (key == 'w')
		moveUp = true;
	if (key == 's')
		moveDown = true;
}

void keyReleased() {
	if (key == CODED)
	{
		if(keyCode == RIGHT)
			moveRight = false;
		if(keyCode == LEFT)
			moveLeft = false;
		if(keyCode == UP)
			moveUp = false;
		if(keyCode == DOWN)
			moveDown = false;
	}

	if (key == 'd')
		moveRight = false;
	if (key == 'a')
		moveLeft = false;
	if (key == 'w')
		moveUp = false;
	if (key == 's')
		moveDown = false;

}

float getAxisRaw(String axis) {

	if (axis == "Horizontal") {
		if(moveLeft && moveRight)
			return 0;
		if(moveLeft)
			return -1;
		if(moveRight)
			return 1;
	}

	if (axis == "Vertical") {
		if(moveUp && moveDown)
			return 0;
		if(moveDown)
			return 1;
		if(moveUp)
			return -1;
	}
	
	return 0;
}