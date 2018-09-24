public class MessageList{
	public ArrayList<String> messages;
	public Text name;
	public Rectangle outsideLogWindow, insideLogWindow;
	public FloatVector position;
	public float rotation;
	public float scalar;

	public MessageList (
		Text name, 
		Rectangle outsideLogWindow, 
		Rectangle insideLogWindow, 
		FloatVector position, 
		float rotation, 
		float scalar) {
		this.messages = new ArrayList<String>();
		this.name = name;
		this.outsideLogWindow = outsideLogWindow;
		this.insideLogWindow = insideLogWindow;
		this.position = position;
		this.rotation = rotation;
		this.scalar = scalar;
	}

	public void draw() {
		this.outsideLogWindow.draw(this.position, this.rotation, this.scalar);
		this.insideLogWindow.draw(this.position, this.rotation, this.scalar);
		this.name.draw(this.position, this.rotation, this.scalar);
		this.draw_messages();
	}
	
	public void draw_messages() {
		translate(position.x, position.y);
		rotate(radians(rotation));
		textSize(13.9 * scalar);
		textAlign(LEFT, CENTER);
		fill(color(0, 0, 0));

		int i = 0;
		for (ListIterator iterator = this.messages.listIterator(this.messages.size()); iterator.hasPrevious(); i++) {
			final String message = (String) iterator.previous();
		    text(message, scalar * (i * 0.0 + -187.0), scalar * (i * -22.6 + 330.4));
		    if(i == 28)
		    	break;
		}
		rotate(-radians(rotation));
		translate(-position.x, -position.y);
	}

	public void add_message(String message) {
		this.messages.add(message);
	}
}
