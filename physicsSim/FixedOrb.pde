class FixedOrb extends Orb
{

  /**
   FixedOrb  is a subclass of Orb. Setting the parameters of the class and extending from the functiopns of the master Orb class. 
   
   and/or
   Fixed Orb is an Orb that DOES not move
   */
  FixedOrb(float x, float y, float s, float m)
  {
    super(x, y, s, m);
    c = color(255, 0, 0);
  }

  /**
   This method exists in order to Differentiate the fixed orb from the moving orbs
   */
  FixedOrb()
  {
    super();
    c = color(255, 0, 0); // red
  }

  /**
   As stated by the above discription a fixed orb does not move thus we must override the method in order for their to be no movement. 
   */
  void move(boolean bounce)
  {
    //do nothing
  }
}//fixedOrb
