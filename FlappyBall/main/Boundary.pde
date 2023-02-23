// class for create Upper and lower boundary
class Boundary {
  ArrayList <Vec2> coordinates;

  Boundary(int x1, int y1, int x2, int y2) {

    coordinates = new ArrayList<Vec2>();

    coordinates.add(new Vec2(x1, y1));
    coordinates.add(new Vec2(x2, y2));

    Vec2[] vertices = new Vec2[2];

    vertices[0] = box2d.coordPixelsToWorld(coordinates.get(0));
    vertices[1] = box2d.coordPixelsToWorld(coordinates.get(1));

    ChainShape chain = new ChainShape();
    chain.createChain(vertices, vertices.length);

    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    body.createFixture(chain, 1);
    body.setUserData(this);
  }

  void display() {
    pushMatrix();
    noFill();
    beginShape();
    for (Vec2 v : coordinates) {
      vertex(v.x, v.y);
    }
    endShape();
    popMatrix();
  }
}
