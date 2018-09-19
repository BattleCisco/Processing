int frame = 0;

PVector circle_vector = new PVector(0, 0);

void setup() {
		size(640, 480);
	  strokeWeight(1.5);
		frameRate(3);
}

void draw() {
	  background(0);
    PVector mouse_vector =  new PVector(mouseX, mouseY);
    PVector difference = mouse_vector.sub(circle_vector);
    circle_vector.add(difference.mult(0.1));

    ellipse(circle_vector.x, circle_vector.y, 10, 10);
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

	public Vector copy() {
		return new Vector(this.x.clone(), this.y.clone());
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


	public Vector add(Vector v1) {
		return new Vector(this.x + v1.x, this.y + v1.y);
	}

	public void addTo(Vector v1) {
		this.x += v1.x;
		this.y += v1.y;
	}

	public Vector subtract(Vector v1) {
		return new Vector(this.x - v1.x, this.y - v1.y);
	}

	public void subtractTo(Vector v1) {
		this.x -= v1.x;
		this.y -= v1.y;
	}

	public Vector multiply(int value) {
		return new Vector(this.x * value, this.y * value);
	}

	public void multiplyTo(int value) {
		this.x *= value;
		this.y *= value;
	}

	public void divide(int value) {
		this.multiply(1 / value);
	}

	public void divide(int value) {
		this.multiplyTo(1 / value)
	}

}