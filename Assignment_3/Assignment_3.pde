int frame = 0;

void setup()
{
	size(640, 480);
	strokeWeight(1.5);
}

void draw()
{
  background(42, 42, 84);
  //drawInACircle(2 + abs(int(sin(frame * 0.015) * 200)));

  for(int i=0; i < width; i++)
  {
    int range = 5;

    for(int j=0; j < range; j++)
    {
      if(int(i + frame) % (range * 3) == j)
        stroke(66, 134, 244);
      if(int(i + frame) % (range * 3) == range + j)
        stroke(214, 25, 94);
      if(int(i + frame) % (range * 3) == range * 2 + j)
        stroke(107, 216, 23);
    }
    if(int(i + frame) % 6 == 0 && int(i + frame) % 6 == 1)
      stroke(66, 134, 244);
    if(int(i + frame) % 6 == 2 && int(i + frame) % 6 == 3)
      stroke(214, 25, 94);
    if(int(i + frame) % 6 == 2)
      stroke(107, 216, 23);

    point(10 + i * 6, height - 25 - sin(frame * 0.08 + i * 0.09) * 25);
  }

  for(int i=0; i < width; i++)
  {
    int range = 5;

    for(int j=0; j < range; j++)
    {
      if(int(i + frame) % (range * 3) == j)
        stroke(66, 134, 244);
      if(int(i + frame) % (range * 3) == range + j)
        stroke(214, 25, 94);
      if(int(i + frame) % (range * 3) == range * 2 + j)
        stroke(107, 216, 23);
    }
    if(int(i + frame) % 6 == 0 && int(i + frame) % 6 == 1)
      stroke(66, 134, 244);
    if(int(i + frame) % 6 == 2 && int(i + frame) % 6 == 3)
      stroke(214, 25, 94);
    if(int(i + frame) % 6 == 2)
      stroke(107, 216, 23);

      point(10 + i * 6, height - 25 - cos(frame * 0.08 + i * 0.09) * 25);
  }

  //drawInACircle(3);

  Axis axis_11 = new Axis(width/2, 10.0, 10.0, 10.0);
  Axis axis_12 = new Axis(width/2, 10.0, width/2 - width/2 * sin(frame * 0.02) * 0.5, height - 100.0);
  Parabola parabola_1 = new Parabola(axis_11, axis_12, 50);
  parabola_1.draw();

  Axis axis_21 = new Axis(width/2, 10.0, width - 20.0, 10.0);
  Axis axis_22 = new Axis(width/2, 10.0, width/2 - width/2 * sin(frame * 0.02) * 0.5, height - 100.0);
  Parabola parabola_2 = new Parabola(axis_21, axis_22, 50);
  parabola_2.draw();

  drawInACircle(0, 220, 150, 200, frame * 0.2);
  drawInACircle(width, 220, 150, 200, frame * 0.2);

	frame++;
}

void drawInACircle(int x, int y, int amount){
    for(float f=0, i=0; f < (2 * PI); f += (2 * PI) / amount, i += 1)
    {
        if(int(i) % 3 == 0)
          stroke(66, 134, 244);
        if(int(i) % 3 == 1)
          stroke(214, 25, 94);
        if(int(i) % 3 == 2)
          stroke(107, 216, 23);

        // if(i % 3 == 0)
        //   stroke(66, 134, 244);
        // if(i % 3 == 1)
        //   stroke(214, 25, 94);
        // if
        //   stroke(107, 216, 23);

        point(x + sin(f) * 150, y + cos(f) * 150);
    }
}

void drawInACircle(int x, int y, float size, int amount, float offset){
    for(float f=0, i=0; f < (2 * PI); f += (2 * PI) / amount, i += 1)
    {
        if(int(i) % 3 == 0)
          stroke(66, 134, 244);
        if(int(i) % 3 == 1)
          stroke(214, 25, 94);
        if(int(i) % 3 == 2)
          stroke(107, 216, 23);
        // if(i % 3 == 0)
        //   stroke(66, 134, 244);
        // if(i % 3 == 1)
        //   stroke(214, 25, 94);
        // if
        //   stroke(107, 216, 23);

        point(x + sin(f+offset) * size, y + cos(f+offset) * size);
    }
}

class Axis {
  public float xStart, yStart, xEnd, yEnd;
  Axis (float x1, float y1, float x2, float y2) {
    this.xStart = x1;
    this.yStart = y1;
    this.xEnd = x2;
    this.yEnd = y2;
  }

  public float f(float x) {
    float k_value = (yEnd - yStart) / (xEnd - xStart);
    return (x - xStart) * k_value;
  }

  public float axis_length()
  {
    float x2 = (yEnd - yStart) * (yEnd - yStart);
    float y2 = (xEnd - xStart) * (xEnd - xStart);
    return (float) Math.sqrt(x2 + y2);
  }

  public float xlength()
  {
    return (xEnd - xStart);

  }
  public float ylength()
  {
    return (yEnd - yStart);
  }

  public boolean isFlatX()
  {
    return this.xStart == this.xEnd;
  }

  public void draw(Axis other, int number_of_lines)
  {
    float axis_step = this.xlength() / number_of_lines;
    float other_axis_step = other.xlength() / number_of_lines;
    for(float i=0; i < number_of_lines + 1; i++)
    {
      if(i % 3 == 0)
        stroke(0, 0, 0);
      else
      {
        int range = 5;

        for(int j=0; j < range; j++)
        {
          if(int(i + frame) % (range * 3) == j)
            stroke(66, 134, 244);
          if(int(i + frame) % (range * 3) == range + j)
            stroke(214, 25, 94);
          if(int(i + frame) % (range * 3) == range * 2 + j)
            stroke(107, 216, 23);
        }
        if(int(i + frame) % 6 == 0 && int(i + frame) % 6 == 1)
          stroke(66, 134, 244);
        if(int(i + frame) % 6 == 2 && int(i + frame) % 6 == 3)
          stroke(214, 25, 94);
        if(int(i + frame) % 6 == 2)
          stroke(107, 216, 23);
      }
      line(
        i * this.xlength() / number_of_lines + this.xStart,
        i * this.ylength() / number_of_lines + this.yStart,
        other.xlength() - (i * other.xlength() / number_of_lines) + other.xStart,
        other.ylength() - (i * other.ylength() / number_of_lines) + other.yStart);
    }

    stroke(0, 0, 0);
    line(this.xStart, this.yStart, this.xEnd, this.yEnd);
    line(other.xStart, other.yStart, other.xEnd, other.yEnd);

  }
}

class Parabola {
  Axis axis1, axis2;
  int numberOfLines;
  Parabola (Axis axis_1, Axis axis_2, int number_of_lines) {
    axis1 = axis_1;
    axis2 = axis_2;
    numberOfLines = number_of_lines;
  }

  public void draw(){
    this.axis1.draw(this.axis2, this.numberOfLines);
  }
}
