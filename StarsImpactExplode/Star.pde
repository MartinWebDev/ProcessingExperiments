class Star {
    PVector pos;
    PVector[] tail;
    PVector lastPos;
    PVector vel;
    PVector acc;
    
    float mass;
    float life;
    float collisionRadius;
    
    public Star(int x, int y, float m) {
        pos = new PVector(x, y);
        vel = PVector.random2D();
        acc = new PVector(0, 0);
        
        tail = new PVector[5];
        lastPos = pos;
        
        // Initialise tail with all the same to start with to avoid nulls
        for (int i = 0; i < tail.length; i++) {
            tail[i] = pos;
        }
        
        mass = m;
        life = random(400, 800);
        
        collisionRadius = 5;
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
        float strength = (/*G*/0.3 * /*M2*/m * /*M1*/mass) / (d * d);   // Calculate gravitional force magnitude
        force.mult(strength);                                         // Get force vector --> magnitude * direction
        
        return force;
    }
    
    void RepelExplosions(ArrayList<Explosion> expl) {
        for (Explosion exp : expl) {
            PVector dist = PVector.sub(pos, exp.pos);
            if (dist.mag() < exp.r) {
                acc.add(Repel(exp.pos, exp.life / 5));
            }
        }
    }
    
    PVector Repel(PVector repelFrom, float m) {
        PVector force = PVector.sub(repelFrom, pos);                  // Calculate direction of force
        float d = force.mag();                                        // Distance between objects
        d = constrain(d, 10, 25.0);                                   // Limiting the distance to eliminate "extreme" results for very close or very far objects
        force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction)
        float strength = (/*G*/0.3 * /*M2*/m * /*M1*/mass) / (d * d);   // Calculate gravitional force magnitude
        force.mult(-strength);                                         // Get force vector --> magnitude * direction
        
        return force;
    }
    
    boolean IsDead() {
        return life <= 0;
    }
    
    boolean CollidedWith(Star otherStar) {
        PVector distVec = PVector.sub(pos, otherStar.pos);
        return (distVec.mag() < (collisionRadius + otherStar.collisionRadius));
    }
    
    void Update(Blackhole[] bhs, Star[] stars, ArrayList<Explosion> expl) {
        // Get last pos
        lastPos = pos.copy();
        
        // Reset acceleration ready for new calculations
        acc.mult(0);
        // New acceleration calc
        AttractBlackholes(bhs);
        AttractStars(stars);
        RepelExplosions(expl);
        
        // Add acc to vel and update position
        vel.add(acc);
        
        vel.setMag(constrain(vel.mag(), 0, 3));

        pos.add(vel);
        
        // Reduce life
        life--;
    }
    
    void Kill() {
        life = 0;
    }
    
    void Render() {
        stroke(255);
        strokeWeight(1);
        point(pos.x, pos.y);
        
        // Draw and extend tail
        for (int i = tail.length - 2; i >= 0; i--) {
            int a = floor(map(i, 0, tail.length - 1, 255, 100));
            stroke(255, a);
            tail[i + 1] = i == 0 ? lastPos : tail[i];
            point(tail[i].x, tail[i].y);
        }
    }
}