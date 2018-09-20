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

void draw()
{
	background(0);
	for(Player p: players)
	{
	    if(p.downIsPressed() ^ p.upIsPressed())
	    {
			if(p.downIsPressed())
			{
				p.rectangleObject.coordinates.y += player_speed;
			}
			if(p.upIsPressed())
			{
				p.rectangleObject.coordinates.y -= player_speed;
			}
	    }
	    p.draw();
	}

	RectangleObject future_ball = ball.rectangleObject.peekForwardInTime();
	if(future_ball.isYOutOfBound())
		ball.rectangleObject.velocity.y *= -1.0;

	if(future_ball.isXOutOfBound())
	{
		if(future_ball.coordinates.x > width / 2)
			player2.score++;
		else{
			player1.score++;
		}
		ball.reset();

	} 

	if(player1.rectangleObject.collison(future_ball) || player2.rectangleObject.collison(future_ball))
		ball.rectangleObject.velocity.x *= -1.0;

	//println(future_ball.collison(player1.rectangleObject), future_ball.collison(player2.rectangleObject));
	ball.rectangleObject.tick();
	ball.draw();

	strokeWeight(3);
	stroke(255);
	int numberOfLines = 25;
	float lengthPerLine = (height - 40) / numberOfLines;
	for(float i=0; i < numberOfLines; i++)
	{	
		if (i % 2 == 0)	
			line(
				width / 2, 
				20 + lengthPerLine * i, 
				width / 2, 
				20 + lengthPerLine * (i + 1));
	}
	strokeWeight(1.5);
	textFont(font);
	text(player1.score, width / 2 - -23, 88);
	text(player2.score, width / 2 - 69, 88);
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