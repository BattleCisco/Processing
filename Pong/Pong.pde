Player player1 = new Player(87, 83, 0, 0, 10, 200);
Player player2 = new Player(38, 40, 0, 0, 10, 200);
Ball ball = new Ball(0, 0, 25, 25, 0, 0);

Player[] players = {player1, player2};
int frame = 0;

float player_speed = 6;

void setup()
{
		size(640, 480);
	  player2.rectangleObject.coordinates.x = width - player2.rectangleObject._width;
	  ball.rectangleObject.coordinates.x = width / 2; //width / 2;
	  ball.rectangleObject.coordinates.y = height / 2;
	  strokeWeight(1.5);
		//frameRate(8);
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
				ball.rectangleObject.y_velocity *= -1.0;

		if(player1.rectangleObject.collison(future_ball) || player2.rectangleObject.collison(future_ball))
				ball.rectangleObject.x_velocity *= -1.0;

		//println(future_ball.collison(player1.rectangleObject), future_ball.collison(player2.rectangleObject));
		ball.rectangleObject.tick();
		ball.draw();
}

void keyPressed(){
		if(keyCode == 72)
		{
			ball.rectangleObject.coordinates.x = width / 2;
		  ball.rectangleObject.coordinates.y = height / 2;
			ball.rectangleObject.x_velocity = 0.0;
			ball.rectangleObject.y_velocity = 0.0;
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

class Coordinates{
		public float x, y;

		Coordinates (float x, float y){
				this.x = x;
				this.y = y;
		}

		public boolean isXOutOfBound()
		{
				return this.x > width || this.x < 0;
		}

		public boolean isYOutOfBound()
		{
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
    public float _width, _height, x_velocity, y_velocity;
    public Coordinates coordinates;

    RectangleObject (Coordinates coordinates, float _width, float _height, float x_velocity, float y_velocity) {
        this.coordinates = coordinates;
        this._width = _width;
        this._height = _height;
        this.x_velocity = x_velocity;
        this.y_velocity = y_velocity;
    }

    RectangleObject (RectangleObject other) {
        this.coordinates = other.coordinates;
        this._width = other._width;
        this._height = other._height;
        this.x_velocity = other.x_velocity;
        this.y_velocity = other.y_velocity;
    }

    public Coordinates[] coordinates() {
	      Coordinates[] coords = {
	          new Coordinates(this.coordinates.x,  this.coordinates.y),
	          new Coordinates(this.coordinates.x,  this.coordinates.y + this._height),
						new Coordinates(this.coordinates.x + this._width,  this.coordinates.y),
						new Coordinates(this.coordinates.x + this._width,  this.coordinates.y + this._height),
	      };
	      return coords;
    }

    public boolean collison(RectangleObject other) {
        Coordinates top_left = new Coordinates(this.coordinates.x,  this.coordinates.y);
        Coordinates bottom_right = new Coordinates(this.coordinates.x + this._width,  this.coordinates.y + this._height);
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
       this.coordinates.x += this.x_velocity;
       this.coordinates.y += this.y_velocity;
    }

    public RectangleObject peekForwardInTime() {
        RectangleObject ro = new RectangleObject(this);
        ro.tick();
        return ro;
    }

    public void draw() {
      rect(this.coordinates.x, this.coordinates.y, this._width, this._height);
      fill(255);
    }
}

class Player {
    public int upKey, downKey;
    public RectangleObject rectangleObject;
    public boolean upKeyPressed = false, downKeyPressed = false;

    Player (int upKey, int downKey, float x, float y, float _width, float _height) {
        this.upKey = upKey;
        this.downKey = downKey;
        this.rectangleObject = new RectangleObject(new Coordinates(x, y), _width, _height, 0.0, 0.0);
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
      if (keyCode == 74)
      {
          ball.serve();
          println("Serving ball.");
      }

      if(keyCode == this.upKey)
          this.upKeyPressed = false;

      if(keyCode == this.downKey)
          this.downKeyPressed = false;
    }

	  public void draw() {
	    	this.rectangleObject.draw();
	  }
}

class Ball {
    public RectangleObject rectangleObject;

    Ball (float x, float y, float _width, float _height, float xVelocity, float yVelocity)
    {
      	this.rectangleObject = new RectangleObject(new Coordinates(x, y), _width, _height, xVelocity, yVelocity);
    }

    public void draw() {
      	this.rectangleObject.draw();
    }

    public void serve()
    {
	      if(this.rectangleObject.x_velocity == 0 && this.rectangleObject.y_velocity == 0)
	      {
		        this.rectangleObject.x_velocity = 5;
		        this.rectangleObject.y_velocity = 5;
	      }
    }

}
