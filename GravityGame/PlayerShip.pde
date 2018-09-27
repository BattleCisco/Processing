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
		this.position = new FloatVector(this.position.x, this.position.y);
		// while(this.position.x < 0 || this.position.x > width)
		// 	if(this.position.x < 0)
		// 		this.position.x += width;
		// 	if(this.position.x > width)
		// 		this.position.x -= width;
		// while(this.position.y < 0 || this.position.y > width)
		// 	if(this.position.y < 0)
		// 		this.position.y += width;
		// 	if(this.position.y > width)
		// 		this.position.y -= width;

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

    	this.position.addTo(this.velocity.multiply(0.95));
    }

    public float velocityDirection() {
		return degrees(asin(this.velocity.x / this.velocity.mag())) + 180;
	}

	public void draw() {
		draw_spaceship(new FloatVector(0, 0), this.direction, this.shipColor);
	}
}

void draw_spaceship(FloatVector position, float rotation, color shipColor)
{	
	//translate(position.x, position.y);
	rotate(radians(rotation));
	
	float x = position.x;
	float y = position.y;
	//rotation += 90;
	//rotation *=  -1.0;

	stroke(shipColor);
	strokeWeight(4.1);
	line(-25.694504, 30.394611, 38.2, 1.6697751E-6);
	line(-25.694, -30.395, 38.2, 0);
	line(-24.662, 29.173, -24.662, -29.173);

	strokeWeight(6.9);
	line(-41.505, 16.05, -25.157, 16.16);
	line(-41.505, -16.05, -25.157, -16.16);
	
	rotate(-radians(rotation));
	//translate(-position.x, -position.y);
}