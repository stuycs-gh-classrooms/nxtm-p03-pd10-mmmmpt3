int MOVING = 0;
int BOUNCE = 1;
int GRAV = 2;
int SPRING = 3;
int WINDTUNNEL = 4;
int COMBO = 5;
int HOUSEPARTY = 6;
float timeScale = 1.0;

boolean[] toggles = new boolean[7];

PVector wind;
PVector gravity;
PVector push;


FixedOrb sun;
Orb[] planets;
Orb[] springs;
Orb[] friends;
Orb test;
FixedOrb [] stars;

int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;

float MIN_MASS = 10;
float MAX_MASS = 100;

float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float SPRING_K = 0.005;

void setup() {
  size(800, 800);

  for (int i = 0; i < toggles.length; i++) {
    toggles[i] = false;
  }
  runStart();
}

void draw() {
  if (toggles[GRAV]) {
    runGravity();
  }
  if (toggles[SPRING]) {
    runSpring();
  }
  if (toggles[WINDTUNNEL]) {
    runWindTunnel();
  }
  if (toggles[HOUSEPARTY]) {
    runHouseParty();
  }
  if (toggles[COMBO]) {
    runCombo();
  }
  drawBoxes();
}

// GRAVITY

void GravitySetup() {
  background(0);
  sun = new FixedOrb(width/2, height/2, 35, 200, 255, 171, 0);
  planets = new Orb[8];
  stars = new FixedOrb[100];

  planets[0] = new Orb(width/2 + 30, height/2, 6, 0.000034);//mercury
  planets[0].setColor(229, 229, 229);
  planets[1] = new Orb(width/2 + 50, height/2, 10, 0.00048);//venus
  planets[1].setColor(248, 226, 176);
  planets[2] = new Orb(width/2 + 70, height/2, 12, 0.0006);//earth
  planets[2].setColor(0, 0, 160);
  planets[3] = new Orb(width/2 + 90, height/2, 10, 0.000064);//mars
  planets[3].setColor(173, 98, 66);
  planets[4] = new Orb(width/2 + 130, height/2, 30, 0.19);//jupiter
  planets[4].setColor(209, 167, 127);
  planets[5] = new Orb(width/2 + 170, height/2, 24, 0.056);//saturn
  planets[5].setColor(252, 238, 173);
  planets[6] = new Orb(width/2 + 210, height/2, 16, 0.0088);//uranus
  planets[6].setColor(172, 229, 238);
  planets[7] = new Orb(width/2 + 250, height/2, 16, 0.0108);//neptune
  planets[7].setColor(124, 183, 187);


  // to orbit something, an object's velocity must be perpendicular to the radius between the sun and the planet
  // this calculates the tangent line every time and uses it as the object's perpendicular velocity.
  for (int i = 0; i < planets.length; i++) {
    float r = planets[i].center.dist(sun.center);
    float v = sqrt(G_CONSTANT * sun.mass / r);
    PVector radius = PVector.sub(planets[i].center, sun.center);
    PVector tangent = new PVector(-radius.y, radius.x);
    tangent.normalize();
    tangent.mult(v);

    planets[i].velocity = tangent;
  }
  for ( int i =0; i < stars.length; i ++) {

    stars[i]= new FixedOrb(int(random(width)),
      int(random(height)), 5, 200, 255, 171, 0);
    stars[i].setColor(255, 255, 255);
  }
}

void runGravity() {
  background(0);
  textSize(30);
  text("use up/down arrow keys to move faster/slower", 20, 40);
  text("CAUTION: you may lose planets", 20, 70);
  sun.display();
  for ( int i =0; i < stars.length; i ++) {
    stars[i].display();
  }
  for (Orb p : planets) {
    if (toggles[MOVING]) p.move(toggles[BOUNCE]);

    PVector force = p.getGravity(sun, G_CONSTANT);
    p.applyForce(force);
    p.display();
  }
}

// SPRING

void SpringArraySetup() {
  background(255);
  springs = new Orb[NUM_ORBS];

  for (int i = 0; i < springs.length; i++) {
    springs[i] = new Orb(
      random(width),
      random(height),
      int(random(MIN_SIZE, MAX_SIZE)),
      random(MIN_MASS, MAX_MASS)
      );
    springs[i].setColor(
      int(random(256)),
      int(random(256)),
      int(random(256))
      );
  }
}

void runSpring() {
  background(255);
  fill(0);
  textSize(20);
  text("use +/- keys to change the spring constant, K", 20, 40);

  for (int i = 0; i < springs.length; i++) {
    springs[i].display();

    if (toggles[MOVING]) {
      springs[i].move(toggles[BOUNCE]);
    }
    if (i > 0) {
      PVector f = springs[i].getSpring(springs[i-1], SPRING_LENGTH, SPRING_K);
      springs[i].applyForce(f);
      drawSpring(springs[i-1], springs[i]);
    }
  }
  PVector f = springs[springs.length -1 ].getSpring(springs[0], SPRING_LENGTH, SPRING_K);
  springs[springs.length -1].applyForce(f);
  springs[0].applyForce(f);
  drawSpring(springs[springs.length -1], springs[0]);
}

