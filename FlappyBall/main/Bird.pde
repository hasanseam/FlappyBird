
//Class for create ball in the world and control it 

class Ball {

  Body body;

  float r;
  boolean stop;
  Ball(float x, float y)
  {
    r = 16;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.gravityScale = 0.0f;
    body = box2d.createBody(bd);



    CircleShape cs = new CircleShape();
    float box2dr = box2d.scalarPixelsToWorld(r/2);
    cs.setRadius(box2dr);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    fd.density = 0.02;
    fd.friction = 0.1;
    fd.restitution = 0.1;

    body.createFixture(fd);

    body.setUserData(this); // track body info for collision handling
  }

  public void applyForce(Vec2 vec) {

    Vec2 bodyCenter  = body.getWorldCenter();
    body.applyForce(vec, bodyCenter);
  }
  
  //method for stop moving ball after collision
  public void change() {
    body.setLinearVelocity(new Vec2(0, 0));
    body.setGravityScale(0.0f);
  }
  
  //set gravity 
  public void setGravity()
  {
    body.setGravityScale(5.0f);
  }

  //method for draw the ball
  public void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255,0,0);
    stroke(0);
    ellipseMode(CENTER);
    ellipse(0, 0, r, r);
    popMatrix();
  }
}
