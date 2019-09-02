public class DNA {
    float[] genes;
    
    public DNA(int lifespan) {
        genes = new float[lifespan];
        for (int i = 0; i < lifespan; i++) {
            genes[i] = random(-5, 5);
        }
    }
    
    public DNA(float[] genes_) {
        genes = genes_;
    }
    
    public DNA crossover(DNA partner) {
        float[] newdna = new float[genes.length];
        
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
