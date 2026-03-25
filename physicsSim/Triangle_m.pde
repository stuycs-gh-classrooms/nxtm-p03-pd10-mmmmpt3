class triangle extends Orb { 
  
  triangle (float x, float y, float s, float m){
    super( x, y, s, m);
  }
  
  void display(){
    noStroke();
    fill(255, 205, 0);
    triangle(center.x, center.y, center.x, center.y + bsize, center.x + bsize/2, center.y + bsize/2);
    fill(0);
} 
}
