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

Ball lerping_ball = new Ball(200, 200);

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
}

void main_draw() {
	float timeDifference = float(millis() - lerping_ball.milliseconds);
	background(0);
	if(lerping_ball.lerp_status)
	{	
		if(timeDifference <= 2000f) {
			lerping_ball.position = lerping_ball.lerp(timeDifference / 2000f);
		}
		else {
			println("Stopped lerping.");
			lerping_ball.lerp_status = false;
		}

	}
	ellipse(lerping_ball.position.x, lerping_ball.position.y, 10, 10);
    frame++;
}

void mousePressed() {
	println("Lerping to : (" + mouseX + ", " + mouseY + ")");
	lerping_ball.set_lerp(new PVector(lerping_ball.position.x, lerping_ball.position.y), new PVector(mouseX, mouseY));
}

public class Ball{
	public PVector start_vector;
	public PVector finish_vector;
	public PVector position;
	public int milliseconds;
	public boolean lerp_status;

	public Ball(float x0, float y0) {
		this.position = new PVector(x0, y0);
		this.finish_vector = new PVector(0, 0);
		this.lerp_status = false;
	}

	public void set_lerp(PVector start, PVector finish) {
		this.milliseconds = millis();
		this.start_vector = start;
		this.finish_vector = finish;
		this.lerp_status = true;
	}

	public PVector lerp(float t) {
		println(t);
		PVector difference_vector = finish_vector.copy().sub(this.start_vector);
		difference_vector = difference_vector.mult(t);
		return difference_vector.add(this.start_vector);
	}


}

//Autopilot som svänger 3 grader (ÅT HÖGER) varje cykel.