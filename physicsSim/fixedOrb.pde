class FixedOrb extends Orb
{

  FixedOrb(float x, float y, float s, float m, int r, int g, int b)
  {
    super(x, y, s, m);
    c = color(r, g , b);
  }

  FixedOrb()
  {
    super();
   
  }

  void move(boolean bounce)
  {
    //do nothing
  }
}//fixedOrb
