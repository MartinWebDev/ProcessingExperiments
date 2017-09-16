class Star {
    PVector pos;
    PVector vel;
    PVector acc;
    
    float mass;
    float life;
    
    public Star(int x, int y, float m) {
        pos = new PVector(x, y);
        vel = PVector.random2D();
        acc = new PVector(0, 0);
        
        mass = m;
        life = random(200, 400);
    }
    
    void AttractStars(Star[] stars) {
        for (Star s : stars) {
            if (s.pos != pos) {
                acc.add(Attract(s.pos, s.mass));
            }
        }
    }
    
    void AttractBlackholes(Blackhole[] bhs) {
        for (Blackhole b : bhs) {
            acc.add(Attract(b.pos, b.mass));
        }
    }
    
    public PVector Attract(PVector attractTo, float m) {
        PVector force = PVector.sub(attractTo, pos);                  // Calculate direction of force
        float d = force.mag();                                        // Distance between objects
        d = constrain(d, 10, 25.0);                                   // Limiting the distance to eliminate "extreme" results for very close or very far objects
        force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction)
        float strength = (/*G*/1 * /*M2*/m * /*M1*/mass) / (d * d);   // Calculate gravitional force magnitude
        force.mult(strength);                                         // Get force vector --> magnitude * direction
        
        return force;
    }
    
    boolean IsDead() {
        return life <= 0;
    }
    
    void Update(Blackhole[] bhs, Star[] stars) {
        // Reset acceleration ready for new calculations
        acc.mult(0);
        // New acceleration calc
        AttractBlackholes(bhs);
        AttractStars(stars);
        
        // Add acc to vel and update position
        vel.add(acc);
        
        vel.setMag(constrain(vel.mag(), 0, 3));

        pos.add(vel);
        
        // Reduce life
        life--;
    }
    
    void Render() {
        stroke(255);
        strokeWeight(1);
        point(pos.x, pos.y);
    }
}