public class DNA {
    PVector[] genes;
    
    public DNA(int lifespan) {
        genes = new PVector[lifespan];
        for (int i = 0; i < lifespan; i++) {
            genes[i] = PVector.random2D();
            genes[i].setMag(0.2);
        }
    }
    
    public DNA(PVector[] genes_) {
        genes = genes_;
    }
    
    public DNA crossover(DNA partner) {
        PVector[] newdna = new PVector[genes.length];
        
        for (int i = 0; i < genes.length; i++) {
            if (random(1) < 0.5) {
                newdna[i] = genes[i];
            }
            else {
                newdna[i] = partner.genes[i];
            }
        }
        
        return new DNA(newdna);
    }
}
