String comNummer = "COM3";

Pensel pensel;
ArduinoKontroller kontroller;

void setup() {

  //lag vindu
  size(500, 500);
  background(0);

  kontroller = new ArduinoKontroller(this, comNummer, 9600);

  //Få tilstanden til kontrollen når den starter opp
  //(potensiometerne er ofte allerede vridd litt på)
  float[] kontrollTilstand = kontroller.faaInput();
  pensel = new Pensel(kontrollTilstand[0], kontrollTilstand[1]);

}
void draw() {

  //Les input
  float[] input = kontroller.faaInput();

  pensel.tegn(input[0], input[1]);
  sjekkKnapp(input[2]);

}

void sjekkKnapp(float input) {
  if (input == 1) {
    background(0);
  }
}