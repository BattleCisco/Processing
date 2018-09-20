public class Zombie extends Human {
	public float speed = 3;
	public color zombie_color = color(0, 255, 0);
	FloatVector position;
	float direction;
	float size;
	
	public Zombie(FloatVector position, float speed, float direction, float size) {
		super(position, speed, direction, size);
	}

	public Zombie(Human human, float speed) {
		super(human.position, speed, human.direction, human.size);
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
		stroke(this.zombie_color);
		fill(this.zombie_color);
		ellipse(this.position.x - this.size / 2, this.position.y - this.size / 2, this.size, this.size);
	}

}