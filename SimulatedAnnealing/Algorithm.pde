class Algorithm{
  float temperature;
  float coolingRate;
  Path currentPath, bestPath;
  
  Algorithm(Path path){
    this.currentPath = path;
    this.bestPath = new Path(path.path);
    temperature = 20000;
    //coolingRate = 0.003;
    coolingRate = 0.0001;
    removeFileIfExists(logFilePath);
  }
  
  boolean next(){
    boolean improvement = false;
    
    // Create new neighbour tour
    Path newSolution = new Path(currentPath.path);
    
    // Get a random positions in the tour
    int pos1 = int(random(newSolution.path.size()));
    int pos2 = int(random(newSolution.path.size()));
    newSolution.swap(pos1, pos2);
    
    // Get energy of solutions
    int currentEnergy = currentPath.getDistance();
    int newEnergy = newSolution.getDistance();
    
    // Decide if we should accept the neighbour
    float p = 1;
    if (newEnergy >= currentEnergy) {
      p = exp((currentEnergy - newEnergy) / temperature);
    }
    if (p > random(1)) {
    //if (p > 0.5) {
        currentPath = new Path(newSolution.path);
    }
    
    // Keep track of the best solution found
    if (currentPath.getDistance() < bestPath.getDistance()) {
        bestPath = new Path(currentPath.path);
        improvement = true;
    }
    
    temperature *= 1 - coolingRate;
    println("Temperature : " + temperature + ", Distance : " + bestPath.getDistance());
    logResult(logFilePath, temperature + "," + p + "," + bestPath.getDistance() + "," + currentPath.getDistance());
    return improvement;
  }
  
  void drawPath(){
    //currentPath.drawPath(150, false);
    bestPath.drawPath(0, true);
  }
}