class Particle {
    PVector position;
    PVector velocity;
    PVector acceleration;

    public Particle(float x, float y) {
        position = new PVector(x, y);
        velocity = PVector.random2D(); //new PVector(1, 0);

        acceleration = new PVector(0, 0);
    }

    public void Show() {
        stroke(255);
        point(position.x, position.y);
    }

    public void Update() {
        // Random acceleration for now
        acceleration = Attract(); //PVector.random2D();

        velocity.add(acceleration);

        position.add(velocity);
        acceleration.mult(0);

        //if (position.x < 0) position.x = width;
        //if (position.x > width) position.x = 0;
        //if (position.y < 0) position.y = height;
        //if (position.y > height) position.y = 0;
    }

    public PVector Attract() {
        //PVector force = PVector.sub(new PVector(mouseX, mouseY), position);   // Calculate direction of force
        PVector force = PVector.sub(new PVector(width / 2, height / 2), position);   // Calculate direction of force
        float d = force.mag();                              // Distance between objects
        d = constrain(d, 10, 25.0);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
        force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
        float strength = (/*G*/1 * /*M2*/5 * /*M1*/2) / (d * d);     // Calculate gravitional force magnitude
        force.mult(strength);     // Get force vector --> magnitude * direction

        return force;
    }
}