// WIND TUNNEL

void windTunnelSetup() {
  wind = new PVector(0.3, 0);
  gravity = new PVector(0, 0.1);
}

void runWindTunnel() {
  background(97);
  noStroke();
  fill(200);
  rect(20, 100, width - 40, 500);

  fill(200);
  rect(20, 620, 520, 60);
  textSize(50);
  text("PRESS SPACE to run simulation", 60, 70);
  text("CHOOSE", 600, 660);
  text("A SHAPE", 600, 720);
  text("TO TEST", 600, 780);
  square(20, 690, 100);
  fill(201, 45, 97);
  rect(45, 700, 50, 80);

  fill(200);
  square(160, 690, 100);
  fill(255, 255, 255);
  circle(210, 740, 60);

  fill(200);
  square(300, 690, 100);
  fill(255, 205, 0);
  triangle(325, 715, 325, 775, 365, 745);

  fill(200);
  square(440, 690, 100);
  fill(68, 221, 232);
  ellipse(490, 740, 40, 80);



  if (test != null) {
    test.display();
    fill(0);
    text(test.velocity.toString(), 20, 665);

    if (toggles[MOVING]) {
      //test.applyForce(gravity);
      test.applyForce(wind);
      test.applyForce(test.getDragForce(D_COEF));
      test.move(false);
      test.dragForceBounce();
    }
  }
}

// COMBINATION

void comboSetup() {
  background(0);

  sun = new FixedOrb(width/2, height/2, 35, 200, 255, 171, 0);

  springs = new Orb[NUM_ORBS];

  for (int i = 0; i < springs.length; i++) {
    float angle = map(i, 0, springs.length, 0, TWO_PI);
    float r = 150;

    float x = width/2 + r * cos(angle);
    float y = height/2 + r * sin(angle);

    springs[i] = new Orb(x, y, random(15, 30), random(20, 50));

    springs[i].setColor(
      int(random(100, 255)),
      int(random(100, 255)),
      int(random(100, 255))
      );

    PVector radius = PVector.sub(springs[i].center, sun.center);
    PVector tangent = new PVector(-radius.y, radius.x);
    tangent.normalize();

    float v = 0.7 * sqrt(G_CONSTANT * sun.mass / r);
    tangent.mult(v);

    springs[i].velocity = tangent;
  }
}

void runCombo() {
  background(0);

  sun.display();

  for (int i = 0; i < springs.length; i++) {

    Orb current = springs[i];

    PVector g = current.getGravity(sun, G_CONSTANT);
    current.applyForce(g);


    Orb next = springs[(i + 1) % springs.length];
    PVector s = current.getSpring(next, SPRING_LENGTH, SPRING_K);
    current.applyForce(s);


    PVector d = current.getDragForce(D_COEF);
    current.applyForce(d);


    if (toggles[MOVING]) {
      current.move(toggles[BOUNCE]);
    }

    current.display();

    //draw spring lines
    drawSpring(current, next);
  }
}

// HOUSE PARTY

void setupHouseParty() {
  friends = new Orb[10];
  for (int i = 0; i < friends.length; i++) {
    friends[i] = new Orb(random(100, 700), random(100, 700), random(30, 50));
    friends[i].velocity = new PVector(random(-2, 2), random(-2, 2));
  }
}

void runHouseParty() {
  background(173, 130, 95);

  float x = width/2 - 40;
  float y = height - 80;

  // cake base
  fill(255, 200, 200);
  rect(x, y, 80, 30);

  // top
  fill(255, 230, 230);
  rect(x + 10, y - 20, 60, 20);

  // candle
  fill(255);
  rect(width/2 - 2, y - 35, 4, 15);

  fill(255, 200, 0);
  ellipse(width/2, y - 40, 6, 8);

  for (int i = 0; i < friends.length; i++) {

    for (int j = 0; j < friends.length; j++) {
      if (i != j) {
        PVector f = friends[i].getPOF(friends[j], G_CONSTANT);
        friends[i].applyForce(f);
      }
    }

    if (toggles[MOVING]) {
      friends[i].move(toggles[BOUNCE]);
    }

    friends[i].display();
  }
}


// KEY CONTROLS

