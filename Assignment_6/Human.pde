public class Human {
	public color human_color = color(234, 180, 63);
	public FloatVector position;
	public float speed, direction, size;

	public Human(FloatVector position, float speed, float direction, float size) {
		this.position = position;
		this.speed = speed;
		this.direction = direction;
		this.size = size;
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
		stroke(this.human_color);
		fill(this.human_color);
		ellipse(this.position.x - this.size / 2, this.position.y - this.size / 2, this.size, this.size);
	}

}
