public class Pensel {
  
  private float posX;
  private float posY;
  
  public Pensel(float posX, float posY) {
    this.posX = posX;
    this.posY = posY;
  }
  
  public void tegn(float nyPosX, float nyPosY) {
    stroke(255);
    line(posX, posY, nyPosX, nyPosY);
    posX = nyPosX;
    posY = nyPosY;
  }
}