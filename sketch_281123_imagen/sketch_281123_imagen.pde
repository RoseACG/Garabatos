PImage img;

import oscP5.*;
import netP5.*;

OscP5 oscP5;

void setup(){
  size(1000,500);
  //cargar imagen
  img = loadImage("Garabatos2.jpg");
  
  //Cargar los pixeles de la imagen en un array que se llama pixels[]
  //necesaria para poder acceder y manipular INDIVIDUALMENTE los pixeles de una imagen
  img.loadPixels(); 
  
  // Si la imagen se carga correctamente, imprime un mensaje
  if (img != null) {
    println("lo he conseguido!!!");
  } else {
    println("ERROR al cargar la imagen");
  }
  
   //escalar imagen
   //poner antes de mostrar la imagen, para que salga con las coordenadas determinadas
  img.resize(1000,500);
  
  
  
  //crear un objeto osc para poder comunicar con MAX
  OscProperties properties = new OscProperties();
  
  //definir la direccion ip y el puerto por donde estoy escuchando
  properties.setRemoteAddress("127.0.0.1",12000);
  properties.setListeningPort(12000);
  
  //Same recieve same port en el caso de que se use el mismo
  //port para enviar como para recivir
  properties.setSRSP(OscProperties.ON);
  
  //inicial oscP5 con las configuraciones de antes
  oscP5 = new OscP5(this,properties);
  
  //imprimir las propiedades hechas
  println(properties.toString());
}


void draw(){
  background(255);
  
  
  //Para reconocer los pixeles de la imagen se necesita función for
  //un bucle de lógica que va de columna en columns(x) o fila(y)
  //for para navegar posiciones / if para declarar condiciones
  //int loc se usa para poner la posicion en coordenadas de un pixel, dentro del array pixels[]
  //este array se crea automaticamente con esta libreria
  //y al llamar a loadPixels();
  
  /*
  for(int x=0; x<img.width; x++){
    for(int y=0; y<img.height; y++){
      int loc = x+y * img.width; // calcula posición en array
      
      //obtener el color del pixel actual
      color pixelColor = img.pixels[loc];//definir color dentro de libreria del pixen en la posición [loc]
      
      //imprimir el color del color actual
      if(mousePressed){
        println("Color del pixel en posición (" + x+ "," + y +"):" + hex(pixelColor));
      }
 
      // Separa los componentes RGB
      float r = red(pixelColor);
      float g = green(pixelColor);
      float b = blue(pixelColor);
      
      
      //actualiza el color del pixel con las modificaciones
      img.pixels[loc] = color(r,g,b);
    }
  }
  */
  
  
  println("no color"); //fuera del bucle for para que no imprima para todos los pixels
  
  img.updatePixels();
  

  //mostrar imagen
  image(img,0,0);
 
  delay(500);
  //boton arduino.
  
  

}

void keyPressed(){
  //comprobar que la tecla presionada es c
  if(key == 'c' || key == 'C'){
    
     int pixelColor = get(mouseX, mouseY);
     
     //extrae los componentes rgb
     float r = red(pixelColor);
     float g = green(pixelColor);
     float b = blue(pixelColor);
     
     
     //muestra el color en consola
     println("color en la posición del cursor:" +r + g + b);
    
  }
  
  if(key == 'p' || key == 'P'){
    filter(INVERT);
  
  }
}


void oscEvent(OscMessage theOscMessage){
  //aqui llegan los mensajes del osc
  
  print("recieved an osc message");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  
  
  if(key == 'p' || key == 'P'){
    filter(INVERT);
  }
  
  
  
}
