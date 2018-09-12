import java.lang.Math;

void setup()
{
    size(640, 480);
    stroke(110, 110, 110);
    strokeWeight(1.5);
}

int frames = 0;

void draw()
{
    background(206, 202, 134);
    Axis axis1 = new Axis(width/2, 10.0, float(width), frames % height);
    Axis axis2 = new Axis(width/2, 10.0, 10.0, float(height));
    Parabola parabola = new Parabola(axis1, axis2, 50);
    parabola.draw();
    frames++;
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
        stroke(110, 110, 110);
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
