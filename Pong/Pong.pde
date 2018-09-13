int frame = 0;
int value = 0;

Player player1 = new Player(87, 83, 5, 0, 10, 100);
Player player2 = new Player(38, 40, 0, 0, 10, 100);

Ball ball = new Ball(0, 0, 25, 25, 0, 0);

void setup()
{
	size(640, 480);
  player2.rectangleObject.coordinates.x = width - 5;
  ball.rectangleObject.coordinates.x = width / 2;
  ball.rectangleObject.coordinates.y = height / 2;
  strokeWeight(1.5);
}

Player[] players = {player1, player2};

void draw()
{
  background(0);
  for(Player p: players)
  {
    if(p.downIsPressed() ^ p.upIsPressed())
    {
      if(p.downIsPressed())
      {
        p.rectangleObject.coordinates.y += 4;
      }
      if(p.upIsPressed())
      {
        p.rectangleObject.coordinates.y -= 4;
      }
    }
    p.draw();
  }
  ball.draw();
}

void keyPressed(){
  //println(key + " is pressed.");
  player1.pressKey();
  player2.pressKey();
}

void keyReleased(){
  //println(key + " is released.");
  player1.releaseKey();
  player2.releaseKey();
}

class RectangleObject {
    class Coordinates{
      float x, y;

      Coordinates (float x, float y){
        this.x = x;
        this.y = y;
      }

      public boolean isGreaterThan(Coordinates other) {
        return this.x > other.x && this.y > other.y;
      }

      public boolean isLessThan(Coordinates other) {
        return this.x < other.x && this.y < other.y;
      }
  }

    public float _width, _height, velocity_x, velocity_y;
    public Coordinates coordinates;

    RectangleObject (float x, float y, float _width, float _height, float velocity_x, float velocity_y) {
        this.coordinates = Coordinates(x, y);
        this._width = _width;
        this._height = _height;
        this.velocity_x = velocity_x;
        this.velocity_y = velocity_y;
    }

    RectangleObject (RectangleObject other) {
        this.coordinates = other.coordinates;
        this._width = other._width;
        this._height = other._height;
        this.velocity_x = other.velocity_x;
        this.velocity_y = other.velocity_y;
    }

    public RectangleObject.Coordinates[] edge_coordinates()
    {
      RectangleObject.Coordinates[] coords = {
          Coordinate(this.coordinates.x - this._width / 2,  this.coordinates.y - this._height / 2),
          Coordinate(this.coordinates.x + this._width / 2,  this.coordinates.y - this._height / 2),
          Coordinate(this.coordinates.x - this._width / 2,  this.coordinates.y + this._height / 2),
          Coordinate(this.coordinates.x + this._width / 2,  this.coordinates.y + this._height / 2),
      };
      return coords;
    }

    public boolean collison(Object other)
    {
        ro = this.peekForwardInTime();
        boolean collide = false;
        Coordinates top_left = Coordinate(this.coordinates.x - this._width / 2,  this.coordinates.y - this._height / 2);
        Coordinates bottom_right = Coordinate(this.coordinates.x + this._width / 2,  this.coordinates.y + this._height / 2);
        for(RectangleObject.Coordinate coord: ro.edge_coordinates()){
          if (coord.isGreaterThan(top_left) && coord.isLessThan(bottom_right))
            collide = true;
        }
        return collide;
    }

    public void tick()
    {
       this.coordinates.x += this.velocity_x;
       this.coordinates.y += this.velocity_y;
    }

    public RectangleObject peekForwardInTime()
    {
        RectangleObject ro = new RectangleObject(this);
        ro.tick();
        return ro;
    }

    public void draw() {
      rect(this.coordinates.x - this._width/2, this.coordinates.y - this._height/2, this._width, this._height);
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
        this.rectangleObject = new RectangleObject(x, y, _width, _height, 0, 0);
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
          println(ball.xVelocity, ball.yVelocity);
          ball.serve();
          println(ball.xVelocity, ball.yVelocity);
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
      this.rectangleObject = new RectangleObject(x, y, _width, _height, xVelocity, yVelocity);
    }

    public float[] coordinates() {
      int[] _coordinates={};
    }

    public void draw() {
      this.rectangleObject.draw();
    }

    public void serve()
    {
      if(this.rectangleObject.velocity_x == 0 && this.velocity_y == 0)
      {
        this.rectangleObject.velocity_x = 5;
        this.rectangleObject.velocity_y = 5;
      }
    }

}
