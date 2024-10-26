// hedfo001 - had issues with filling the circle and getting it to stay. Oftentimes (in previous tries) it would flash when the mouse was clicked
// and never stayed. I have tried making helper functions, putting it in draw, and putting it in the mouse click function. No luck.
// i added print statements to track and it seems like the method is working to add and find the next node, but it isn't showing on the screen.

// now only one has showed up, but collision handling is not updating.

Particle[] particles = new Particle[2];
ObstacleNode obstacleList;
ObstacleNode obs = new ObstacleNode(new Obstacle(0.5,0.5,0.05), null);
ObstacleNode currentNode;

int numP;
int numObs;

void setup() {
  size(500,500);
  ellipseMode(RADIUS);
  
  particles[0] = new Particle(0.0,1.0,0.01);
  particles[0].setVelocity(0.5, 0.0);
}

void draw() {
  background(100,100,100);
  
  for (int i = 0; i < particles.length; i++) {
    if (particles[i] != null) {
      fill(0,0,255);
      circle((int)(particles[i].getX()*width) , (int)(height-particles[i].getY()*height) , (int)(particles[i].getRadius()*width));
      particles[i].handleCollision(obs.getData());
      particles[i].update(0.01); 
    }
  } 
  
  
  if (obs.getNext() == null) {
    fill(0,0,100);
    circle((int)(obs.getData().getX()*width) , (int)(height-obs.getData().getY()*height) , (int)(obs.getData().getRadius()*width));
  } else {
    currentNode = obs.getNext();
    while ( currentNode.getNext() != null) {
      currentNode = currentNode.getNext();
    }
    
    for (int i = 0; i < particles.length; i++) {
      if (particles[i] != null) {
        particles[i].handleCollision(currentNode.getData());
      }
    }   
    
    fillCircle(currentNode);
  } 
  
}

void fillCircle(ObstacleNode obst) {  
  fill(255,0,0);
  circle((int)(obst.getData().getX()) , (int)(obst.getData().getY()) , (int)(obst.getData().getRadius()));
}


void keyPressed() {
  if (key == '+') {
      numP++; // add a particle (counting)
      if (particles.length < numP) { // length of array too short
        Particle[] nParticles = new Particle[particles.length*2]; // double the size
        for (int i=0; i<particles.length ; i++) {
          nParticles[i] = particles[i]; // copy to new
        }
        particles = nParticles; // replace old to new
        for (int i=0; i<particles.length ; i++) {
           if (particles[i] != null) {
             particles[i] = new Particle(0.0,1.0,0.01);
             particles[i].setVelocity(0.1, 0.0);
             break; // fill in the new spot with a new particle.
           }
        }
      }
      else { // there is enough space in the array
        for (int i=0; i<particles.length ; i++) {
           if (particles[i] == null) { // if the spot is empty 
             particles[i] = new Particle(0.0,1.0,0.01);
             particles[i].setVelocity(0.1, 0.0);
             break; // fill in the new spot with a new particle.
           }
        }
      } 
  }
  if (key == '-') {
      numP--; // remove a particle (counting)
      particles[numP] = null; 
  }
}

void mousePressed() {
  ObstacleNode newObs = new ObstacleNode(new Obstacle(mouseX , mouseY, 50), null);

  if (obs.getNext() == null) {
    numObs++;
    
    obs.setNext(newObs);
    System.out.println("first " + newObs.getData());
  } else {
    numObs++;
    ObstacleNode currentNode = obs.getNext();

    while ( currentNode.getNext() != null) {
      currentNode = currentNode.getNext();
    }
    currentNode.setNext(newObs);

    System.out.println(numObs + " obstacles " + newObs.getData());
  }
  
  // circles diseapear immediately
  // fill(255,0,0);
  // circle((int)(newObs.getData().getX()) , (int)(newObs.getData().getY()) , (int)(newObs.getData().getRadius()));
  
}
