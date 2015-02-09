import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;

void setup() {
  size(640,480,P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  String[] cameras = Capture.list();
  cam=new Capture(this,cameras[0]);
  cam.start();
  nya=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro",80);
  cam.start();
}

void draw()
{
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
  noFill();
  translate(0,0,20);
  sphere(40);
  sphereDetail(3);
  
  fill(0);
  textSize(30);
  text(second(), -15, 0, 20);
  nya.endTransform();
}
