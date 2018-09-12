import java.lang.Math;

float nameXPosition = 0;
float nameYPosition = 10;

float xVelocity = 0.1;
float yVelocity = 0.1;

float gravity = 1;

float multiplier = 1;
float character_width = Math.round(34 * multiplier);
float character_height = Math.round(44 * multiplier);

int frames = 300;

void setup()
{
    size(768, 432);
    strokeWeight(1.5);
}

void draw()
{
    if(isNight()){
      background(23, 67, 102);
      stroke(15, 86, 16);
      fill(15, 86, 16);
    }
    else{
      background(85, 171, 237);
      stroke(37, 196, 29);
      fill(37, 196, 29);
    }
    rect(0, height / 2, width, height / 2);

    drawSkyscraper(690, 90, 0.5);
    drawSkyscraper(578, 57, 0.7);
    drawSkyscraper(434, 35, 1.0);
    drawSkyscraper(254, 28, 1.2);
    drawSkyscraper(20, 28, 1.5);
    frames++;
    
    _main();
}

void _main()
{
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
    stroke(119, 9, 9);
    drawName(nameXPosition, nameYPosition, character_width, multiplier);
}

boolean isNight()
{
    return (float(frames % 1000) / 1000) > 0.5;
}

void drawSkyscraper(float x, float y, float multiplier)
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

void drawWindow(float x, float y, float _width, float _height, float multiplier)
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

void drawName(float x, float y, float character_width, float multiplier)
{
    drawA(x, y, multiplier);
    drawD(character_width + x, y, multiplier);
    drawD(character_width * 2 + x, y, multiplier);
    drawE(character_width * 3 + x, y, multiplier);

    drawR(Math.round(character_width * 4.5) + x, y, multiplier);
    draw2(Math.round(character_width * 5.5) + x, y, multiplier);

}

void drawA(float x, float y, float multiplier) //A
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

void drawD(float x, float y, float multiplier) //d
{
    line(
      x + 26.0 * multiplier,
      y + 3.0 * multiplier,
      x + 26.0 * multiplier,
      y + 41.0 * multiplier);
    noFill();
    arc(
      x + 18.6 * multiplier,
      y + 28.8 * multiplier,
      23.1 * multiplier,
      22.9 * multiplier,
      0.86, 5.41, OPEN);
}

void drawE(float x, float y, float multiplier) //e
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

void drawR(float x, float y, float multiplier) //r
{
    line(
      x + 9.6 * multiplier,
      y + 17.9 * multiplier,
      x + 9.5 * multiplier,
      y + 41.0 * multiplier);
    noFill();
    arc(
      x + 20.6 * multiplier,
      y + 28.8 * multiplier,
      23.1 * multiplier,
      22.9 * multiplier,
      3.49, 4.53, OPEN);
}

void draw2(float x, float y, float multiplier) //2
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
    noFill();
    arc(
      x + 16.5 * multiplier,
      y + 14.3 * multiplier,
      23.0 * multiplier,
      20.3 * multiplier,
      3.45, 7.14, OPEN);
}
