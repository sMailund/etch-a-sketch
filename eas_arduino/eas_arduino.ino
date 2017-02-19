//input for potensiometerne
const int pot1 = A0;
const int pot2 = A1;

//input for knapp
const int knapp = 13;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  pinMode(pot1, INPUT);
  pinMode(pot2, INPUT);
  pinMode(knapp, INPUT);
}

void loop() {  
  Serial.println(lagMelding());
}

String lagMelding() {
  String splitter = " "; //Hvilket symbol som skal splitte delene av meldingen

  //Les input fra brettet
  float x = analogRead(pot1);
  float y = analogRead(pot2);
  int knappTrykket = digitalRead(knapp);

  return (x + splitter + y + splitter + knappTrykket);
}

