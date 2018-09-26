color human_color = color(234, 180, 63);
public class Human {
	public FloatVector position;
	public float speed, direction, size;

	public float walk_distance, walked;

	public Human() {}

	public Human(FloatVector position, float speed, float direction, float size) {
		this.position = position;
		this.speed = speed;
		this.direction = direction;
		this.size = size;

		this.walk_distance = 0.0;
		this.walked = 0.0;
	}

	public void update_walk() {
		if(walk_distance - walked <= 0)
		{
			this.direction += random(-1, 1) * 90;
			this.walk_distance = random(0, 1) * 150 + 100;
			this.walked = 0;
		}
		
	}

	public void update(Human[] testSubjects) {
		this.update();
	}

	public void update() {
		
		float speed;
		if(this.walk_distance - walked >= this.speed)
			speed = this.speed;
		else
			speed = this.walk_distance - walked;

		this.walked += speed;

		this.position.x += cos(radians(this.direction)) * speed;
		this.position.y += sin(radians(this.direction)) * speed;

		if(this.position.x < 0 || this.position.x > width)
			if(this.position.x < 0)
				this.position.x += width;
			if(this.position.x > width)
				this.position.x -= width;
		if(this.position.y < 0 || this.position.y > height)
			if(this.position.y < 0)
				this.position.y += height;
			if(this.position.y > height)
				this.position.y -= height;

		this.update_walk();
	}

	public void draw() {
		this.draw_human(this.position, this.direction, this.size/30, human_color);
	}

	public void draw_human(FloatVector position, float rotation, float multiplier, color characterColor) {  
		float x = position.x;
		float y = position.y;
		rotation += 90;
		rotation *= -1.0;

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

		strokeWeight(4.1 * multiplier);
		float size = 39.3;
		fill(characterColor);
		ellipse(x, y, size, size);
	}

}
