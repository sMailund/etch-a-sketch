import processing.serial.*;

Serial serialPort; //Serial objekt for å kommunisere med arduino-brettet
String innData; //Holder dataen som kommer fra arduino-brettet

Pensel pensel;


void setup() {

  //lag vindu
  size(500, 500);
  background(0);

  //Sett opp for å motta info fra arduino-brettet
  String comNummer = "COM3"; 
  serialPort = new Serial(this, comNummer, 9600);
  
  //Lag pensel
  pensel = new Pensel(0, 0);
}

void draw() {
  
  //Les input
  float[] input;
  try {
      input = lesInput();
  } catch (BadInputException e) {
    println(e.getMessage());
    return;
  }
  
  if (input[2] == 1) {
    slettBilde();
  }
  
  tegnSkjerm(input[0], input[1]);
  
}

void slettBilde() {
  background(0);
}

void tegnSkjerm(float posX, float posY) {
  pensel.tegn(posX, posY);
}

float[] lesInput() throws BadInputException {
  String[] oppdelt;

  //Let etter input helt til noe blir funnet
  for (int i = 0; i < 1000; i++) {
    if (serialPort.available() > 0) {
      innData = serialPort.readStringUntil('\n');

      if (innData != null) {
        //Del opp meldingen i mindre biter
        oppdelt = innData.split(" ");

        //sjekk at hele medingen kom gjennom,
        //noen ganger mangler det deler av oppdelt
        if (oppdelt.length == 3) {
          float konvertert[] = konverterStringFloat(oppdelt);
          println(oppdelt[0] + " | " + oppdelt[1] + " | " + oppdelt[2]);
          return konvertert;
        } else {
          throw new BadInputException("Input mangler deler");
        }
      }
    }
  }
  
  //Kast feilmelding hvis metoden ikke har fått input etter n forsøk
  throw new BadInputException("Kunne ikke finne input");
}

float[] konverterStringFloat(String[] in) {
  float[] ut = new float[in.length];
  for (int i = 0; i < in.length; i++) {
    ut[i] = Float.parseFloat(in[i]);
  }
  
  ut[0] = map(ut[0], 0, 1023, 0, width);
  ut[1] = map(ut[1], 0, 1023, 0, height);
  return ut;
}


//Feilmelding hvis input ikke kan leses
class BadInputException extends Exception {
    public BadInputException(String msg) {
        super(msg);
    }
}