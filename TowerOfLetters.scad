content = "ПРИШЛО ВРЕМЯ ПЕРЕУСТАНАВЛИВАТЬ ШINDOWS ШINDOWS САМ НЕ ПЕРЕУСТАНОВИТСЯ ПЕРЕУСТАНОВИ ЕГО ПЕРЕУСТАНОВИ ЕГО ЕЩЕ РАЗ ЗАЧЕМ МНЕ НУЖЕН LINUX У МЕНЯ НЕТ ВРЕМЕНИ ЧТОБЫ ЕБАТЬСЯ С НИМ ЛУЧШЕ ЕЩЕ РАЗ ПЕРЕУСТАНОВИТЬ ШINDOWS Я ПЕРЕУСТАНАВЛИВАЮ ШINDOWS ПО 3 РАЗА В ДЕНЬ КАЖДАЯ ПЕРЕУСТАНОВКА ЗАНИМАЕТ ДВАДЦАДЬ МИНУТ Я ЖИВУ АКТИВНОЙ И ПОЛНОЦЕННОЙ ЖИЗНЬЮ Я УСПЕШЕН И ПОЭТОМУ ЦЕЛЫЙ ДЕНЬ ИГРАЮ В ИГРЫ А ПОСЛЕ ЭТОГО ПЕРЕУСТАНАВЛИВАЮ ШINDOWS ТУПЫЕ ЛИНУКСОИДЫ ОДЕРЖИМЫ КОМПИЛЯЦИЕЙ ВЕДРА А Я СВОБОДНЫЙ ОТ ЗАДРОТСТВО ЧЕЛОВЕК СКОЧАТЬ БЕЗПЛАТНО И БЕЗ РЕГИСТРАЦИИ МОКРЫЕ ПИСЕЧКИ КРЯК УЛЬТИМАТ КЕЙГЕН РАЗБЛОКИРУЙ ВЕНДУ ЛУЧШЕ Я ПЕРЕУСТАНОВЛЮ ЕЩЕ РАЗ ШINDOWS И КРЯКНУ ЕЕ, СТАБИЛЬНОСТЬ НЕ НУЖНАЯ НЕ ПЕРЕУСТАНАВЛИВАЛ ШINDOWS НЕДЕЛЮ ПОЙДУ ПЕРЕУСТАНОВЛЮ В ШINDOWSE ВСЕ ПРОСТО И ПОНЯТНО ААААААААААА ОШИБКА STOP 0x00000001 ЭТО ЖЕ ОЧЕВИДНО КАК ЕЕ РЕШИТЬ ПРИШЛО ВРЕМЯ ПЕРЕУСТАНАВИТЬ ШINDOWS ККОКОКОКОКОКОКО ЖМУ/ПИНУС ШВАБОДКА ПИТУХИ КОКОКОКОКОКОКО КОКОКОКОКОКОКО";
content_spiral_length = 3600;

font = "Liberation Sans:style=Bold";
text_total_deep = 3;
text_backplane_deep = 0;
content_spiral_height = 8;
text_roof_up = 1;
text_roof_down = 0.5;
text_r = 41;

stand_height = 6;


_pieces_per_circle = 100;
_piece_len = 2*PI*text_r/_pieces_per_circle;
_piece_count = floor(content_spiral_length / _piece_len);
_piece_rotate = 360/_pieces_per_circle;
_layers_count = floor(content_spiral_length / (2*PI*text_r));
_stand_picture_deep = 1;

$fa=1;
$fs=0.1;

echo("Text layers: ", _layers_count);
echo("Text total height: ",_layers_count * content_spiral_height); 
module wrap_text() {
  echo ("Wrapping text");
  translate([0,0,stand_height])
  intersection() {
    translate([-text_r,-text_r,0])
    cube([2*text_r,2*text_r,_layers_count*content_spiral_height]);
      
    translate([0,0,(_layers_count-1)*content_spiral_height])
   // render()
    union() {
      for (step = [0:_piece_count]) {
        render()     
        rotate(_piece_rotate*step,[0,0,1])
        translate([0,-_piece_len/2,0])
        translate([0,-step*_piece_len,0])
        intersection() {        
          translate([text_r-text_total_deep,0,0])  
          rotate(-asin(content_spiral_height/(2*PI*text_r)),[1,0,0]) 
          children();
            
          translate([0,step*_piece_len,0])
          translate([0,0,content_spiral_height])
          mirror([0,0,1])          
          cube([text_r,_piece_len,(_layers_count+2)*content_spiral_height]);
        }
      };
    };
  };
};

module create_text_letters() {
    resize([0,content_spiral_length,0])
    rotate (90,[0,1,0])
    linear_extrude(height = text_total_deep-text_backplane_deep) {
      rotate(90,[0,0,1])
      text(content, font = font, 
      size = content_spiral_height - text_roof_up);
    }
}

module create_text() {
  render()
  translate([text_backplane_deep,0,0])
  union() {
    create_text_letters();

    translate([0,0,content_spiral_height - text_roof_up - text_roof_down])
    cube([text_total_deep-text_backplane_deep,content_spiral_length,text_roof_up + text_roof_down]);

    translate([-text_backplane_deep,0,0])
    cube([text_backplane_deep,content_spiral_length,content_spiral_height]);
  };
};

module create_stand() {
  echo ("Creating stand");
  difference() {
    translate([0,0,stand_height/2])
    cylinder(h = stand_height, 
     r1 = text_r, r2 = text_r, center = true);
    
    translate([0,0,stand_height-_stand_picture_deep])
    mirror([0,0,1])
    scale([0.3,0.3,0.01*_stand_picture_deep])  // 0.3 because of png file size=200x200px
    surface(file="fffuuu.png", center=true,
    invert=true);
  }
}


if (true) {  //Change this to false to check letters width
  union() {
    create_stand();

    wrap_text()
      create_text();
  };
} else {
    create_text_letters();
};
