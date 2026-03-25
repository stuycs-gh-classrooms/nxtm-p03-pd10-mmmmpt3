class Orb {

  // instance variables
  PVector center;
  PVector velocity;
  PVector acceleration;
  float bsize;
  float mass;
  color c;

  int id; // used for house party system
  ArrayList<Integer> ranking;

  // CONSTRUCTORS

  Orb() {
    bsize = random(10, MAX_SIZE);
    float x = random(bsize/2, width - bsize/2);
    float y = random(bsize/2, height - bsize/2);
    center = new PVector(x, y);

    mass = random(10, 100);
    velocity = new PVector();
    acceleration = new PVector();

    setColor(255, 255, 255);
  }

  Orb(float x, float y, float s, float m) {
    bsize = s;
    mass = m;

    center = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();

    setColor(255, 255, 255);
  }

  // HOUSE PARTY CONSTRUCTOR
  Orb(float x, float y, float s) {
    bsize = s;
    mass = 5;

    id = int(random(0, 10)); // unique-ish ID

    center = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();

    setColor(int(random(84, 255)), int(random(50, 170)), int(random(30, 50)));

    // initialize ranking
    ranking = new ArrayList<Integer>();
    ArrayList<Integer> pool = new ArrayList<Integer>();

    // fill pool with 0–9
    for (int i = 0; i < 10; i++) {
      pool.add(i);
    }

    // shuffle into ranking
    for (int i = 0; i < 10; i++) {
      int index = int(random(pool.size()));
      ranking.add(pool.get(index));
      pool.remove(index);
    }
  }

  // PHYSICS

  void move(boolean bounce) {
    float dt = 0.1 * timeScale;
    if (bounce) {
      xBounce();
      yBounce();
    }

    velocity.add(PVector.mult(acceleration, dt));
    center.add(PVector.mult(velocity, dt));
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acceleration.add(f);
  }

  // FORCES

  PVector getDragForce(float cd) {
    float dragMag = velocity.mag();
    dragMag = -0.5 * dragMag * dragMag * cd;

    PVector drag = velocity.copy();
    drag.normalize();
    drag.mult(dragMag);

    return drag;
  }

  // POWER OF FRIENDSHIP
  PVector getPOF(Orb other, float G) {

    float strength = G * mass * other.mass;
    float r = max(center.dist(other.center), MIN_SIZE);
    strength = strength / pow(r, 2);

    PVector force = other.center.copy();
    force.sub(center);
    force.mult(strength);

    //friendship scaling
    int index = other.ranking.indexOf(id);
    float friendship = map(index, 0, 9, -1, 1);
    if (friendship < 0) {
      friendship *= 5;   //strong repulsion
    } else {
      friendship *= 0.4; //weaker attraction
    }
    force.mult(friendship);
    force.normalize();
    //tone down chaos
    force.mult(0.2);

    force.limit(30);
    return force;
  }

  PVector getGravity(Orb other, float G) {
    float strength = G * mass * other.mass;
    float r = max(center.dist(other.center), MIN_SIZE);
    strength = strength / pow(r, 2);

    PVector force = other.center.copy();
    force.sub(center);
    force.normalize();
    force.mult(strength);

    return force;
  }

  PVector getSpring(Orb other, int springLength, float springK) {
    PVector dir = PVector.sub(other.center, this.center);
    float dist = dir.mag();

    dir.normalize();
    float force = springK * (dist - springLength);
    dir.mult(force);

    return dir;
  }


  // COLLISION / BOUNDARY

  boolean yBounce() {
    if (center.y > height - bsize/2) {
      velocity.y *= -1;
      center.y = height - bsize/2;
      return true;
    } else if (center.y < bsize/2) {
      velocity.y *= -1;
      center.y = bsize/2;
      return true;
    }
    return false;
  }

  boolean xBounce() {
    if (center.x > width - bsize/2) {
      center.x = width - bsize/2;
      velocity.x *= -1;
      return true;
    } else if (center.x < bsize/2) {
      center.x = bsize/2;
      velocity.x *= -1;
      return true;
    }
    return false;
  }

  void dragForceBounce() {
    if (center.y > 600 - bsize) {
      velocity.y *= -1;
      //center.y = height - bsize/2;
    }//bottom bounce
    else if (center.y < 100 + bsize/2) {
      velocity.y*= -1;
      //center.y = bsize/2;
    }

    if (center.x > width - bsize/2 - 20) {
      //center.x = width - bsize/2;
      velocity.x *= -1;
    } else if (center.x < 20 + bsize) {
      //center.x = bsize/2;
      velocity.x *= -1;
    }
  }

  boolean collisionCheck(Orb other) {
    return center.dist(other.center) <= (bsize/2 + other.bsize/2);
  }

  // VISUAL

  void setColor(int r, int g, int b) {
    c = color(r, g, b);
  }

  void display() {
    noStroke();
    fill(c);
    circle(center.x, center.y, bsize);
  }
}
