class rectangle extends Orb { 
  
  rectangle (float x, float y, float s, float m){
    super( x, y, s, m);
  }
  
  void display(){
    noStroke();
    fill(201, 45, 97);
    rect(center.x, center.y, bsize, bsize * 2);
    fill(0);
} 
}
