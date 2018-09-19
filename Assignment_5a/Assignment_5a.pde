// 1. Skapa en boll, ge den "gravitation"
//   och få den att studsa när den nuddar "marken"
  
//   vx += ax * dt;
//   x += vx * dt;
  
// 2. Skapa en boll som rör sig i en rörelse där
//   den rör sig dubbelt så snabbt i x-led som i y-led
  
//   cos, sin
  
// 3. Skapa en boll, få den att röra sig med hastighet i en
//   vinkel, gör så att den kan svänga höger och vänster
  
//   velocity += acceleration * dt;
//   x += cos(radians(angle)) * velocity * dt;
  
// 4. Gör en boll, få den att "lerpa" mot där användaren
//   trycker med musen
  
//   x = lerp(x, tx, 0.1);
  
// 5*. Gör ett simpelt plattformsspel

// 6*. Gör ett simpelt "bilspel" där en ser bilen ovanifrån

FloatVector acceleration = new FloatVector(0, 50);
FloatVector velocity = new FloatVector(0, 0);
FloatVector ball_position = new FloatVector(320, 20);

int fr = 60; //frameRate
float frameTime = 1.0 / (float) fr;
float tpf = 0;

float frame = 0;

void setup() {
	size(640, 480);
	strokeWeight(1.5);
	frameRate(fr);
}

void draw() {
	long currentTime = millis();
	main_draw();
	tpf = (millis() - currentTime) * 0.001f;
	//println("tpf: "+tpf);
	println("millis: "+millis());
}

void main_draw() {
	background(0);

	velocity.addTo((acceleration.multiply(frameTime)).add(acceleration.multiply(tpf)));	
  	if((ball_position.y + 10) >= height && velocity.y > 0)
  		velocity.y *= -0.9f;
  	ball_position.addTo((velocity.multiply(frameTime)).add(velocity.multiply(tpf)));

  	println("velocity.y: "+velocity.y);
    ellipse(ball_position.x, ball_position.y, 10, 10);
    frame++;
}



class FloatVector {
    public float x, y;

    public FloatVector (float x, float y) {
		this.x = x;
		this.y = y;
    }

	public FloatVector (float angle, float magnitude, boolean use_angle_input) {
		this.x = cos(angle) * magnitude;
		this.y = sin(angle) * magnitude;
    }

	// public FloatVector copy() {
	// 	return new FloatVector(this.x.clone(), this.y.clone());
	// }

	public void printObject() {
		println("this.x: "+this.x);
		println("this.y: "+this.y);
	}

	public float mag()
	{
		return this.magnitude();
	}

	public float magnitude() {
		return sqrt(this.x * this.x + this.y * this.y);
	}

	public float magnitudeNoSqrt() {
		return this.x * this.x + this.y * this.y;
	}


	public FloatVector add(FloatVector v1) {
		return new FloatVector(this.x + v1.x, this.y + v1.y);
	}

	public void addTo(FloatVector v1) {
		this.x += v1.x;
		this.y += v1.y;
	}

	public FloatVector subtract(FloatVector v1) {
		return new FloatVector(this.x - v1.x, this.y - v1.y);
	}

	public void subtractTo(FloatVector v1) {
		this.x -= v1.x;
		this.y -= v1.y;
	}

	public FloatVector multiply(float value) {
		return new FloatVector(this.x * value, this.y * value);
	}

	public void multiplyTo(float value) {
		this.x *= value;
		this.y *= value;
	}

	public FloatVector divide(float value) {
		return this.multiply(1 / value);
	}

	public void divideTo(float value) {
		this.multiplyTo(1 / value);
	}

}