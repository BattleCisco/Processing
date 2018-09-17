int frame = 0;

PVector circle_vector = new PVector(0, 0);

void setup()
{
		size(640, 480);
	  strokeWeight(1.5);
		//frameRate(8);
}

void draw()
{
	  background(0);
    PVector mouse_vector =  new PVector(mouseX, mouseY);
    PVector difference = mouse_vector.sub(circle_vector);
    circle_vector.add(difference.mult(0.1));

    ellipse(circle_vector.x, circle_vector.y, 10, 10);
    frame++;
}