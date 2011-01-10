#version 3.6;

  //global_settings {
  //  radiosity {
  //    pretrace_start 0.08
  //    pretrace_end   0.04
  //    count 35-20
  //
  //    nearest_count 5-2
  //    error_bound 1.8
  //    recursion_limit 3-1
  //
  //    low_error_factor 0.5
  //    gray_threshold 0.0
  //    minimum_reuse 0.015
  //    brightness 1
  //
  //    adc_bailout 0.01/2
  //  }
  //}


#declare pixel_finish =
  finish {
    ambient rgb <1.0,1.0,1.0>*.3
    brilliance  2.54
    crand       0.000
    diffuse     0.713 - .2
    metallic    0.04 +.3
    phong       0.093
    phong_size  .1000
    specular    0.425
    roughness   0.001


    reflection .05
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
  < 5, 2, 10 >, color rgb <1, 1, 1>*1.
}

light_source {
    <2, 12, -.5>, color rgb <.5, .5, 1> * 1.6

    //<12, 1, -1.5>, color rgb <.05, .8, .05> * .9
}

light_source {
    //<0, 5, -1.5>, color rgb <1, 1, 1> * .8
    <9, 7, -2>, color rgb <1, 1, 1> * 1.0
}


light_source {
  < 5, 10, 10 >, color rgb <1.0, 1.0, 1.0>
  parallel
  point_at <0, 0, 0>
}

<%def name="rounded_corner(radius, scale, depth=0, texture=True)">

union {


box {
    <${-.5 + radius}, ${-.5}, -0.5> , <${+.5 - radius}, ${+.5}, 0.5>

}

box {
    <${-.5}, ${-.5 +radius}, -0.5> , <${+.5}, ${+.5 - radius}, 0.5>


}


cylinder {
    <${-.5 + radius}, ${-.5 + radius}, -0.5> <${-.5 + radius}, ${-.5 + radius}, +0.5> ${radius}
}

cylinder {
    <${-.5 + radius}, ${+.5 - radius}, -0.5> <${-.5 + radius}, ${+.5 - radius}, +0.5> ${radius}
}


cylinder {
    <${+.5 - radius}, ${-.5 + radius}, -0.5> <${+.5 - radius}, ${-.5 + radius}, +0.5> ${radius}
}

cylinder {
    <${+.5 - radius}, ${+.5 - radius}, -0.5> <${+.5 - radius}, ${+.5 - radius}, +0.5> ${radius}
}

    scale <${scale}, ${scale}, ${.4 +depth}>
    translate <0, 0, -.05>

% if texture:
    texture {
        pigment { color  rgb <.6, .6, .6> }

        finish {
          ambient rgb <1.0,1.0,1.0>*.4
          brilliance  2.54
          crand       0.000
          diffuse     0.813
          metallic    0.02
          phong       0.093
          phong_size  .6000
          specular    0.425+.5
          roughness   0.1


          reflection .02 +.02
        }

    }

% endif
    no_shadow

}

</%def>


#declare cutaway = ${rounded_corner(.1, 1.0, depth=.2, texture=False)}


union {

% if has_opacity:
    ${rounded_corner(.1, 1.1)}
% endif



        union {
            % for row in image:
            % for x, y, c in row:
            intersection {
                object { cutaway }
                box {
                    <${x-.500001}, ${y-.500001}, -0.6> , <${x-.5 + image.pixel_x_size+.00001}, ${y-.5 + image.pixel_y_size+.00001}, 0.7>

                    scale <1.0, 1.0, .4>

                }
                texture {

                      pigment { color rgb<${c.r}, ${c.g}, ${c.b}> }
                        finish { pixel_finish }
                }
            }
            % endfor
            % endfor
        }





    no_shadow

}


  //plane { <0, 1, 0>, -1
  //  pigment {
  //    checker color rgb<1, 1, 1>, color rgb<.0, .0, .9>
  //  }
  //  no_image
  //}


//#camera{ Camera0 }

camera {
  perspective
  location <2.173,1.520+1,5.820>*.5
  up y
  right -1.000*x
  angle 22.000
  sky <-0.083,0.971,-0.223>
  look_at < 0, 0, 0 >
}