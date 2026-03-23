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
Orb[] springs;
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

void GravitySetup(){
   background(0);
  sun = new FixedOrb(width/2, height/2, 35, 200, 255, 171, 0);//mass of sun == 200

  planets = new Orb[8];
  planets[0] = new Orb(width/2 + 30, height/2, 6, 0.000034); //Mercury
  planets[0].setColor(169, 169, 169);
  planets[1] = new Orb(width/2 + 50, height/2, 10, 0.00048); // Venus
  planets[1].setColor(255, 223, 196);
  planets[2] = new Orb(width/2 + 70, height/2, 12, 0.0006);   // Earth
  planets[2].setColor(100, 149, 237);
  planets[3] = new Orb(width/2 + 90, height/2, 10, 0.000064); // Mars
  planets[3].setColor(188, 39, 50);
  planets[4] = new Orb(width/2 + 130, height/2, 30, 0.19);    // Jupiter
  planets[4].setColor(210, 180, 140);
  planets[5] = new Orb(width/2 + 170, height/2, 24, 0.056);    // Saturn
  planets[5].setColor(218, 165, 32);
  planets[6] = new Orb(width/2 + 210, height/2, 16, 0.0088);   // Uranus
  planets[6].setColor(175, 238, 238);
  planets[7] = new Orb(width/2 + 250, height/2, 16, 0.0108);   // Neptune
  planets[7].setColor(72, 61, 139);
  for (int i = 0; i < planets.length; i++) { //this i am so confused abt we need to fix this tomorrow
       float r = planets[i].center.dist(sun.center);
    float v = sqrt(G_CONSTANT * sun.mass / r);
    //planets[i].velocity = new PVector(0, -v);
    // perpendicular velocity
  }
}

void SpringArraySetup(){
  background(255);
  int orbCount = NUM_ORBS;
  springs = new Orb[orbCount];
  for (int i = 0; i < springs.length; i++) {
    int x = int(random(0, width));
    int y= int(random(0, height));

    springs[i] = new Orb( x, y, int(random(MIN_SIZE, MAX_SIZE)), random( MIN_MASS, MAX_MASS));
    springs[i].setColor(int(random(0,256)),int(random(0,256)), int(random(0,256)));
}
}


void draw() {
  if (toggles[GRAV]) { // clear way of organzing the diff toggles
    runGravity();
  }
  if (toggles[SPRING]) {
    runSpring();
  }
  else{  runStart(); 
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
    if(toggles[GRAV]){
      GravitySetup(); //its better to seperate setup from the different runs
    }
  }
  if (key == '2') {
    toggles[3] = !toggles[3];
    if(toggles[SPRING]){
      SpringArraySetup();
    }
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
  background(0); // planets move
    sun.display();
for (int i = 0; i < planets.length; i++) {
    if (toggles[0]) {
      planets[i].move(false);
    }
      
      PVector force = planets[i].getGravity(sun, G_CONSTANT);
       planets[i].applyForce(force);
       planets[i].display();
       
}
}

void runSpring(){ //code copied over from lab
  background(255);
  for(int o = 0; o < springs.length ; o++){ 
    springs[o].display();
  if (toggles[0]) {
      springs[o].move(false);
    }
    if( o > 0){  // cannot check the first  bc there is no orb to attach to it
    PVector SpringForce = springs[o].getSpring(springs[o-1], SPRING_LENGTH,SPRING_K); 
    springs[o].applyForce(SpringForce);
      drawSpring(springs[o-1], springs[o]);
 
  }}
}

void drawSpring(Orb o0, Orb o1)
{
  float distance = o0.center.dist(o1.center); // length of spring
  if(distance == SPRING_LENGTH){
    stroke(0,0,0);
  }
  else if( distance > SPRING_LENGTH){ //stretched
  stroke(255,0,0);
  }
  else{ // compressed
    stroke(0,255,0);
  }
  line(o0.center.x,o0.center.y, o1.center.x , o1.center.y); // draw the line
}


void runDrag() {
}

void runCombo() {
}

void runHouseParty() {
}
