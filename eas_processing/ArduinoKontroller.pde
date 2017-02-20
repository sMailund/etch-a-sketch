import processing.serial.*;

public class ArduinoKontroller {
  
  private Serial serialPort; //Serial objekt for å kommunisere med arduino-brettet
  
  public ArduinoKontroller(PApplet parent, String comNummer, int baudRate) {
    serialPort = new Serial(parent, comNummer, baudRate);
  }


  //Feilmelding hvis input ikke kan leses
  private class BadInputException extends Exception {
    public BadInputException(String msg) {
      super(msg);
    }
  }

  public float[] faaInput() {
    while (true) {
      try {
        return lesInput();
      } 
      catch (BadInputException e) {
        println(e.getMessage());
      }
    }
  }

  private float[] lesInput() throws BadInputException {

    //Let etter input helt til noe blir funnet
    if (serialPort.available() > 0) {
      String innData = serialPort.readStringUntil('\n');

      if (innData != null) {
        //Del opp meldingen i mindre biter
        String[] oppdelt = innData.split(" ");

        //sjekk at hele medingen kom gjennom,
        //noen ganger mangler det deler av oppdelt
        if (oppdelt.length == 3) {
          float konvertert[] = konverterStringFloat(oppdelt);
          return konvertert;
        }
      }
    }

    //Kast feilmelding hvis metoden ikke klarer å få input
    throw new BadInputException("Kunne ikke finne input");
  }

  private float[] konverterStringFloat(String[] in) throws BadInputException {
    try {
      float[] ut = new float[in.length];
    for (int i = 0; i < in.length; i++) {
      ut[i] = Float.parseFloat(in[i]);
    }

    ut[0] = map(ut[0], 0, 1023, 0, width);
    ut[1] = map(ut[1], 0, 1023, 0, height);
    return ut;
    } catch (NumberFormatException e) {
      throw new BadInputException("Dårlig forbindelse til kontrollen");
    }
    
  }
}