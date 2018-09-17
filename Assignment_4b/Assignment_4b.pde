int frame = 0;

PVector circle_vector = new PVector(0, 0);

PVector location = new PVector(0, 0);
PVector velocity = new PVector(5, 3);
PVector geometry = new PVector(10, 10);

void setup()
{
		size(640, 480);
	  strokeWeight(1.5);
}

void draw()
{
	  background(0);
    PVector mouse_vector =  new PVector(mouseX, mouseY);
    PVector difference = mouse_vector.sub(circle_vector);
    
    circle_vector.add(difference.mult(0.1));
	ellipse(circle_vector.x, circle_vector.y, geometry.x, geometry.y);

	PVector new_location = location.copy();
	new_location.add(velocity);

	if(new_location.x > (width - geometry.x) || new_location.x < 0)
		velocity.x *= -1.0;
	if(new_location.y > (height - geometry.y) || new_location.y < 0)
		velocity.y *= -1.0;
	location = location.add(velocity);
	ellipse(location.x, location.y, 10, 10);

	frame++;
}