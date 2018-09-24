public class Drawable {

	public Drawable() {
		return;
	}

	public void draw(FloatVector position, float rotation, float scalar){

	}
};

public class Rectangle extends Drawable {

	FloatVector positionOffset, size;
	color rectangeColor;

	public Rectangle (FloatVector positionOffset, FloatVector size, color rectangeColor) {
		this.positionOffset = positionOffset;
		this.size = size;
		this.rectangeColor = rectangeColor;
	}

	public void draw(FloatVector position, float rotation, float scalar) {
		translate(position.x, position.y);
		rotate(radians(rotation));
		stroke(this.rectangeColor);
		fill(this.rectangeColor);
		rect(
			scalar * (this.positionOffset.x - this.size.x / 2), 
			scalar * (this.positionOffset.y - this.size.y / 2),
			scalar * this.size.x,
			scalar * this.size.y);
		rotate(-radians(rotation));
		translate(-position.x, -position.y);  
	}

}

public class Text extends Drawable {

	FloatVector positionOffset;
	float size;
	String text;
	color textColor;

	public Text (FloatVector positionOffset, float size, String text, color textColor) {
		this.positionOffset = positionOffset;
		this.size = size;
		this.text = text;
		this.textColor = textColor;
	}

	public void draw(FloatVector position, float rotation, float scalar) {
		translate(position.x, position.y);
		rotate(radians(rotation));
		textSize(this.size * scalar);
		textAlign(CENTER, CENTER);
		fill(this.textColor);
		text(this.text, scalar * this.positionOffset.x, scalar * this.positionOffset.y);
		rotate(-radians(rotation));
		translate(-position.x, -position.y);
	}
}