public class Particle {
  private double x;
  private double y;
  private double radius;
  private double velocityX;
  private double velocityY;
  private double gravity;

  public Particle(double xPos, double yPos, double r) {
    this.x = xPos;
    this.y = yPos;
    this.radius = r;
    velocityX = 0.0;
    velocityY = 0.0;
    gravity = -1.0;
  }

  // getters

  public double getX() {
    return x;
  }

  public double getY() {
    return y;
  }

  public double getRadius() {
    return radius;
  }

  public double getVelocityX() {
    return velocityX;
  }

  public double getVelocityY() {
    return velocityY;
  }

  public double getGravity() {
    return gravity;
  }

  // setters

  public void setX(double xPos) {
    this.x = xPos;
  }

  public void setY(double yPos) {
    this.y = yPos;
  }

  public void setRadius(double r) {
    if (r > 0) {
      this.radius = r;
    } else {
      System.out.println("Radius must be positive");
    }
  }

  public void setVelocity(double vx, double vy) {
    velocityX = vx;
    velocityY = vy;
  }

  public void setGravity(double g) {
    this.gravity = g;
  }

  // methods

  public void update(double dt) {
    // velocity = velocity + acceleration*dt
    velocityY = velocityY + gravity * dt;

    // position = position + velocity*dt
    x = x + velocityX * dt;
    y = y + velocityY * dt;

    // if the particle hits the floor (when y value is at the radius - means the
    // particle's edge hits the floor.)
    if (y <= radius) {
      // correction
      y = radius;

      // bounce it back up (switch the y direction)
      velocityY = -0.8 * velocityY;
    }

  }

  public void handleCollision(Obstacle obstacle) {
    if (obstacle.checkCollision(this)) {
      double[] normal = obstacle.collide(this);

      // bounce (reflect)
      // if velocity is too small to bounce, bounce anyways
      if (Vector2DMath.magnitude(velocityX, velocityY) < 0.2) {
        velocityX = normal[0] * 0.5;
        velocityY = normal[1] * 0.5;
      } else {
        // otherwise just reflect
        double[] reflect = Vector2DMath.reflect(normal, velocityX, velocityY);
        velocityX = reflect[0] * 0.5;
        velocityY = reflect[1] * 0.5;
      }

    }
  }

}
