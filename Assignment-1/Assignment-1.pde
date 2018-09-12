import java.lang.Math;


int nameXPosition = 0;
int nameYPosition = 10;

float xVelocity = 0.1;
float yVelocity = 0.1;

float gravity = 1;

int multiplier = 1;
int character_width = 34 * multiplier;
int character_height = 44 * multiplier;

int frames = 300;

void setup()
{
    size(768, 432);
    strokeWeight(1.5);
}

void draw()
{
    drawSkyscraper(10, 10, multiplier);
    print(frames);
    print(" ");
    print((float(frames % 1000) / 1000));
    print(" ");
    println(isNight());
    frames++;
}

void _main()
{
    //Adde r2#7734
    drawA(0, 0, multiplier);
    drawD(character_width, 0, multiplier);
    drawD(character_width * 2, 0, multiplier);
    drawE(character_width * 3, 0, multiplier);

    drawR(Math.round(character_width * 4.5), 0, multiplier);
    draw2(Math.round(character_width * 5.5), 0, multiplier);

    if(nameYPosition + character_height + yVelocity > height)
    {
        nameYPosition = height - character_height;
        yVelocity *= -0.85;
        xVelocity *= 0.95;
    }
    else
        nameYPosition += Math.round(yVelocity);

    if(nameXPosition + Math.round(character_width * 6.5) + xVelocity > width)
    {
        nameXPosition = width - Math.round(character_width * 6.5);
        xVelocity *= -0.90;
    }
    else if(nameXPosition + xVelocity < 0)
    {
        nameXPosition = 0;
        xVelocity *= -0.95;
    }
    else
        nameXPosition += Math.round(xVelocity);

    yVelocity += gravity;

    if(Math.abs(yVelocity) < 2 && height - (nameYPosition + character_height) < 10)
      yVelocity = -(15 + Math.round(Math.random() * 20));

    if(Math.abs(xVelocity) < 4)
      xVelocity = (10 + Math.round(Math.random() * 20)) * (xVelocity/Math.abs(xVelocity));

    println(xVelocity);
    drawName(nameXPosition, nameYPosition, character_width, multiplier);
}

boolean isNight()
{
    return (float(frames % 1000) / 1000) > 0.5;
}

void drawSkyscraper(int x, int y, int multiplier)
{
      stroke(61, 61, 59);
      fill(61, 61, 59);
      rect(x, y,
        130 * multiplier,
        280 * multiplier
      );

      for(int i=0; i < 4; i++)
      {
          drawWindow(x + 10 * multiplier,
            y + (10 + 10 * i + 50 * i) * multiplier,
            45, 45, multiplier);
      }

      for(int i=0; i < 4; i++)
      {
          drawWindow(x + 75 * multiplier, y + (10 + 10 * i + 50 * i) * multiplier, 45, 45, multiplier);
      }
}

void drawWindow(int x, int y, int _width, int _height, int multiplier)
{
    if(isNight())
    {
      stroke(239, 239, 9);
      fill(239, 239, 9);
    }
    else
    {
      stroke(181, 181, 177);
      fill(181, 181, 177);
    }
    rect(x, y,
      _width * multiplier,
      _height * multiplier);
}

void drawName(int x, int y, int character_width, int multiplier)
{
    background(170, 170, 255);
    drawA(x, y, multiplier);
    drawD(character_width + x, y, multiplier);
    drawD(character_width * 2 + x, y, multiplier);
    drawE(character_width * 3 + x, y, multiplier);

    drawR(Math.round(character_width * 4.5) + x, y, multiplier);
    draw2(Math.round(character_width * 5.5) + x, y, multiplier);

}

void drawA(int x, int y, int multiplier) //A
{
    line(
      x + 16.8 * multiplier,
      y + 2.9 * multiplier,
      x + 31.8 * multiplier,
      y + 42.1 * multiplier);
    line(
      x + 1.9 * multiplier,
      y + 42.4 * multiplier,
      x + 16.7 * multiplier,
      y + 2.7 * multiplier);
    line(
      x + 9.9 * multiplier,
      y + 21.2 * multiplier,
      x + 23.9 * multiplier,
      y + 21.2 * multiplier);
}

void drawD(int x, int y, int multiplier) //d
{
    line(
      x + 26.0 * multiplier,
      y + 3.0 * multiplier,
      x + 26.0 * multiplier,
      y + 41.0 * multiplier);
    arc(
      x + 18.6 * multiplier,
      y + 28.8 * multiplier,
      23.1 * multiplier,
      22.9 * multiplier,
      0.86, 5.41, OPEN);
    noFill();
}

void drawE(int x, int y, int multiplier) //e
{
    arc(
      x + 17.0 * multiplier,
      y + 30.0 * multiplier,
      15.0 * multiplier,
      18.0 * multiplier,
      1.00, 6.24, OPEN);
    noFill();
    line(
      x + 24.2 * multiplier,
      y + 29.7 * multiplier,
      x + 9.2 * multiplier,
      y + 29.6 * multiplier);

}

void drawR(int x, int y, int multiplier) //r
{
    line(
      x + 9.6 * multiplier,
      y + 17.9 * multiplier,
      x + 9.5 * multiplier,
      y + 41.0 * multiplier);
    arc(
      x + 20.6 * multiplier,
      y + 28.8 * multiplier,
      23.1 * multiplier,
      22.9 * multiplier,
      3.49, 4.53, OPEN);
    noFill();
}

void draw2(int x, int y, int multiplier) //2
{
    line(
      x + 28.0 * multiplier,
      y + 41.0 * multiplier,
      x + 4.7 * multiplier,
      y + 41.0 * multiplier);
    line(
      x + 24.1 * multiplier,
      y + 21.9 * multiplier,
      x + 4.7 * multiplier,
      y + 41.0 * multiplier);
    arc(
      x + 16.5 * multiplier,
      y + 14.3 * multiplier,
      23.0 * multiplier,
      20.3 * multiplier,
      3.45, 7.14, OPEN);
    noFill();
}
