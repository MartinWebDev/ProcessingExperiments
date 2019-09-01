public class Population {
    int amount = 20;
    Rocket[] rockets;
    int count;
    int lifespan;
    
    Target target;
    
    Wall[] walls;
    
    ArrayList<Rocket> matingPool;
    
    public Population() {
        // Setup variables for simulation
        count = 0;
        lifespan = 800;
        
        // Create rocket population
        rockets = new Rocket[amount];
        createPopulation();
        
        // Target to reach
        target = new Target(new PVector(width / 2, 50));
        
        // Obstacles to fuck 'em up!
        createWalls();
    }
    
    void createPopulation() {
        for (int i = 0; i < rockets.length; i++) {
            rockets[i] = new Rocket(lifespan);
        }
    }
    
    void createWalls() {
        walls = new Wall[7];
        
        // Edges
        walls[0] = new Wall(new PVector(width/2, 0), width, 10); // Top
        walls[1] = new Wall(new PVector(width, height/2), 10, height); // Right
        walls[2] = new Wall(new PVector(width/2, height), width, 10); // Bottom
        walls[3] = new Wall(new PVector(0, height/2), 10, height); // Left
        
        // Random obstacle
        walls[4] = new Wall(new PVector(300, 200), 300, 10);
        walls[5] = new Wall(new PVector(700, 400), 600, 10);
        walls[6] = new Wall(new PVector(300, 600), 600, 10);
    }
    
    void evaluate() {
        // Calculate fitness
        float maxFitness = 0;
        for (Rocket r : rockets) {
            r.calcFitness(target);
            if (r.fitness > maxFitness) maxFitness = r.fitness;
        }
        
        // Normalise fitness
        for (Rocket r : rockets) {
            r.fitness /= maxFitness;
        }
        
        // Mating
        matingPool = new ArrayList<Rocket>();
        for (Rocket r : rockets) {
            // Success fitness boost!
            if (r.complete) r.fitness *= 10;
            
            // Failure fitness punishment!
            // Punish them less the closer they were at time of death
            if (r.dead) r.fitness /= dist(r.pos.x, r.pos.y, target.pos.x, target.pos.y);
            
            float n = r.fitness * 100;
            for (int i = 0; i < n; i++) {
                matingPool.add(r);
            }
        }
    }
    
    public void selection() {
        Rocket[] newPopulation = new Rocket[amount];
        
        for (int i = 0; i < amount; i++) {
            DNA parentA = matingPool.get(floor(random(matingPool.size()))).dna;
            DNA parentB = matingPool.get(floor(random(matingPool.size()))).dna;
        
            DNA child = parentA.crossover(parentB);
            newPopulation[i] = new Rocket(child);
            
            newPopulation[i].dna.genes = mutation(newPopulation[i].dna.genes);
        }
        
        rockets = newPopulation;
    }
    
    public PVector[] mutation(PVector[] genes_) {
        for (int i = 0; i < genes_.length; i++) {
            if (random(1) <= 0.05) {
                genes_[i] = PVector.random2D();
                genes_[i].setMag(0.2);
            }
        }
        
        return genes_;
    }
    
    public void update() {
        for (Rocket r : rockets) {
            r.update(count);
            r.show();
            
            // Check if we reached the target
            if (dist(r.pos.x, r.pos.y, target.pos.x, target.pos.y) <= target.d) r.completed();
            
            // Check if we hit an obstacle (wall)
            if (r.hitWall(walls)) r.died();
        }
        
        count++;
        
        if (count >= lifespan) {
            count = 0;
            evaluate();
            selection();
        }
        
        stroke(255);
        fill(255);
        text(Integer.toString(count), 10, 15);
        text(Float.toString(frameRate), 50, 15);
        
        target.show();
        
        for (int i = 0; i < walls.length; i++) {
            walls[i].show();
        }
    }
}
