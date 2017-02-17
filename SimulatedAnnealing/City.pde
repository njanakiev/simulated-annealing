class City{
  float population;
  float x, y;
  String cityName;
  
  City(String cityName, float lat, float lon, float population){
    // Web Mercator projection
    // https://en.wikipedia.org/wiki/Web_Mercator
    this.x = (1/PI)*((PI*lon/180) + PI);
    this.y = (1/PI)*(PI - log(tan(PI/4 + (PI*lat/180)/2)));
    this.population = population;
    this.cityName = cityName;
  }
  
  float distanceTo(City city){
    float xDistance = abs(x - city.x);
    float yDistance = abs(y - city.y);
    float distance = sqrt((xDistance*xDistance) + (yDistance*yDistance));
    return distance;
  }
}