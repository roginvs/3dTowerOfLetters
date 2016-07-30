content = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG //// THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";
font = "Liberation Sans:style=Bold";
text_total_deep = 3;
text_backplane_deep = 1;
text_height = 7;
text_roof_up = 1;
text_roof_down = 0.5;
text_r = 50;

stand_height = 10;

$fn=100;

_text_x = 6000; //This value must be calculated from actual text object!
_pieces_per_circle = $fn;
_piece_len = 2*PI*text_r/_pieces_per_circle;
_piece_count = floor(_text_x / _piece_len);
_piece_rotate = 360/_pieces_per_circle;
_layers_count = floor(_text_x / (2*PI*text_r));
_render_text=true; //For debug
_stand_picture_deep = 1;
echo("Text layers: ", _layers_count);
echo("Text total height: ",_layers_count * text_height); 
module wrap_text() {
  echo ("Wrapping text");
  translate([0,0,stand_height])
  intersection() {
    translate([-text_r,-text_r,0])
    cube([2*text_r,2*text_r,_layers_count*text_height]);
      
    translate([0,0,(_layers_count-1)*text_height])
   // render()
    union() {
      for (step = [0:_piece_count]) {
        render()     
        rotate(_piece_rotate*step,[0,0,1])
        translate([0,-_piece_len/2,0])
        translate([0,-step*_piece_len,0])
        intersection() {        
          translate([text_r-text_total_deep,0,0])  
          rotate(-asin(text_height/(2*PI*text_r)),[1,0,0]) 
          children();
            
          translate([0,step*_piece_len,0])
          translate([0,0,text_height])
          mirror([0,0,1])          
          cube([text_r,_piece_len,(_layers_count+2)*text_height]);
        }
      };
    };
  };
};

module create_text() { 
  echo ("Creating text in line");
  render() 
  union() {
    cube([text_backplane_deep,_text_x,text_height]);
    translate([text_backplane_deep,0,0])
    union() {    
      if (_render_text) { 
      rotate (90,[0,1,0])
      linear_extrude(height = text_total_deep-text_backplane_deep) {
        rotate(90,[0,0,1])
        text(content, font = font, 
        size = text_height - text_roof_up);
      };
      };
      translate([0,0,text_height - text_roof_up - text_roof_down])
      cube([text_total_deep,_text_x,text_roof_up + text_roof_down]);
    };
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
    scale([0.15,0.15,0.1*_stand_picture_deep])  // 0.15 because of png file    
    surface(file="stand.png", center=true,
    invert=true);
  }
}

union() {
  create_stand();
    
  wrap_text()
    create_text();
}
   
