public class CharacterManager {
	public Human[] testSubjects;
	public int amountOfTestSubjects;

	public float secondsPassedBeforeGameOver;

	public CharacterManager (int amountOfTestSubjects) {
		this.amountOfTestSubjects = amountOfTestSubjects;
		this.testSubjects = new Human[amountOfTestSubjects];
		for (int i = 1; i < amountOfTestSubjects; i++) {
			this.testSubjects[i] = new Human(new FloatVector(random(0, width), random(0, height)), 5, random(0, 359), 30.0);
		}
		this.testSubjects[0] = new Zombie(new FloatVector(random(0, width), random(0, height)), 3, random(0, 359), 30.0);
		this.secondsPassedBeforeGameOver = 0.0;
	}

	public void update() {
		for (int i = 0; i < this.testSubjects.length - 1; i++) {
			for (int j = i + 1; j < this.testSubjects.length; j++) {
				if(!(this.testSubjects[i] instanceof Zombie ^ this.testSubjects[j] instanceof Zombie))
				{
					continue;
				}

				if(this.collision(this.testSubjects[i], this.testSubjects[j]))
				{
					println("Collision between " + i + " and " + j);
					//delay(1000);
					if(this.testSubjects[i] instanceof Zombie) {
						this.testSubjects[j] = new Zombie(this.testSubjects[j], 3);
					}
					else {
						this.testSubjects[i] = new Zombie(this.testSubjects[i], 3);
					}
				}
			}
		}

		for (Human ts : testSubjects) {
			if(ts instanceof Zombie)
				ts.update(testSubjects);
			else
				ts.update();
		}
	}

	// public boolean 
	// 	int humans = 0;
	// 	for (Human testSubject : testSubjects) {
	// 		if(!(testSubject instanceof Zombie))
	// 			humans++;
	// 	}
		
	// 	if(humans == 0)
	// 		return;

	// 	float closest=0.0;
	// 	for(Human testSubject : testSubjects) {
	// 		if(!(testSubject instanceof Zombie))
	// 		{
	// 			FloatVector distance_vector = this.position.add(testSubject.position);
	// 			float distance_magnitude = distance_vector.mag();
	// 			if(distance_magnitude > closest)
	// 				this.direction = asin(abs(distance_vector.y)/distance_magnitude);
	// 		}
	// 	}

	public boolean collision(Human h1, Human h2) {
		if(abs(h1.position.x - h2.position.x) > h1.size / 2 + h2.size / 2 || abs(h1.position.y - h2.position.y) >  h1.size / 2 + h2.size / 2)
			return false;


		else if (dist(h1.position.x, h1.position.y, h2.position.x, h2.position.y) > h1.size / 2 + h2.size / 2) {
			return false;
		}
		println("Collision!");

		return true;
	}

	public boolean isGameOver () {
		boolean gameOver = true;
		for(Human ts: this.testSubjects) {
			if(!(ts instanceof Zombie))
				gameOver = false;
		}
		return gameOver;
	}

	public void draw(){
		for (int i = 0; i < amountOfTestSubjects; i++) {
			this.testSubjects[i].draw();
		}
	}

}