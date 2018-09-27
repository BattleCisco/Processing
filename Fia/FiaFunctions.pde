int[] getNestStartPosion(Team team) {
	switch (team) {
		case RED:
			return new int[]{0, 0};

		case BLUE:
			return new int[]{9, 0};

		case YELLOW:
			return new int[]{0, 9};

		case GREEN:
			return new int[]{9, 9};

		default:
			println("How the fuck did this happen?");
			return null;
	}
}

color getTeamColor(Team team) {
	switch (team) {
		case RED:
			return color(255, 0, 0);

		case BLUE:
			return color(0, 0, 255);

		case YELLOW:
			return color(255, 255, 0);

		case GREEN:
			return color(0, 255, 0);

		default:
			println("How the fuck did this happen?");
			return color(0, 0, 0);
	}
}

int[] getTeamStarterCoords(Team team) {
	switch (team) {
		case RED:
			return new int[]{0, 4};

		case BLUE:
			return new int[]{6, 0};

		case YELLOW:
			return new int[]{4, 10};

		case GREEN:
			return new int[]{10, 6};

		default:
			println("How the fuck did this happen?");
			return new int[]{5, 5};
	}
}