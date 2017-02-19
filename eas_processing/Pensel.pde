public class Pensel {
  private float str;
  
  private float posX;
  private float posY;
  
  public Pensel(float str, float posX, float posY) {
    this.str = str;
    this.posX = posX;
    this.posY = posY;
  }
  
  public void setPos(float posX, float posY) {
    this.posX = posX;
    this.posY = posY;
  }
  
  public void tegn() {
    fill(255);
    rect(posX, posY, str, str);
  }
}