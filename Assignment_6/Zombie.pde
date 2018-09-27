color zombie_color = color(0, 255, 0);
public class Zombie extends Human {
	public float speed = 3;
	FloatVector position;
	public float direction;
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

	public void setDirection(float f) {
		this.direction = f;
	}

	public void update_walk(Human[] testSubjects) {
		int humans = 0;
		for (Human testSubject : testSubjects) {
			if(!(testSubject instanceof Zombie))
				humans++;
		}
		
		if(humans > 0)
		{
			for (int i = 0; i < testSubjects.length - 1; i++) {
				float closest = Float.MAX_VALUE;
				for (int j = i + 1; j < testSubjects.length; j++) {
					if(!(
						testSubjects[i] instanceof Zombie ^ 
						testSubjects[j] instanceof Zombie)) {
						continue;
					}
					else if(i == j)
						continue;

					FloatVector distance_vector;
					if(testSubjects[i] instanceof Zombie) {
						distance_vector = testSubjects[i].position.subtract(testSubjects[j].position);
					}
					else {
						distance_vector = testSubjects[j].position.subtract(testSubjects[i].position);
					}
					float distance_magnitude = distance_vector.magNoSqrt();

					if(distance_magnitude < closest)
					{
						if(testSubjects[i] instanceof Zombie) {
							////print("i is a zombie, ");
							closest = distance_magnitude;
							//print("Changed direction from " + testSubjects[i].direction);
							Zombie z = (Zombie) testSubjects[i];
							// float rad = distance_vector.angle() + radians(180);
							// if(asin(distance_vector.y/distance_vector.mag()) == acos(distance_vector.x/distance_vector.mag()))
							// 	rad = asin(distance_vector.y/distance_vector.mag());
							// else
							// 	rad = PI - asin(distance_vector.y/distance_vector.mag());
								//rad = asin(distance_vector.y/distance_vector.mag());
							float rad;
							if(distance_vector.y > 0){
								if(distance_vector.x > 0)
									rad = asin(distance_vector.y/distance_vector.mag());
								else
									rad = radians(180) - asin(distance_vector.y/distance_vector.mag());
							}
							else if (distance_vector.y < 0) {
								if(distance_vector.x > 0)
									rad = asin(distance_vector.y/distance_vector.mag());
								else
									rad = radians(180) - asin(distance_vector.y/distance_vector.mag());
							}
							else
								rad = 0.0;

							z.setDirection(degrees(rad) + 180);


							//println(" to " + testSubjects[i].direction);
						}
						else if (testSubjects[j] instanceof Zombie) {	
							print("j is a zombie, ");
							closest = distance_magnitude;
							print("Changed direction from " + testSubjects[j].direction);
							Zombie z = (Zombie) testSubjects[j];
							float rad = asin(distance_vector.y/distance_vector.mag());
							z.setDirection(degrees(rad));
							println(" to " + testSubjects[j].direction);
						}
					}
				}
			}
		}
	}	

	public void update(Human[] testSubjects) {
		
		this.update_walk(testSubjects);

		this.position.x += cos(radians(this.direction)) * this.speed;
		this.position.y += sin(radians(this.direction)) * this.speed;

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
	}

	public void draw() {
		this.draw_zombie(this.position, this.direction, this.size/30, zombie_color);
		//draw_angle(this.direction);
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
