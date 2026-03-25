class rectangle extends Orb { 
  
  rectangle (float x, float y, float s, float m){
    super( x, y, s, m);
  }
  
  void display(){
    noStroke();
    fill(201, 45, 97);
    rect(center.x, center.y, bsize * 2, bsize );
    fill(0);
} 

void dragForceBounce(){
  if (center.y > 600 - bsize) {
      velocity.y *= -1;
      //center.y = height - bsize/2;

      
    }//bottom bounce
    else if (center.y < 100 + bsize/2) {
      velocity.y*= -1;
      //center.y = bsize/2;
    }
    
    if (center.x > width - bsize * 2 - 20) {
      //center.x = width - bsize/2;
      velocity.x *= -1;
     
    } else if (center.x < 20 + bsize) {
      //center.x = bsize/2;
      velocity.x *= -1;
     
    }
}
}