void keyPressed() {

  if (key == '1') {
    toggles[GRAV] = !toggles[GRAV];
    if (toggles[GRAV]) GravitySetup();
  }

  if (key == '2') {
    toggles[SPRING] = !toggles[SPRING];
    if (toggles[SPRING]) SpringArraySetup();
  }
  if (key == '+') {
    SPRING_K += 0.001;
    print(SPRING_K);
  }

  if (key == '-') {
    SPRING_K -= 0.001;
    print(SPRING_K);
  }

  if (key == '3') {
    toggles[WINDTUNNEL] = !toggles[WINDTUNNEL];
    if (toggles[WINDTUNNEL]) windTunnelSetup();
  }

  if (key == '4') {
    toggles[COMBO] = !toggles[COMBO];
    if (toggles[COMBO]) comboSetup();
  }

  if (key == '5') {
    toggles[HOUSEPARTY] = !toggles[HOUSEPARTY];
    if (toggles[HOUSEPARTY]) {
      toggles[MOVING] = true;
      setupHouseParty();
    }
  }

  if (key == ' ') {
    toggles[MOVING] = !toggles[MOVING];
  }

  if (key == 'b' || key == 'B') {
    toggles[BOUNCE] = !toggles[BOUNCE];
  }
  if (keyCode == UP && (toggles[GRAV] || toggles[COMBO])) {
    timeScale *= 1.2;
  }
  if (keyCode == DOWN && (toggles[GRAV] || toggles[COMBO])) {
    timeScale *= 0.8;
  }
}


void mousePressed() {
  if (toggles[WINDTUNNEL]) {
    if (mouseX >= 160 && mouseX <= 260 && mouseY >= 690 && mouseY <= 790) {
      test = new Orb(400, 300, 100, random(MIN_MASS, MAX_MASS));
      D_COEF = .5;
    } else if (mouseX >= 440 && mouseX <= 540 && mouseY >= 690 && mouseY <= 790) {
      test = new teardrop(400, 300, 100, random(MIN_MASS, MAX_MASS));
      D_COEF = .045;
    } else if (mouseX >= 20 && mouseX <= 120 && mouseY >= 690 && mouseY <= 790) {
      test = new rectangle(400, 300, 100, random(MIN_MASS, MAX_MASS));
      D_COEF = .295;
    } else if (mouseX >= 300 && mouseX <= 400 && mouseY >= 690 && mouseY <= 790) {
      test = new triangle(400, 300, 150, random(MIN_MASS, MAX_MASS));
      D_COEF = 1.14;
    }
    if (key == 'b' || key == 'B') { // need rto make a new bounce function just for windtunnel
      test.move(true);
    }
  }
}

// EXTRA FUNCTIONS

void drawSpring(Orb o0, Orb o1) {
  float d = o0.center.dist(o1.center);

  if (d == SPRING_LENGTH) stroke(0);
  else if (d > SPRING_LENGTH) stroke(255, 0, 0);
  else stroke(0, 255, 0);

  line(o0.center.x, o0.center.y, o1.center.x, o1.center.y);
}

void runStart() {
  background(184, 211, 255);
  textSize(90);
  text("Physics Simulations", 30, 80);

  textSize(50);
  text("1: Gravity", 350, 180);
  fill(0);
  square(230, 120, 100);
  fill(249, 215, 28);
  circle( 280, 170, 13);

  fill(248, 226, 176);
  circle( 290, 170, 8);

  fill(0, 0, 160);
  circle( 300, 170, 10);

  fill(173, 98, 66);
  circle( 310, 170, 12);

  fill(209, 167, 127);
  circle( 318, 170, 10);

  text("2: Spring", 350, 280);
  fill(255);
  square(230, 220, 100);
  fill(209, 34, 56);
  circle(255, 300, 30);
  fill(34, 230, 67);
  circle(310, 240, 30);
  fill(0);
  line(245, 300, 310, 240);

  text("3: Wind Tunnel", 350, 380);
  fill(200);
  square(230, 320, 100);

  fill(201, 45, 97);
  rect(240, 340, 20, 30);


  fill(255, 255, 255);
  circle(300, 345, 30);


  fill(255, 205, 0);
  triangle(240, 380, 240, 400, 260, 390);


  fill(68, 221, 232);
  ellipse(300, 395, 20, 40);

  fill(255);
  text("4: Combination", 350, 480);
  square(230, 420, 100);
  fill(0);
  text("?", 270, 490);
  fill(255);
  text("5: House Party", 350, 580);
  square(230, 520, 100);

  float cx = 230;
  float cy = 520;
  fill(255, 200, 200);
  rect(cx + 25, cy + 50, 50, 20);
  fill(255, 230, 230);
  rect(cx + 35, cy + 35, 30, 15);
  fill(255);
  rect(cx + 48, cy + 20, 4, 15);
  fill(255, 200, 0);
  ellipse(cx + 50, cy + 18, 6, 8);
  
  fill(0);
  text( "GENERAL CONTROLS", 170, 690);
  text("Space: Move", 200, 740);
  text("B: Bounce", 520, 740);
}

void drawBoxes() {
  int x = 20;
  int y = height - 80;
  int w = 140;
  int h = 25;
  int spacing = 35;

  textSize(16);
  fill(255);

  if (toggles[MOVING]) {
    fill(0, 200, 0);
  } else {
    fill(200, 0, 0);
  }//moving
  rect(x, y, w, h);

  fill(0);
  text("MOVE (space)", x + 10, y + 18);

  // BOUNCE toggle
  if (toggles[BOUNCE]) {
    fill(0, 200, 0);
  } else {
    fill(200, 0, 0);
  }
  rect(x, y + spacing, w, h);

  fill(0);
  text("BOUNCE (B)", x + 10, y + spacing + 18);
}
