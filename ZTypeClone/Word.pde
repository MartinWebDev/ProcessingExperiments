class Word {
    private float startX = 0;
    private float letterWidth = 20;
    
    String word;
    ArrayList<Letter> letters;
    
    public Word(String text) {
        // Build word
        word = text;
        String[] allLetters = text.split("");
        
        letters = new ArrayList<Letter>();
        
        for (String l : allLetters) {
            letters.add(new Letter(l));
        }
        
        Letter temp = letters.get(0);
        Letter temp2 = letters.get(1);
        Letter temp3 = letters.get(2);
        temp.kill(); temp2.kill(); temp3.kill();
        
        // Calculate position
        if (letters.size() % 2 == 0) {
            startX = (letters.size() / 2) * letterWidth;
        }
        else {
            startX = ((letters.size() / 2) * letterWidth) + (letterWidth / 2);
        }
    }
    
    void render(PVector pos) {
        pushMatrix();
        textSize(26);
        translate(-startX, 0);
        
        for (int i = 0; i < letters.size(); i++) {
            Letter l = letters.get(i);
            l.render(new PVector(pos.x + (letterWidth * i), pos.y));
        }
        popMatrix();
    }
}
