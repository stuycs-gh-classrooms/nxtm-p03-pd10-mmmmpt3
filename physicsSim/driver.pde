int MOVING = 0;
int BOUNCE = 1;
int GRAV = 2;
int SPRING = 3;
int WINDTUNNEL = 4;
int COMBO = 5;
int HOUSEPARTY = 6;
boolean[] toggles = new boolean[7];


FixedOrb sun;
Orb[] planets;
int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;


void setup() {
  size(800, 800);
  for (int i = 0; i < toggles.length; i++) {
    toggles[i] = false;
  }
}

void draw() {
  runStart();
  if (toggles[GRAV]) {
    runGravity();
  }
}

void runStart() {
  background(184, 211, 255);
  textSize(50);
  text("A Variety of Physics Simulations", 70, 80);
  textSize(30);
  text("Controls:", 150, 150);
  text("Press 1 for Simulation 1, Gravity", 150, 200);
  text("Press 2 for Simulation 2, Spring", 150, 250);
  text("Press 3 for Simulation 3, Drag", 150, 300);
  text("Press 4 for Simulation 4, Combination", 150, 350);
  text("Press 5 for the House Party Simulation", 150, 400);
  text("Press Space to toggle movement on/off", 150, 450);
  text("Press B to toggle bounce on/off", 150, 500);
}

void keyPressed() {
  if (key == '1') {
    toggles[2] = !toggles[2];
  }
  if (key == '2') {
    toggles[3] = !toggles[3];
  }
  if (key == '3') {
    toggles[4] = !toggles[4];
  }
  if (key == '4') {
    toggles[5] = !toggles[5];
  }
  if (key == '5') {
    toggles[6] = !toggles[6];
  }
  if (key == ' ') {
    toggles[0] = !toggles[0];
  }
}

void runGravity() {
  background(0);
  sun = new FixedOrb(width/2, height/2, 35, 200, 255, 171, 0);//mass of sun == 200
  sun.display();

  planets = new Orb[8];
  planets[0] = new Orb(width/2 + 30, height/2, 2, 0.000034); //Mercury
  planets[0].setColor(169, 169, 169);
  planets[1] = new Orb(width/2 + 50, height/2, 5, 0.00048); // Venus
  planets[1].setColor(255, 223, 196);
  planets[2] = new Orb(width/2 + 70, height/2, 6, 0.0006);   // Earth
  planets[2].setColor(100, 149, 237);
  planets[3] = new Orb(width/2 + 90, height/2, 5, 0.000064); // Mars
  planets[3].setColor(188, 39, 50);
  planets[4] = new Orb(width/2 + 130, height/2, 15, 0.19);    // Jupiter
  planets[4].setColor(210, 180, 140);
  planets[5] = new Orb(width/2 + 170, height/2, 12, 0.056);    // Saturn
  planets[5].setColor(218, 165, 32);
  planets[6] = new Orb(width/2 + 210, height/2, 8, 0.0088);   // Uranus
  planets[6].setColor(175, 238, 238);
  planets[7] = new Orb(width/2 + 250, height/2, 8, 0.0108);   // Neptune
  planets[7].setColor(72, 61, 139);

  for (int i = 0; i < planets.length; i++) {
    if (toggles[0] == true) {
      planets[i].move(false);
    }
    PVector force = planets[i].getGravity(sun, G_CONSTANT);
    planets[i].applyForce(force);

    planets[i].display();
  }

  for (int i = 0; i < planets.length; i++) {
    float r = planets[i].center.dist(sun.center);
    float v = sqrt(G_CONSTANT * sun.mass / r);

    // perpendicular velocity
    planets[i].velocity = new PVector(0, -v);
  }
}

void runSpring() {
}

void runDrag() {
}

void runCombo() {
}

void runHouseParty() {
}
