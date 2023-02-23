class Bar
{
  float x, y; // Bar position
  float w, h; // Bar height and width
  Body body;
  Bar(float x, float y, float h ) {
    this.x = x;
    this.y = y;
    this.w = 30;
    this.h = h;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;  // body defined as Kinematic type for controlling 
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);

    //Define a polygon (this is what we use for a rectangle)
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);

    // Define fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;

    //Parameters that effect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    // Attach Fixture to Body
    body.createFixture(fd);

    body.setUserData(this); //track body data for collision handling
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    fill(52, 181, 51);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
  
  //methhd for increasing the velocity over time 
  void changeVelocity(Vec2 vec)
  {
    body.setLinearVelocity(vec);   
  }
  
  //method for stop the bar after the collision with ball
  void change() {
    body.setLinearVelocity(new Vec2(0, 0));
  }
}
