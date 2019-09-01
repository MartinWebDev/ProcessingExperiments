// Start with Dan Shiffman's rocket example as a base. 
Population population;

void setup() {
    size(1000, 800);
    population = new Population();
}

void draw() {
    background(0);
    population.update();
}
