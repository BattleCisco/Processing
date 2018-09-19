Player player1 = new Player(87, 83, 0, 0, 10, 90);
Player player2 = new Player(38, 40, 0, 0, 10, 90);
Ball ball = new Ball(0, 0, 25, 25, 0, 0);

Player[] players = {player1, player2};
int frame = 0;

float player_speed = 6;
PFont font;

void setup()
{
	size(640, 480);
	player2.rectangleObject.coordinates.x = width - player2.rectangleObject._size.x;
	ball.rectangleObject.coordinates.x = width / 2 -  12.5; //width / 2;
	ball.rectangleObject.coordinates.y = height / 2 - 12.5;
	strokeWeight(1.5);
	//frameRate(8);
	font = createFont("bit5x3.ttf", 120);
}

void draw_spaceship(float x, float y, float rotation)
{
	strokeWeight(1.0);
	line(
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation)), 
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation))
	);
	line(
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation)), 
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation))
	);
	line(
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation)), 
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation))
	);

	strokeWeight(1.0);
	line(
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation)), 
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation))
	);
	line(
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation)), 
		(x + 0) * sin(radians(rotation)), 
		(y + 0) * cos(radians(rotation))
	);
}

void draw()
{
	int def=100;
	line(def, 0, def, def);
	line(0, def, def, def);
	draw_spaceship(def/2, def/2, 0.0);
}

void keyPressed(){
	if (keyCode == 74)
	{
		ball.serve();
		println("Serving ball.");
	}

	if(keyCode == 72)
	{
		ball.reset();
		println("Resetting ball.");
	}
  	//println(key + " is pressed.", keyCode);
	player1.pressKey();
	player2.pressKey();
}

void keyReleased(){
	  //println(key + " is released.");
	  player1.releaseKey();
	  player2.releaseKey();
}

class FloatVector {
    public float x, y;

    public FloatVector (float x, float y) {
		this.x = x;
		this.y = y;
    }

	public FloatVector (float angle, float magnitude, boolean use_angle_input) {
		this.x = cos(angle) * magnitude;
		this.y = sin(angle) * magnitude;
    }

	// public FloatVector copy() {
	// 	return new FloatVector(this.x.clone(), this.y.clone());
	// }

	public float mag()
	{
		return this.magnitude();
	}

	public float magnitude() {
		return sqrt(this.x * this.x + this.y * this.y);
	}

	public float magnitudeNoSqrt() {
		return this.x * this.x + this.y * this.y;
	}


	public FloatVector add(FloatVector v1) {
		return new FloatVector(this.x + v1.x, this.y + v1.y);
	}

	public void addTo(FloatVector v1) {
		this.x += v1.x;
		this.y += v1.y;
	}

	public FloatVector subtract(FloatVector v1) {
		return new FloatVector(this.x - v1.x, this.y - v1.y);
	}

	public void subtractTo(FloatVector v1) {
		this.x -= v1.x;
		this.y -= v1.y;
	}

	public FloatVector multiply(int value) {
		return new FloatVector(this.x * value, this.y * value);
	}

	public void multiplyTo(int value) {
		this.x *= value;
		this.y *= value;
	}

	public FloatVector divide(int value) {
		return this.multiply(1 / value);
	}

	public void divideTo(int value) {
		this.multiplyTo(1 / value);
	}

}

class Coordinates extends FloatVector{
	public Coordinates(float x, float y) {
		super(x, y);
	}

	public Coordinates(FloatVector fv) {
		super(fv.x, fv.y);
	}

	public boolean isXOutOfBound() {
		return this.x > width || this.x < 0;
	}

	public boolean isYOutOfBound() {
		return this.y > height || this.y < 0;
	}

	public boolean isGreaterThan(Coordinates other) {
		return this.x > other.x && this.y > other.y;
	}

	public boolean isLessThan(Coordinates other) {
		return this.x < other.x && this.y < other.y;
	}
}

