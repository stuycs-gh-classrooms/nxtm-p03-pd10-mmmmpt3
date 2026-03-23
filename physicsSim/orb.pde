class Orb
{

  //instance variables
  PVector center;
  PVector velocity;
  PVector acceleration;
  float bsize;
  float mass;
  color c;
  ArrayList<Integer> ranking;

  Orb()
  {
    bsize = random(10, MAX_SIZE);
    float x = random(bsize/2, width-bsize/2);
    float y = random(bsize/2, height-bsize/2);
    center = new PVector(x, y);
    mass = random(10, 100);
    velocity = new PVector();
    acceleration = new PVector();
    setColor(255,255,255);
  }


  Orb(float x, float y, float s, float m)
  {
    bsize = s;
    mass = m;
    center = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    setColor(255,255,255);
  }
  
   Orb(float x, float y, float s)
  {
    bsize = s;
    mass = 5;
    center = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    setColor(int(random(84, 255)), int(random(50, 170)), int(random(30,50)));
    ArrayList<Integer> ranking = new ArrayList<Integer>();
    ArrayList<Integer> random10s = new ArrayList<Integer>();
    for (int i = 0; i < random10s.size(); i++){
      random10s.add(i, i);
    }
    for (int i = 0; i < ranking.size(); i++){
      int randomIndex = int(random(0,10));
      ranking.add(i, random10s.get(randomIndex));
      random10s.remove(randomIndex);
    }
      
      
    }
  

  void move(boolean bounce)
  {
    if (bounce) {
      xBounce();
      yBounce();
    }

    velocity.add(acceleration);
    center.add(velocity);
    acceleration.mult(0);
  }//move


  void applyForce(PVector force)
  {
    PVector scaleForce = force.copy();
    scaleForce.div(mass);
    acceleration.add(scaleForce);
  }


  PVector getDragForce(float cd)
  {
    float dragMag = velocity.mag();
    dragMag = -0.5 * dragMag * dragMag * cd;
    PVector dragForce = velocity.copy();
    dragForce.normalize();
    dragForce.mult(dragMag);
    return dragForce;
  }

  PVector getPOF(Orb other, float G){
    float strength = G * mass*other.mass;
    float r = max(center.dist(other.center), MIN_SIZE);
    strength = strength/ pow(r, 2);
    PVector force = other.center.copy();
    force.sub(center);
    force.mult(strength);
    return force;
  }
 
  PVector getGravity(Orb other, float G)
  {
    float strength = G * mass*other.mass;
    //dont want to divide by 0!
    float r = max(center.dist(other.center), MIN_SIZE);
    strength = strength/ pow(r, 2);
    PVector force = other.center.copy();
    force.sub(center);
    force.mult(strength);
    return force;
  }

  PVector getSpring(Orb other, int springLength, float springK)
  {
    PVector direction = PVector.sub(other.center, this.center);
    float distance = direction.mag();
    direction.normalize();
    float force = springK * (distance - springLength);
    direction.mult(force);
    return direction;
  }//getSpring

  boolean yBounce()
  {
    if (center.y > height - bsize/2) {
      velocity.y *= -1;
      center.y = height - bsize/2;

      return true;
    }//bottom bounce
    else if (center.y < bsize/2) {
      velocity.y*= -1;
      center.y = bsize/2;
      return true;
    }
    return false;
  }//yBounce

  boolean xBounce()
  {
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
  }//xbounce

  boolean collisionCheck(Orb other)
  {
    return ( this.center.dist(other.center)
      <= (this.bsize/2 + other.bsize/2) );
  }//collisionCheck


  void setColor(int r, int g, int b)
  {
    c = color(r, g, b);
  }//setColor


  //visual behavior
  void display()
  {
    noStroke();
    fill(c);
    circle(center.x, center.y, bsize);
    fill(0);
    //text(mass, center.x, center.y);
  }//display
}//Ball
