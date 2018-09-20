class PlayerShip {
    public int score;
    public int leftKey, rightKey, thrustKey;
    public FloatVector velocity, position;
    public float direction, thrust;
    public boolean leftKeyPressed=false, rightKeyPressed=false, thrustKeyPressed=false;
    public color shipColor;

    PlayerShip (int leftKey, int thrustKey, int rightKey, float x, float y, color shipColor) {
        this.leftKey = leftKey;
        this.rightKey = rightKey;
        this.thrustKey = thrustKey;
        this.velocity = new FloatVector(0, 0);
        this.position = new FloatVector(0, 0);
        this.score = 0;
        this.direction = 0.0;
        this.thrust = 0.1;
        this.shipColor = shipColor;
    }

    public boolean IsleftKeyPressed() {
        return this.leftKeyPressed;
    }

    public boolean IsrightKeyPressed() {
        return this.rightKeyPressed;
    }

    public boolean IsthrustKeyPressed() {
        return this.thrustKeyPressed;
    }

    public void pressKey() {
        if(keyCode == this.leftKey)
            this.leftKeyPressed = true;

        if(keyCode == this.rightKey)
            this.rightKeyPressed = true;

        if(keyCode == this.thrustKey)
        	this.thrustKeyPressed = true;
    }

    public void releaseKey() {
		if(keyCode == this.leftKey)
            this.leftKeyPressed = false;

        if(keyCode == this.rightKey)
            this.rightKeyPressed = false;

        if(keyCode == this.thrustKey)
        	this.thrustKeyPressed = false;
    }

    public void update() {
		this.position = new FloatVector(this.position.x % width, this.position.y % height);
		while(this.position.x < 0 || this.position.x > width)
			if(this.position.x < 0)
				this.position.x += width;
			if(this.position.x > width)
				this.position.x -= width;
		while(this.position.y < 0 || this.position.y > width)
			if(this.position.y < 0)
				this.position.y += width;
			if(this.position.y > width)
				this.position.y -= width;

		if(this.IsleftKeyPressed() ^ this.IsrightKeyPressed())
	    {
			if(this.IsleftKeyPressed())
			{
				this.direction -= 3;
			}
			if(this.IsrightKeyPressed())
			{
				this.direction += 3;
			}
	    }

	    if(this.thrustKeyPressed)
    	{
    		this.velocity.addTo(new FloatVector(this.direction, this.thrust, true));
    	}

    	this.position.addTo(this.velocity);
    }

	public void draw() {
		draw_spaceship(this.position, this.direction, 0.5, this.shipColor);
	}
}

void draw_spaceship(FloatVector position, float rotation, float multiplier, color shipColor)
{	
	float x = position.x;
	float y = position.y;
	rotation += 90;
	rotation *=  -1.0;

	stroke(shipColor);
	strokeWeight(4.1 * multiplier);
	float f1 = 39.8;
	float r1 = 0.869;
	float f2 = -38.2;
	float r2 = 0.000;
	line(
		x + multiplier * f1 * sin(radians(rotation) + r1), 
		y + multiplier * f1 * cos(radians(rotation) + r1), 
		x + multiplier * f2 * sin(radians(rotation) + r2), 
		y + multiplier * f2 * cos(radians(rotation) + r2)
	);
	f1 = 39.8;
	r1 = -0.869;
	f2 = -38.2;
	r2 = 0.000;
	line(
		x + multiplier * f1 * sin(radians(rotation) + r1), 
		y + multiplier * f1 * cos(radians(rotation) + r1), 
		x + multiplier * f2 * sin(radians(rotation) + r2), 
		y + multiplier * f2 * cos(radians(rotation) + r2)
	);
	f1 = 38.2;
	r1 = 0.869;
	f2 = 38.2;
	r2 = -0.869;
	line(
		x + multiplier * f1 * sin(radians(rotation) + r1), 
		y + multiplier * f1 * cos(radians(rotation) + r1), 
		x + multiplier * f2 * sin(radians(rotation) + r2), 
		y + multiplier * f2 * cos(radians(rotation) + r2)
	);

	strokeWeight(6.9 * multiplier);
	f1 = 44.5;
	r1 = 0.369;
	f2 = 29.9;
	r2 = 0.571;
	line(
		x + multiplier * f1 * sin(radians(rotation) + r1), 
		y + multiplier * f1 * cos(radians(rotation) + r1), 
		x + multiplier * f2 * sin(radians(rotation) + r2), 
		y + multiplier * f2 * cos(radians(rotation) + r2)
	);
	f1 = 44.5;
	r1 = -0.369;
	f2 = 29.9;
	r2 = -0.571;
	line(
		x + multiplier * f1 * sin(radians(rotation) + r1), 
		y + multiplier * f1 * cos(radians(rotation) + r1), 
		x + multiplier * f2 * sin(radians(rotation) + r2), 
		y + multiplier * f2 * cos(radians(rotation) + r2)
	);
}