class RectangleObject {
    public FloatVector _size, velocity;
    public Coordinates coordinates;

    RectangleObject (Coordinates coordinates, FloatVector _size, FloatVector velocity) {
        this.coordinates = coordinates;
        this._size = _size;
        this.velocity = velocity;
    }

    RectangleObject (RectangleObject other) {
        this.coordinates = other.coordinates;
        this._size = other._size;
        this.velocity = other.velocity;
    }

    public Coordinates[] coordinates() {
	    Coordinates[] coords = {
	        new Coordinates(this.coordinates.x,  this.coordinates.y),
	        new Coordinates(this.coordinates.x,  this.coordinates.y + this._size.y),
			new Coordinates(this.coordinates.x + this._size.x,  this.coordinates.y),
			new Coordinates(this.coordinates.x + this._size.x,  this.coordinates.y + this._size.y),
		};
		return coords;
    }

    public boolean collison(RectangleObject other) {
        Coordinates top_left = new Coordinates(this.coordinates.x,  this.coordinates.y);
        Coordinates bottom_right = new Coordinates(this.coordinates.x + this._size.x,  this.coordinates.y + this._size.y);
        for(Coordinates coord: other.coordinates()){
			if (coord.isGreaterThan(top_left) && coord.isLessThan(bottom_right))
            	return true;
        }
        return false;
    }

	public boolean isXOutOfBound() {
			for(Coordinates coord: this.coordinates()){
				if (coord.isXOutOfBound())
						return true;
			}
			return false;
	}

	public boolean isYOutOfBound() {
			for(Coordinates coord: this.coordinates()){
				if (coord.isYOutOfBound())
						return true;
			}
			return false;
	}

    public void tick() {
       this.coordinates.addTo(this.velocity);
    }

    public RectangleObject peekForwardInTime() {
        RectangleObject ro = new RectangleObject(this);
        ro.tick();
        return ro;
    }

    public void draw() {
      rect(this.coordinates.x, this.coordinates.y, this._size.x, this._size.y);
      fill(255);
    }
}

class Player {
    public int score;
    public int upKey, downKey;
    public RectangleObject rectangleObject;
    public boolean upKeyPressed = false, downKeyPressed = false;

    Player (int upKey, int downKey, float x, float y, float _width, float _height) {
        this.upKey = upKey;
        this.downKey = downKey;
        this.rectangleObject = new RectangleObject(new Coordinates(x, y), new FloatVector(_width, _height), new FloatVector(0, 0));
        this.score = 0;
    }

    public boolean downIsPressed() {
        return this.downKeyPressed;
    }

    public boolean upIsPressed() {
        return this.upKeyPressed;
    }

    public void pressKey() {
        if(keyCode == this.upKey)
            this.upKeyPressed = true;

        if(keyCode == this.downKey)
            this.downKeyPressed = true;
    }

    public void releaseKey() {
		if(keyCode == this.upKey)
			this.upKeyPressed = false;

    	if(keyCode == this.downKey)
        	this.downKeyPressed = false;
    }

	public void draw() {
		this.rectangleObject.draw();
	}
}

class Ball{
    public RectangleObject rectangleObject;

    Ball (float x, float y, float _width, float _height, float xVelocity, float yVelocity)
    {
      	this.rectangleObject = new RectangleObject(new Coordinates(x, y), new FloatVector(_width, _height), new FloatVector(xVelocity, yVelocity));
    }

    public void draw() {
      	this.rectangleObject.draw();
    }

    public void serve()
    {
	    if(this.rectangleObject.velocity.x == 0 && this.rectangleObject.velocity.y == 0)
	    {
			this.rectangleObject.velocity = new FloatVector(4, 4);
	    }
    }

     public void reset()
    {
	   this.rectangleObject.velocity = new FloatVector(0, 0);
	   this.rectangleObject.coordinates = new Coordinates(width / 2 - 12.5, height / 2 - 12.5);
	}

}