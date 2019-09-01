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
        
        int mid = floor(random(genes.length));
        for (int i = 0; i < genes.length; i++) {
            if (i > mid) {
                newdna[i] = genes[i];
            }
            else {
                newdna[i] = partner.genes[i];
            }
        }
        
        return new DNA(newdna);
    }
}

//import java.util.*;

//int fuel = 400;
//float maxforce = 0.2;

//public class DNA {
//  PVector[] genes;
  
//  public DNA() {
//    genes = new PVector[fuel];

//    for (int i = 0; i < fuel; i++) {
//      PVector gene = PVector.random2D();
//      gene.setMag(maxforce);        
//      genes[i] = gene;
//    }
//  }

//  DNA(PVector[] genes_) {
//    genes = Arrays.copyOf(genes_, genes_.length);
//  }
  
//  DNA crossover(DNA partner) {
//      PVector[] newgenes = new PVector[genes.length];
      
//      int mid = (int)random(genes.length);
      
//      for (int i = 0; i < genes.length; i++) {
//          if (i > mid) {
//              newgenes[i] = genes[i];
//          }
//          else {
//              newgenes[i] = partner.genes[i];        
//          }
//      }
      
//      // TODO FIX
//      return this;
//  }
//}
