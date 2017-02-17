class Path{
  ArrayList<City> path = new ArrayList<City>();
  int distance = 0;
  
  Path(ArrayList<City> cities){
    path = (ArrayList) cities.clone();
  }
  
  void drawPath(color c, boolean drawText){
    fill(c);
    stroke(c);
    for (int i=0; i < path.size(); i++) {
      int iNext = (i + 1) % path.size();
      City c0 = path.get(i);
      City c1 = path.get(iNext);
      float r = sqrt(map(c0.population, 0, 1, 50, 300));
      ellipse(c0.x, c0.y, r, r);
      line(c0.x, c0.y, c1.x, c1.y);
      if(drawText){
        textSize(10);
        text(c0.cityName, c0.x + 10, c0.y + 5);
      }
    }
  }
  
  int getDistance(){
    if (distance == 0) {
      // Loop through our tour's cities
      for (int i=0; i < path.size(); i++) {
        // Get city we're traveling from
        City fromCity = path.get(i);
        // City we're traveling to
        City toCity;
        // Check we're not on our tour's last city, if we are set our
        // tour's final destination city to our starting city
        if(i + 1 < path.size()){
          toCity = path.get(i + 1);
        }else{
          toCity = path.get(0);
        }
        // Get the distance between the two cities
        distance += fromCity.distanceTo(toCity);
      }
    }
    return distance;
  }
  
  void swap(int pos1, int pos2){
    City city1 = path.get(pos1);
    City city2 = path.get(pos2);
    path.set(pos2, city1);
    path.set(pos1, city2);
    distance = 0;
  }
}