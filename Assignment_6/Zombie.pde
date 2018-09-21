color zombie_color = color(0, 255, 0);
public class Zombie extends Human {
	public float speed = 3;
	FloatVector position;
	float direction;
	float size;
	
	public Zombie(FloatVector position, float speed, float direction, float size) {
		super(position, speed, direction, size);
		this.position = position;
		this.speed = speed;
		this.direction = direction;
		this.size = size;
	}

	public Zombie(Human human, float speed) {
		super(human.position, speed, human.direction, human.size);
		this.position = human.position;
		this.speed = speed;
		this.direction = human.direction;
		this.size = human.size;
	}

	public void update() {
		if(random(0, 1) < 0.5)
		{
			this.direction += 1;
		}
		else {
			this.direction -= 1;
		}

		this.position.x += cos(radians(this.direction)) * this.speed;
		this.position.y += sin(radians(this.direction)) * this.speed;

		if(this.position.x < 0 || this.position.x > width)
			if(this.position.x < 0)
				this.position.x += width;
			if(this.position.x > width)
				this.position.x -= width;
		if(this.position.y < 0 || this.position.y > width)
			if(this.position.y < 0)
				this.position.y += width;
			if(this.position.y > width)
				this.position.y -= width;
	}

	public void draw() {
		this.draw_zombie(this.position, this.direction, this.size/30, zombie_color);
	}

	public void draw_zombie(FloatVector position, float rotation, float multiplier, color characterColor) {	
		float x = position.x;
		float y = position.y;
		rotation += 90;
		rotation *=  -1.0;

		stroke(characterColor);
		strokeWeight(9.9 * multiplier);
		float f1 = 0.0;
		float r1 = 0.000;
		float f2 = -31.7;
		float r2 = -0.759;
		line(
			x + multiplier * f1 * sin(radians(rotation) + r1), 
			y + multiplier * f1 * cos(radians(rotation) + r1), 
			x + multiplier * f2 * sin(radians(rotation) + r2), 
			y + multiplier * f2 * cos(radians(rotation) + r2)
		);
		f1 = 0.0;
		r1 = 0.000;
		f2 = -31.7;
		r2 = 0.759;
		line(
			x + multiplier * f1 * sin(radians(rotation) + r1), 
			y + multiplier * f1 * cos(radians(rotation) + r1), 
			x + multiplier * f2 * sin(radians(rotation) + r2), 
			y + multiplier * f2 * cos(radians(rotation) + r2)
		);
		f1 = -31.7;
		r1 = 0.759;
		f2 = 39.4;
		r2 = -2.555;
		line(
			x + multiplier * f1 * sin(radians(rotation) + r1), 
			y + multiplier * f1 * cos(radians(rotation) + r1), 
			x + multiplier * f2 * sin(radians(rotation) + r2), 
			y + multiplier * f2 * cos(radians(rotation) + r2)
		);
		f1 = -31.7;
		r1 = -0.759;
		f2 = 39.4;
		r2 = 2.555;
		line(
		x + multiplier * f1 * sin(radians(rotation) + r1), 
		y + multiplier * f1 * cos(radians(rotation) + r1), 
		x + multiplier * f2 * sin(radians(rotation) + r2), 
		y + multiplier * f2 * cos(radians(rotation) + r2)
		);

		strokeWeight(4.1 * multiplier);
		float _size = 39.3;
		fill(characterColor);
		ellipse(x, y, _size, _size);
	}
}	