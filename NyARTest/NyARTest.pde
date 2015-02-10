import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;

void setup() {
  size(640,480,P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  String[] cameras = Capture.list();
  cam=new Capture(this,width,height,"BUFFALO BSW32KM03 USB PC Camera", 30);
  cam.start();
  nya=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro",80);
  cam.start();
}

int c = 0;

void draw()
{
  println(cam.available());
  c++;
  if (cam.available() !=true) {
      return;
  }
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);//frustumを考慮した背景描画
  if((!nya.isExistMarker(0))){
    return;
  }
  nya.beginTransform(0);
  fill(100);
  translate(0,0,20);
  box(40);
  rotate((float)c/100);
  fill(0);
  textSize(30);
  text(second(), -15, -10, 21);
  nya.endTransform();
}
