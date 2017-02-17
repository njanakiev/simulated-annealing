ArrayList<City> cities;
boolean testing = false;
String logFilePath = "log.txt";
boolean animate = true;
Path path;
Algorithm algorithm;

void setup(){
  size(500, 500);
  frameRate(1000);
  stroke(0);
  strokeWeight(1.5);
  fill(0);
  
  if(testing){
    cities = randomCities(10);
  }else{
    // City data from: https://www.maxmind.com/en/free-world-cities-database  
    try{
      cities = loadCities("data\\worldcitiespop.txt", "fr", 120000);
    }catch(IOException e){
      e.printStackTrace();
      exit();
    }
  }
  path = new Path(cities);
  normalizeCities(cities);
  algorithm = new Algorithm(path);
}

void keyPressed(){
  switch(key){
    case ' ': 
      algorithm.next();
      background(255);
      algorithm.drawPath();
      break;
  }
}

void draw(){
  if(animate){
    if(algorithm.next()){
      background(255);
      algorithm.drawPath();
      saveFrame("frames/#####.png");
    }
    if(algorithm.temperature < 1){
      noLoop();
    }
  }
}