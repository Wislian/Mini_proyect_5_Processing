private static final int MIN_DANCEABILITY = 23;
private static final int MAX_DANCEABILITY = 96;
private static final int MIN_VALANCE = 4;
private static final int MAX_VALANCE = 97;
private static final int MIN_SPEECHINESS = 3;
private static final int MAX_SPEECHINESS = 97;
private static final int MIN_ENERGY = 14;
private static final int MAX_ENERGY = 97;
private static final int MIN_BPM = 65;
private static final int MAX_BPM = 206;


Song newSong(){
  Song song = getRandomSongFromTable(table);
  return song;
}

void printSong(){
  Song randomSong = getRandomSongFromTable(table);
  randomSong.display();
}


Song getRandomSongFromTable(Table table){
  int totalRows = table.getRowCount();
  int randomRowIndex = (int)random(totalRows);
  TableRow randomRow = table.getRow(randomRowIndex);
  
  Song randomSong = new Song();
  randomSong.load(randomRow);
  return randomSong;
}

class Song {
  String trackName;
  String artistName;
  int artistCount;
  int releasedYear;
  int releasedMonth;
  int releasedDay;
  int streams;
  float danceability;
  float valence;
  float energy;
  float bpm;
  float liveness;
  float speechiness;
  int colorValues[];
  float frequencyValues[];
  int wave;
  float volumen;
  float velocity;
  boolean released;
  // Método para cargar datos de una fila del CSV
  void load(TableRow row) {
    trackName = row.getString("track_name");
    artistName = row.getString("artist(s)_name");
    String[] artists = split(artistName, ",");
    artistName = trim(artists[0]);
    artistCount = row.getInt("artist_count");
    releasedYear = row.getInt("released_year");
    releasedMonth = row.getInt("released_month");
    releasedDay = row.getInt("released_day");
    streams = row.getInt("streams");
    streams = streams/1000;
    bpm = row.getInt("bpm");
    energy = row.getFloat("energy_%");   
    danceability = row.getFloat("danceability_%");
    valence = row.getFloat("valence_%");
    speechiness = row.getFloat("speechiness_%");
    frequencyValues = calculateFrequency(valence, speechiness);
    colorValues = calculateColor(danceability);
    wave = 1;
    volumen = calculateVolumen(energy);
    velocity = calculateVelocity(bpm);
    released = false;
  }

  void display() {
    println("Track Name: " + trackName);
    println("Artist Name: " + artistName);
    println("Artist Count: " + artistCount);
    println("Released: " + releasedYear + "-" + releasedMonth + "-" + releasedDay);
    println("Streams: " + streams);
    println("Danceability: " + danceability + "%");
    println("Valence: " + valence + "%");
    println("Energy: " + energy + "%");
    println("Liveness: " + liveness + "%");
    println("Speechiness: " + speechiness + "%");
    println("-------------------------------");
  }
  int waveCompare(Song song_2){
    int result = 1;
    if (this.wave == song_2.wave){
      if (this.streams >= song_2.streams){
         result = int(random(2,4));
      } else{
        this.wave = int(random(2,4));
      }
    }
    return result;
  }
  boolean dateCompare(Song song_2) {
    if (this.releasedYear > song_2.releasedYear) {
        return true;
    } else if (this.releasedYear < song_2.releasedYear) {
        return false;
    }

    // Years are equal, compare months
    if (this.releasedMonth > song_2.releasedMonth) {
        return true;
    } else if (this.releasedMonth < song_2.releasedMonth) {
        return false;
    }

    // Years and months are equal, compare days
    return this.releasedDay > song_2.releasedDay;
}

  
}



  
  
float scaleValue(float value, float inMin, float inMax, float outMin, float outMax) {
    return outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin);
}

float[] calculateFrequency(float valance, float speechiness) {
    float minFreq = scaleValue(valance, MIN_VALANCE, MAX_VALANCE, 0, 127); 
    float maxFreq = scaleValue(speechiness, MIN_SPEECHINESS, MAX_SPEECHINESS, 0, 127);  

    // Limitar los valores de frecuencia dentro del rango de 0 a 127
    minFreq = max(0, min(minFreq, 127));
    maxFreq = max(0, min(maxFreq, 127));
    if (minFreq == maxFreq){
      minFreq = 0;
    }else if(minFreq > maxFreq){
      float temp = minFreq;
      minFreq = maxFreq;
      maxFreq = temp;
    }
    return new float[] {minFreq, maxFreq}; 
}

int[] calculateColor(float danceability) {
    int r = (int) scaleValue(danceability, MIN_DANCEABILITY, MAX_DANCEABILITY, 50, 255);
    int g = (int) scaleValue(danceability, MIN_DANCEABILITY, MAX_DANCEABILITY, 100, 200);
    int b = (int) scaleValue(danceability, MIN_DANCEABILITY, MAX_DANCEABILITY, 150, 255);
    return new int[] {r, g, b};
}


float calculateVelocity(float bpm) {
    return scaleValue(bpm, MIN_BPM, MAX_BPM, 0.5, 1);
}


float calculateVolumen(float energy) {
    return scaleValue(energy, MIN_ENERGY, MAX_ENERGY, 0.0, 1.0);
}
