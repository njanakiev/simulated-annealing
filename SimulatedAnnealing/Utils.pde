import java.util.Collections;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.File;


ArrayList<City> randomCities(int n){
  ArrayList<City> cities = new ArrayList<City>();
  for(int i=0; i<n; i++){
    float x = random(1);
    float y = random(1);
    int population = int(random(100, 1000));
    cities.add(new City("City", x, y, population));
  }
  return cities;
}

ArrayList<City> loadCities(String filePath, String countryCode, int minPopulation) throws IOException{
  ArrayList<City> cities = new ArrayList<City>();
  int counter = 0;
  
  BufferedReader bufferedReader = createReader(filePath);
  bufferedReader.readLine(); // First line are the names
    
  String line = null;
  String[] splits = null;
  while((line = bufferedReader.readLine()) != null){
    splits = line.split(",");
    int population = 0;
    float latitude = 0, longitude = 0;
      
    try {
      if(splits[4].length() != 0) population = Integer.parseInt(splits[4]);
      if(splits[5].length() != 0) latitude = Float.parseFloat(splits[5]);
      if(splits[6].length() != 0) longitude = Float.parseFloat(splits[6]);
    } catch (NumberFormatException e) {
      e.printStackTrace();
      System.err.println("Strings:" + splits[4] + "," + splits[5] + "," + splits[6]);
    }
      
    if(splits[0].equals(countryCode) && population > minPopulation){
      City city = new City(splits[1], latitude, longitude, population);
      cities.add(city);
      counter++;
    }
  }
  System.out.println("Cities loaded : " + counter);
  bufferedReader.close();
    
  return cities;
}

void normalizeCities(ArrayList<City> path){
  Collections.shuffle(path);
    
  // Determine bounds of data
  City city = path.get(0);
  float minPopulation = city.population;
  float maxPopulation = city.population;
  float minX = city.x, maxX = city.x;
  float minY = city.y, maxY = city.y;
  for (int i=0; i < path.size(); i++) {
    city = path.get(i);
    if(city.x < minX) minX = city.x;
    if(city.x > maxX) maxX = city.x;
    if(city.y < minY) minY = city.y;
    if(city.y > maxY) maxY = city.y;
    if(city.population < minPopulation) minPopulation = city.population;
    if(city.population > maxPopulation) maxPopulation = city.population;
  }
    
  // Normalize data
  for (int i=0; i < path.size(); i++) {
    city = path.get(i);
    city.x = map(city.x, minX, maxX, 0.07*width, 0.85*width);
    city.y = map(city.y, minY, maxY, 0.1*height, 0.9*height);
    city.population = map(city.population, minPopulation, maxPopulation, 0, 1);
  }
}

void removeFileIfExists(String filePath){
  File file = new File(dataPath(filePath));
  file.delete();
}

void logResult(String filePath, String line){
  BufferedWriter output = null;
  try {
    FileWriter fileWriter = new FileWriter(dataPath(filePath), true);
    output = new BufferedWriter(fileWriter); //the true will append the new data
    output.write(line + "\n");
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  finally {
    if (output != null) {
      try {
        output.close();
      } catch (IOException e) {
        println("Error while closing the writer");
      }
    }
  }
}