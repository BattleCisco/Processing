public class Animation {
	public Animation () {}
}

public class Slide extends Animation{
	public FloatVector start;
	public FloatVector end;
	public float size;
	public color parentColor;
	public color childColor;

	public Slide (FloatVector start, FloatVector end, float size, color parentColor) {
		this.start = start;
		this.end = end;
		this.size = size;
		this.parentColor = parentColor;
		this.childColor = 0;
	}

	public void draw(float progress) {
		FloatVector differenceVector = this.end.subtract(this.start);

		int redSum = int(red(this.parentColor) * (1 - progress) + red(this.childColor) * progress);
		int greenSum = int(green(this.parentColor) * (1 - progress) + green(this.childColor) * progress);
		int blueSum = int(blue(this.parentColor) * (1 - progress) + blue(this.childColor) * progress);
		
		fill(redSum, greenSum, blueSum);
		//fill(255, 0, 0);
		stroke(0);
		rect(
			this.start.x + differenceVector.x * sin(radians(90) * progress), 
			this.start.y + differenceVector.y * sin(radians(90) * progress), 
			this.size * (0.5 + sin(radians(90) * progress) * 0.5), 
			this.size * (0.5 + sin(radians(90) * progress) * 0.5));
	}

}

public class Fade extends Animation{
	public FloatVector position;
	public float size;
	public color parentColor;

	public Fade (FloatVector position, float size, color parentColor) {
		this.position = position;
		this.size = size;
		this.parentColor = parentColor;
	}

	public void draw(float progress) {
		fill(red(this.parentColor)* (1 - progress), green(this.parentColor)* (1 - progress), blue(this.parentColor)* (1 - progress));//, int(255 * (1 - progress)));
		//fill(255, 0, 0);
		stroke(0);
		rect(this.position.x, this.position.y, this.size, this.size);
		stroke(0);
	}


}

public class Implode extends Animation{
	public FloatVector position;
	public float size;
	public color parentColor;

	public Implode (FloatVector position, float size, color parentColor) {
		this.position = position;
		this.size = size;
		this.parentColor = parentColor;
	}

	public void draw(float progress) {
		stroke(0);
		fill(0);
		rect(
			this.position.x, 
			this.position.y, 
			this.size, 
			this.size);

		translate(this.position.x + this.size / 2, this.position.y + this.size / 2);
		
		rectMode(CENTER);
		fill(red(this.parentColor)* (1 - progress), green(this.parentColor)* (1 - progress), blue(this.parentColor)* (1 - progress));//, int(255 * (1 - progress)));
		//fill(255, 0, 0);
		stroke(0);
		rect(0, 0, this.size * (1 - progress), this.size * (1 - progress));
		stroke(0);
		rectMode(CORNER);
		translate(-1 * (this.position.x + this.size / 2), -1 * (this.position.y + this.size / 2));
	}


}

public class Twist extends Animation{
	public FloatVector position;
	public float size;
	public color parentColor;

	public Twist (FloatVector position, float size, color parentColor) {
		this.position = position;
		this.size = size;
		this.parentColor = parentColor;
	}

	public void draw(float progress) {
		stroke(0);
		fill(0);
		rect(
			this.position.x, 
			this.position.y, 
			this.size, 
			this.size);

		translate(this.position.x + this.size / 2, this.position.y + this.size / 2);
		rotate(radians(180) * progress);
		
		rectMode(CENTER);
		fill(this.parentColor);
		stroke(0);
		rect(0, 0, this.size * (1 - sin(radians(90) * progress)), this.size * (1 - sin(radians(90) * progress)));
		rectMode(CORNER);
		stroke(0);

		rotate(-radians(180) * progress);
		translate(-1 * (this.position.x + this.size / 2), -1 * (this.position.y + this.size / 2));
	}


}