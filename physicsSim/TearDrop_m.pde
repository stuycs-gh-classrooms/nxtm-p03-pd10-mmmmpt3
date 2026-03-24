class teardrop extends Orb { 
  
  teardrop(float x, float y, float s, float m){
    super( x, y, s, m);
  }
  
  void display(){
    noStroke();
    fill(68, 221, 232);
    ellipse(center.x, center.y, bsize, bsize * 2);
    triangle( center.x - bsize/2, center.y,center.x + bsize/2, center.y, center.x,center.y-bsize);
    fill(0);
} 
}
