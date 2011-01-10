#version 3.6;

#declare pixel_finish =
  finish {
    ambient rgb <1.0,1.0,1.0>*.3
    brilliance  2.54
    crand       0.000
    diffuse     0.813
    metallic    0.5
    phong       0.093
    phong_size  .2000
    specular    0.425
    roughness   0.001

    reflection 0
  }

#declare pixel_pigment =
pigment
{
gradient z       //this is the PATTERN_TYPE
      pigment_map {
        [0.0 color <.5, .5, .5>]
        [1.0 color <1, 1, 1>]
      }
      translate<0, 0, -0.5>

}



#declare Camera0 =
camera {
  perspective
  location <2.173,1.520+1,5.820>/2
  up y
  right -1.000*x
  angle 22.000
  sky <-0.083,0.971,-0.223>
  look_at < 0, 0, 0 >
}

light_source {
  < 2, 4, 10 >, color rgb <1, 1, 1>*1.
}

light_source {
    <12, 1, -1.5>, color rgb <.05, .05, .8> * 1.2

    //<12, 1, -1.5>, color rgb <.05, .8, .05> * .9
}

light_source {
    <0, 5, -1.5>, color rgb <.8, .05, .05> * 1.2
    //<0, 5, -1.5>, color rgb <.05, .8, .05> * 1.2
}


light_source {
  < 5, 10, 10 >, color rgb <1.0, 1.0, 1.0>
  parallel
  point_at <0, 0, 0>
}




union {
% for row in image:
% for x, y, c in row:


/*
difference
{

box {
    <${x-.5}, ${y-.5}, -0.5> , <${x-.5 + image.pixel_x_size}, ${y-.5 + image.pixel_y_size}, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <${c.r}, ${c.g}, ${c.b}, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <${x-.500001}, ${y-.500001}, -0.5> , <${x-.5 + image.pixel_x_size+.00001}, ${y-.5 + image.pixel_y_size+.00001}, 0.6>
    texture {
 //       pigment { color rgbft <${c.r}, ${c.g}, ${c.b}, 0, 0> }


      pigment { color rgb<${c.r}, ${c.g}, ${c.b}> }



        //pigment { color rgbft <1, 1, 1, 0, 0> }
        finish { pixel_finish }
    }
    scale <1.0, 1.0, .4>
    no_shadow
}
/*
    no_shadow

}
*/


% endfor
% endfor



}

#camera{ Camera0 }

camera {
  perspective
  location <2.173,1.520+1,5.820>/2
  up y
  right -1.000*x
  angle 22.000
  sky <-0.083,0.971,-0.223>
  look_at < 0, 0, 0 >
}