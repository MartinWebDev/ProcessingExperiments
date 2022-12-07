class Particle {
    PVector position;
    PVector velocity;
    PVector acceleration;
    
    int mass;

    public Particle(float x, float y, int objectMass) {
        position = new PVector(x, y);
        velocity = PVector.random2D();

        acceleration = new PVector(0, 0);
        mass = objectMass;
    }

    public void Show() {
        stroke(255);
        strokeWeight(1);
        point(position.x, position.y);
    }
    
    // This is the extended version where velocity will be the sum of all accelleraion forces. They are the center of the screen, and the other particle(s)
    public void Update(ArrayList<Particle> parts) {
        // Add center acelleration first
        acceleration = Attract(new PVector(width / 2, height / 2), 8);
        //acceleration = Attract(new PVector(width / 2, height / 2), 10);
        
        for (Particle p : parts) {
            acceleration.add(Attract(p.position, p.mass));
        }

        velocity.add(acceleration);
        
        velocity.setMag(constrain(velocity.mag(), 0, 3));

        position.add(velocity);
        acceleration.mult(0);

        if (position.x < 0) position.x = width;
        if (position.x > width) position.x = 0;
        if (position.y < 0) position.y = height;
        if (position.y > height) position.y = 0;
    }

    public PVector Attract(PVector attractTo, int m) {
        PVector force = PVector.sub(attractTo, position);   // Calculate direction of force
        float d = force.mag();                              // Distance between objects
        float actualDist = d;
        d = constrain(d, 10, 25.0);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
        force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
        float strength = (/*G*/1 * /*M2*/m * /*M1*/mass) / (d * d);     // Calculate gravitional force magnitude
        force.mult(strength);     // Get force vector --> magnitude * direction
        
        // Repel at close range
        //if (actualDist < 100)
            //force.mult(-1);

        return force;
    }
}