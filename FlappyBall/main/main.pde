import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

ArrayList<Bar> bars;  // Array List for bar Object
Ball ball;       
Boundary upperB, lowerB;
boolean halt,openStage; // "halt" variable is declared to stop running the game and "openstage" to control the showing of initial screen

int savedTime; //variable for calculating interval of bar
float totalTime; // variable for interval of bar generating

PImage backDrop, oBackDrop; // for background

void setup() {
  size(800, 500);
  initialize(); //intialize the initial state of program 
  openStage = true; //openstage true at the begining of the program to show the opening screen
}

//method for initialize the game
void initialize()
{
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  savedTime = millis();
  bars = new ArrayList<Bar>();
  ball = new Ball(300, 250);
  upperB = new Boundary(0, 0, 800, 0);
  lowerB = new Boundary(0, 414, 800, 414);
  halt = true;
  backDrop = loadImage("background.jpg");
  oBackDrop = loadImage("Opening.png");
  totalTime = 2000;
}

void draw() {
  box2d.step();
  if(openStage) 
  {
    background(oBackDrop);
    showInitialDialouge();  // show the info of game interaction
  }
  if(!halt){
    background(backDrop);
    runGame();
  }
}

void runGame() {
  int passedTime = millis() - savedTime;   // calculating the interval time of bar generating
  float velocity = 10;  // initial velocity of Bar
  if (passedTime > totalTime)
  {
    float ran1 = random(0.2, 0.5);  // calculating bar height randomly
    bars.add(new Bar(900, (height*ran1)/2, height*ran1));
    bars.add(new Bar(900, height-(height*(0.8-ran1-0.15))/2-1 -86, height*(0.8-ran1-0.15)));
    savedTime = millis();
    totalTime = totalTime - (totalTime*0.04); // acclerating bar generationg time as over time bar velocity is increasing
  }
  for (int i=0; i<bars.size(); i++) {
    Bar b = bars.get(i);
    if(i%2==0) velocity = velocity + (velocity*0.05);  // target to keep upper and lower bar at same speed
    b.changeVelocity(new Vec2(-velocity, 0)); //change velocity
    b.display();
  }
  ball.display();
  upperB.display();
  lowerB.display();
  showScore(); // showing score
}

//method for showing score 
void showScore()
{
  fill(0);
  text("Score:", 50, 470);
  text(""+bars.size(), 110, 470);
  
}

void keyPressed() {

  if (keyCode == 32 && !halt) {  // keycode 32 is for space
    ball.setGravity();   // set gravity 
    ball.applyForce(new Vec2(0, 60)); //apply force for flying the ball
  }

  if (keyCode == 83) { //keycode 83 for S
    halt = false;      // make halt false for run the game
    openStage = false;
  }
}

//collision handling
void beginContact(Contact cp) {

  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();

  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1 instanceof Bar && o2 instanceof Ball) {
    stopGame((Ball) o2); //stop game
  }
  if (o1 instanceof Boundary && o2 instanceof Ball) {
    stopGame((Ball) o2); //stop game
  }
}

void endContact(Contact cp) {
}

// method for stop the game [freezing ball, freezing bar, show end dialouge]
void stopGame(Ball ball) {
  ball.change();
  halt = true;
  for (Bar b : bars) {
    b.change();
  }
  initialize();
  showGameOverDialouge();
}

//method for show initial dialouge
void showInitialDialouge() {
  fill(1,67,75);
  noStroke();
  rect(width/2-200, height/2-180, 400, 250);
  //textAlign(CENTER);
  fill(255);
  textSize(20);
  text("Press 'S' or 's' to start", 220, 150);
  text("Press 'Spacebar' to make the ball fly", 220, 190);
}

//method for show initial dialouge
void showGameOverDialouge() {
  fill(1,67,75,80);
  noStroke();
  rect(350,180 , 380,200);
  //textAlign(CENTER);
  fill(255);
  textSize(20);
  text("Press 'S' or 's' to restart", 220, 150);
  text("Press 'Spacebar' to make the ball fly", 220, 190);
}
