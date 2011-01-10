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


/*
difference
{

box {
    <-0.4375, -0.4375, -0.5> , <-0.375, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.437501, -0.437501, -0.5> , <-0.37499, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.375, -0.4375, -0.5> , <-0.3125, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, -0.437501, -0.5> , <-0.31249, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.3125, -0.4375, -0.5> , <-0.25, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, -0.437501, -0.5> , <-0.24999, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.25, -0.4375, -0.5> , <-0.1875, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, -0.437501, -0.5> , <-0.18749, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.1875, -0.4375, -0.5> , <-0.125, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.187501, -0.437501, -0.5> , <-0.12499, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, -0.4375, -0.5> , <0.0, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, -0.437501, -0.5> , <1e-05, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.0, -0.4375, -0.5> , <0.0625, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, -0.437501, -0.5> , <0.06251, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.0625, -0.4375, -0.5> , <0.125, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, -0.437501, -0.5> , <0.12501, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.125, -0.4375, -0.5> , <0.1875, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, -0.437501, -0.5> , <0.18751, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.1875, -0.4375, -0.5> , <0.25, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, -0.437501, -0.5> , <0.25001, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.25, -0.4375, -0.5> , <0.3125, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, -0.437501, -0.5> , <0.31251, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.3125, -0.4375, -0.5> , <0.375, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, -0.437501, -0.5> , <0.37501, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.375, -0.4375, -0.5> , <0.4375, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, -0.437501, -0.5> , <0.43751, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.4375, -0.4375, -0.5> , <0.5, -0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, -0.437501, -0.5> , <0.50001, -0.37499, 0.6>
    texture {
 //       pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }


      pigment { color rgb<0.866666666667, 0.866666666667, 0.866666666667> }



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




/*
difference
{

box {
    <-0.4375, -0.375, -0.5> , <-0.375, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.437501, -0.375001, -0.5> , <-0.37499, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.375, -0.375, -0.5> , <-0.3125, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.972549019608, 0.972549019608, 0.972549019608, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, -0.375001, -0.5> , <-0.31249, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.972549019608, 0.972549019608, 0.972549019608, 0, 0> }


      pigment { color rgb<0.972549019608, 0.972549019608, 0.972549019608> }



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




/*
difference
{

box {
    <-0.3125, -0.375, -0.5> , <-0.25, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.949019607843, 0.949019607843, 0.949019607843, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, -0.375001, -0.5> , <-0.24999, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.949019607843, 0.949019607843, 0.949019607843, 0, 0> }


      pigment { color rgb<0.949019607843, 0.949019607843, 0.949019607843> }



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




/*
difference
{

box {
    <-0.25, -0.375, -0.5> , <-0.1875, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.933333333333, 0.933333333333, 0.933333333333, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, -0.375001, -0.5> , <-0.18749, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.933333333333, 0.933333333333, 0.933333333333, 0, 0> }


      pigment { color rgb<0.933333333333, 0.933333333333, 0.933333333333> }



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




/*
difference
{

box {
    <-0.1875, -0.375, -0.5> , <-0.125, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.187501, -0.375001, -0.5> , <-0.12499, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, -0.375, -0.5> , <0.0, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, -0.375001, -0.5> , <1e-05, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0, -0.375, -0.5> , <0.0625, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, -0.375001, -0.5> , <0.06251, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.0625, -0.375, -0.5> , <0.125, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.858823529412, 0.858823529412, 0.858823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, -0.375001, -0.5> , <0.12501, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.858823529412, 0.858823529412, 0.858823529412, 0, 0> }


      pigment { color rgb<0.858823529412, 0.858823529412, 0.858823529412> }



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




/*
difference
{

box {
    <0.125, -0.375, -0.5> , <0.1875, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, -0.375001, -0.5> , <0.18751, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }


      pigment { color rgb<0.847058823529, 0.847058823529, 0.847058823529> }



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




/*
difference
{

box {
    <0.1875, -0.375, -0.5> , <0.25, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, -0.375001, -0.5> , <0.25001, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.25, -0.375, -0.5> , <0.3125, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.823529411765, 0.823529411765, 0.823529411765, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, -0.375001, -0.5> , <0.31251, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.823529411765, 0.823529411765, 0.823529411765, 0, 0> }


      pigment { color rgb<0.823529411765, 0.823529411765, 0.823529411765> }



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




/*
difference
{

box {
    <0.3125, -0.375, -0.5> , <0.375, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.81568627451, 0.81568627451, 0.81568627451, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, -0.375001, -0.5> , <0.37501, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.81568627451, 0.81568627451, 0.81568627451, 0, 0> }


      pigment { color rgb<0.81568627451, 0.81568627451, 0.81568627451> }



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




/*
difference
{

box {
    <0.375, -0.375, -0.5> , <0.4375, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, -0.375001, -0.5> , <0.43751, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.4375, -0.375, -0.5> , <0.5, -0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, -0.375001, -0.5> , <0.50001, -0.31249, 0.6>
    texture {
 //       pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }


      pigment { color rgb<0.866666666667, 0.866666666667, 0.866666666667> }



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




/*
difference
{

box {
    <-0.4375, -0.3125, -0.5> , <-0.375, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.437501, -0.312501, -0.5> , <-0.37499, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.375, -0.3125, -0.5> , <-0.3125, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, -0.312501, -0.5> , <-0.31249, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.3125, -0.3125, -0.5> , <-0.25, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, -0.312501, -0.5> , <-0.24999, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.25, -0.3125, -0.5> , <-0.1875, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, -0.312501, -0.5> , <-0.18749, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.1875, -0.3125, -0.5> , <-0.125, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.187501, -0.312501, -0.5> , <-0.12499, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, -0.3125, -0.5> , <0.0, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, -0.312501, -0.5> , <1e-05, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0, -0.3125, -0.5> , <0.0625, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, -0.312501, -0.5> , <0.06251, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.0625, -0.3125, -0.5> , <0.125, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, -0.312501, -0.5> , <0.12501, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.125, -0.3125, -0.5> , <0.1875, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.858823529412, 0.858823529412, 0.858823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, -0.312501, -0.5> , <0.18751, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.858823529412, 0.858823529412, 0.858823529412, 0, 0> }


      pigment { color rgb<0.858823529412, 0.858823529412, 0.858823529412> }



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




/*
difference
{

box {
    <0.1875, -0.3125, -0.5> , <0.25, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, -0.312501, -0.5> , <0.25001, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.25, -0.3125, -0.5> , <0.3125, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.835294117647, 0.835294117647, 0.835294117647, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, -0.312501, -0.5> , <0.31251, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.835294117647, 0.835294117647, 0.835294117647, 0, 0> }


      pigment { color rgb<0.835294117647, 0.835294117647, 0.835294117647> }



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




/*
difference
{

box {
    <0.3125, -0.3125, -0.5> , <0.375, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.823529411765, 0.823529411765, 0.823529411765, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, -0.312501, -0.5> , <0.37501, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.823529411765, 0.823529411765, 0.823529411765, 0, 0> }


      pigment { color rgb<0.823529411765, 0.823529411765, 0.823529411765> }



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




/*
difference
{

box {
    <0.375, -0.3125, -0.5> , <0.4375, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, -0.312501, -0.5> , <0.43751, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.4375, -0.3125, -0.5> , <0.5, -0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, -0.312501, -0.5> , <0.50001, -0.24999, 0.6>
    texture {
 //       pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }


      pigment { color rgb<0.866666666667, 0.866666666667, 0.866666666667> }



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




/*
difference
{

box {
    <-0.375, -0.25, -0.5> , <-0.3125, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, -0.250001, -0.5> , <-0.31249, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.3125, -0.25, -0.5> , <-0.25, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, -0.250001, -0.5> , <-0.24999, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.25, -0.25, -0.5> , <-0.1875, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, -0.250001, -0.5> , <-0.18749, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, -0.25, -0.5> , <0.0, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, -0.250001, -0.5> , <1e-05, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0, -0.25, -0.5> , <0.0625, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, -0.250001, -0.5> , <0.06251, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.0625, -0.25, -0.5> , <0.125, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, -0.250001, -0.5> , <0.12501, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }


      pigment { color rgb<0.886274509804, 0.886274509804, 0.886274509804> }



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




/*
difference
{

box {
    <0.125, -0.25, -0.5> , <0.1875, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, -0.250001, -0.5> , <0.18751, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.1875, -0.25, -0.5> , <0.25, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, -0.250001, -0.5> , <0.25001, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.25, -0.25, -0.5> , <0.3125, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, -0.250001, -0.5> , <0.31251, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }


      pigment { color rgb<0.847058823529, 0.847058823529, 0.847058823529> }



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




/*
difference
{

box {
    <0.3125, -0.25, -0.5> , <0.375, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.835294117647, 0.835294117647, 0.835294117647, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, -0.250001, -0.5> , <0.37501, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.835294117647, 0.835294117647, 0.835294117647, 0, 0> }


      pigment { color rgb<0.835294117647, 0.835294117647, 0.835294117647> }



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




/*
difference
{

box {
    <0.375, -0.25, -0.5> , <0.4375, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, -0.250001, -0.5> , <0.43751, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.4375, -0.25, -0.5> , <0.5, -0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, -0.250001, -0.5> , <0.50001, -0.18749, 0.6>
    texture {
 //       pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }


      pigment { color rgb<0.866666666667, 0.866666666667, 0.866666666667> }



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




/*
difference
{

box {
    <-0.3125, -0.1875, -0.5> , <-0.25, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, -0.187501, -0.5> , <-0.24999, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, -0.1875, -0.5> , <0.0, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, -0.187501, -0.5> , <1e-05, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0, -0.1875, -0.5> , <0.0625, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, -0.187501, -0.5> , <0.06251, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.0625, -0.1875, -0.5> , <0.125, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, -0.187501, -0.5> , <0.12501, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }


      pigment { color rgb<0.898039215686, 0.898039215686, 0.898039215686> }



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




/*
difference
{

box {
    <0.125, -0.1875, -0.5> , <0.1875, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, -0.187501, -0.5> , <0.18751, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }


      pigment { color rgb<0.886274509804, 0.886274509804, 0.886274509804> }



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




/*
difference
{

box {
    <0.1875, -0.1875, -0.5> , <0.25, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, -0.187501, -0.5> , <0.25001, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.25, -0.1875, -0.5> , <0.3125, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.858823529412, 0.858823529412, 0.858823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, -0.187501, -0.5> , <0.31251, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <0.858823529412, 0.858823529412, 0.858823529412, 0, 0> }


      pigment { color rgb<0.858823529412, 0.858823529412, 0.858823529412> }



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




/*
difference
{

box {
    <0.3125, -0.1875, -0.5> , <0.375, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, -0.187501, -0.5> , <0.37501, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }


      pigment { color rgb<0.847058823529, 0.847058823529, 0.847058823529> }



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




/*
difference
{

box {
    <0.375, -0.1875, -0.5> , <0.4375, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, -0.187501, -0.5> , <0.43751, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.4375, -0.1875, -0.5> , <0.5, -0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, -0.187501, -0.5> , <0.50001, -0.12499, 0.6>
    texture {
 //       pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }


      pigment { color rgb<0.866666666667, 0.866666666667, 0.866666666667> }



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




/*
difference
{

box {
    <-0.3125, -0.125, -0.5> , <-0.25, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, -0.125001, -0.5> , <-0.24999, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, -0.125, -0.5> , <0.0, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, -0.125001, -0.5> , <1e-05, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0, -0.125, -0.5> , <0.0625, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, -0.125001, -0.5> , <0.06251, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.0625, -0.125, -0.5> , <0.125, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.913725490196, 0.913725490196, 0.913725490196, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, -0.125001, -0.5> , <0.12501, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <0.913725490196, 0.913725490196, 0.913725490196, 0, 0> }


      pigment { color rgb<0.913725490196, 0.913725490196, 0.913725490196> }



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




/*
difference
{

box {
    <0.125, -0.125, -0.5> , <0.1875, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, -0.125001, -0.5> , <0.18751, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }


      pigment { color rgb<0.898039215686, 0.898039215686, 0.898039215686> }



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




/*
difference
{

box {
    <0.1875, -0.125, -0.5> , <0.25, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, -0.125001, -0.5> , <0.25001, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }


      pigment { color rgb<0.886274509804, 0.886274509804, 0.886274509804> }



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




/*
difference
{

box {
    <0.25, -0.125, -0.5> , <0.3125, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, -0.125001, -0.5> , <0.31251, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.3125, -0.125, -0.5> , <0.375, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.858823529412, 0.858823529412, 0.858823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, -0.125001, -0.5> , <0.37501, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <0.858823529412, 0.858823529412, 0.858823529412, 0, 0> }


      pigment { color rgb<0.858823529412, 0.858823529412, 0.858823529412> }



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




/*
difference
{

box {
    <0.375, -0.125, -0.5> , <0.4375, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, -0.125001, -0.5> , <0.43751, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.4375, -0.125, -0.5> , <0.5, -0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, -0.125001, -0.5> , <0.50001, -0.06249, 0.6>
    texture {
 //       pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }


      pigment { color rgb<0.866666666667, 0.866666666667, 0.866666666667> }



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




/*
difference
{

box {
    <-0.4375, -0.0625, -0.5> , <-0.375, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.437501, -0.062501, -0.5> , <-0.37499, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.375, -0.0625, -0.5> , <-0.3125, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, -0.062501, -0.5> , <-0.31249, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.3125, -0.0625, -0.5> , <-0.25, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, -0.062501, -0.5> , <-0.24999, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.25, -0.0625, -0.5> , <-0.1875, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, -0.062501, -0.5> , <-0.18749, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.1875, -0.0625, -0.5> , <-0.125, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.187501, -0.062501, -0.5> , <-0.12499, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.125, -0.0625, -0.5> , <-0.0625, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.125001, -0.062501, -0.5> , <-0.06249, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <-0.0625, -0.0625, -0.5> , <0.0, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, -0.062501, -0.5> , <1e-05, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0, -0.0625, -0.5> , <0.0625, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, -0.062501, -0.5> , <0.06251, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.0625, -0.0625, -0.5> , <0.125, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.929411764706, 0.929411764706, 0.929411764706, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, -0.062501, -0.5> , <0.12501, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.929411764706, 0.929411764706, 0.929411764706, 0, 0> }


      pigment { color rgb<0.929411764706, 0.929411764706, 0.929411764706> }



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




/*
difference
{

box {
    <0.125, -0.0625, -0.5> , <0.1875, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.913725490196, 0.913725490196, 0.913725490196, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, -0.062501, -0.5> , <0.18751, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.913725490196, 0.913725490196, 0.913725490196, 0, 0> }


      pigment { color rgb<0.913725490196, 0.913725490196, 0.913725490196> }



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




/*
difference
{

box {
    <0.1875, -0.0625, -0.5> , <0.25, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, -0.062501, -0.5> , <0.25001, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }


      pigment { color rgb<0.898039215686, 0.898039215686, 0.898039215686> }



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




/*
difference
{

box {
    <0.25, -0.0625, -0.5> , <0.3125, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, -0.062501, -0.5> , <0.31251, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }


      pigment { color rgb<0.886274509804, 0.886274509804, 0.886274509804> }



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




/*
difference
{

box {
    <0.3125, -0.0625, -0.5> , <0.375, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, -0.062501, -0.5> , <0.37501, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.375, -0.0625, -0.5> , <0.4375, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, -0.062501, -0.5> , <0.43751, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.4375, -0.0625, -0.5> , <0.5, 0.0, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, -0.062501, -0.5> , <0.50001, 1e-05, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.5, 0.0, -0.5> , <-0.4375, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.500001, -1.00000000003e-06, -0.5> , <-0.43749, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.4375, 0.0, -0.5> , <-0.375, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.437501, -1.00000000003e-06, -0.5> , <-0.37499, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.375, 0.0, -0.5> , <-0.3125, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, -1.00000000003e-06, -0.5> , <-0.31249, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }


      pigment { color rgb<0.886274509804, 0.886274509804, 0.886274509804> }



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




/*
difference
{

box {
    <-0.3125, 0.0, -0.5> , <-0.25, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.843137254902, 0.843137254902, 0.843137254902, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, -1.00000000003e-06, -0.5> , <-0.24999, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.843137254902, 0.843137254902, 0.843137254902, 0, 0> }


      pigment { color rgb<0.843137254902, 0.843137254902, 0.843137254902> }



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




/*
difference
{

box {
    <-0.25, 0.0, -0.5> , <-0.1875, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.811764705882, 0.811764705882, 0.811764705882, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, -1.00000000003e-06, -0.5> , <-0.18749, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.811764705882, 0.811764705882, 0.811764705882, 0, 0> }


      pigment { color rgb<0.811764705882, 0.811764705882, 0.811764705882> }



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




/*
difference
{

box {
    <-0.1875, 0.0, -0.5> , <-0.125, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.8, 0.8, 0.8, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.187501, -1.00000000003e-06, -0.5> , <-0.12499, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.8, 0.8, 0.8, 0, 0> }


      pigment { color rgb<0.8, 0.8, 0.8> }



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




/*
difference
{

box {
    <-0.125, 0.0, -0.5> , <-0.0625, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.125001, -1.00000000003e-06, -0.5> , <-0.06249, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, 0.0, -0.5> , <0.0, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.964705882353, 0.964705882353, 0.964705882353, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, -1.00000000003e-06, -0.5> , <1e-05, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.964705882353, 0.964705882353, 0.964705882353, 0, 0> }


      pigment { color rgb<0.964705882353, 0.964705882353, 0.964705882353> }



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




/*
difference
{

box {
    <0.0, 0.0, -0.5> , <0.0625, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, -1.00000000003e-06, -0.5> , <0.06251, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.0625, 0.0, -0.5> , <0.125, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, -1.00000000003e-06, -0.5> , <0.12501, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.125, 0.0, -0.5> , <0.1875, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, -1.00000000003e-06, -0.5> , <0.18751, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.1875, 0.0, -0.5> , <0.25, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, -1.00000000003e-06, -0.5> , <0.25001, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }


      pigment { color rgb<0.847058823529, 0.847058823529, 0.847058823529> }



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




/*
difference
{

box {
    <0.25, 0.0, -0.5> , <0.3125, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, -1.00000000003e-06, -0.5> , <0.31251, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }


      pigment { color rgb<0.847058823529, 0.847058823529, 0.847058823529> }



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




/*
difference
{

box {
    <0.3125, 0.0, -0.5> , <0.375, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, -1.00000000003e-06, -0.5> , <0.37501, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }


      pigment { color rgb<0.847058823529, 0.847058823529, 0.847058823529> }



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




/*
difference
{

box {
    <0.375, 0.0, -0.5> , <0.4375, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, -1.00000000003e-06, -0.5> , <0.43751, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }


      pigment { color rgb<0.847058823529, 0.847058823529, 0.847058823529> }



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




/*
difference
{

box {
    <0.4375, 0.0, -0.5> , <0.5, 0.0625, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, -1.00000000003e-06, -0.5> , <0.50001, 0.06251, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.5, 0.0625, -0.5> , <-0.4375, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.500001, 0.062499, -0.5> , <-0.43749, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.4375, 0.0625, -0.5> , <-0.375, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.437501, 0.062499, -0.5> , <-0.37499, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.375, 0.0625, -0.5> , <-0.3125, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.941176470588, 0.941176470588, 0.941176470588, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, 0.062499, -0.5> , <-0.31249, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.941176470588, 0.941176470588, 0.941176470588, 0, 0> }


      pigment { color rgb<0.941176470588, 0.941176470588, 0.941176470588> }



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




/*
difference
{

box {
    <-0.3125, 0.0625, -0.5> , <-0.25, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, 0.062499, -0.5> , <-0.24999, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }


      pigment { color rgb<0.886274509804, 0.886274509804, 0.886274509804> }



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




/*
difference
{

box {
    <-0.25, 0.0625, -0.5> , <-0.1875, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.843137254902, 0.843137254902, 0.843137254902, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, 0.062499, -0.5> , <-0.18749, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.843137254902, 0.843137254902, 0.843137254902, 0, 0> }


      pigment { color rgb<0.843137254902, 0.843137254902, 0.843137254902> }



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




/*
difference
{

box {
    <-0.1875, 0.0625, -0.5> , <-0.125, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.811764705882, 0.811764705882, 0.811764705882, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.187501, 0.062499, -0.5> , <-0.12499, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.811764705882, 0.811764705882, 0.811764705882, 0, 0> }


      pigment { color rgb<0.811764705882, 0.811764705882, 0.811764705882> }



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




/*
difference
{

box {
    <-0.125, 0.0625, -0.5> , <-0.0625, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.125001, 0.062499, -0.5> , <-0.06249, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, 0.0625, -0.5> , <0.0, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.976470588235, 0.976470588235, 0.976470588235, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, 0.062499, -0.5> , <1e-05, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.976470588235, 0.976470588235, 0.976470588235, 0, 0> }


      pigment { color rgb<0.976470588235, 0.976470588235, 0.976470588235> }



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




/*
difference
{

box {
    <0.0, 0.0625, -0.5> , <0.0625, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, 0.062499, -0.5> , <0.06251, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.0625, 0.0625, -0.5> , <0.125, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, 0.062499, -0.5> , <0.12501, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.125, 0.0625, -0.5> , <0.1875, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, 0.062499, -0.5> , <0.18751, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.1875, 0.0625, -0.5> , <0.25, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, 0.062499, -0.5> , <0.25001, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.25, 0.0625, -0.5> , <0.3125, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, 0.062499, -0.5> , <0.31251, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.3125, 0.0625, -0.5> , <0.375, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, 0.062499, -0.5> , <0.37501, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.375, 0.0625, -0.5> , <0.4375, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, 0.062499, -0.5> , <0.43751, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }


      pigment { color rgb<0.847058823529, 0.847058823529, 0.847058823529> }



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




/*
difference
{

box {
    <0.4375, 0.0625, -0.5> , <0.5, 0.125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, 0.062499, -0.5> , <0.50001, 0.12501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.5, 0.125, -0.5> , <-0.4375, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.500001, 0.124999, -0.5> , <-0.43749, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.4375, 0.125, -0.5> , <-0.375, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.437501, 0.124999, -0.5> , <-0.37499, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.375, 0.125, -0.5> , <-0.3125, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.976470588235, 0.976470588235, 0.976470588235, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, 0.124999, -0.5> , <-0.31249, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.976470588235, 0.976470588235, 0.976470588235, 0, 0> }


      pigment { color rgb<0.976470588235, 0.976470588235, 0.976470588235> }



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




/*
difference
{

box {
    <-0.3125, 0.125, -0.5> , <-0.25, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.941176470588, 0.941176470588, 0.941176470588, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, 0.124999, -0.5> , <-0.24999, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.941176470588, 0.941176470588, 0.941176470588, 0, 0> }


      pigment { color rgb<0.941176470588, 0.941176470588, 0.941176470588> }



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




/*
difference
{

box {
    <-0.25, 0.125, -0.5> , <-0.1875, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, 0.124999, -0.5> , <-0.18749, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }


      pigment { color rgb<0.886274509804, 0.886274509804, 0.886274509804> }



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




/*
difference
{

box {
    <-0.1875, 0.125, -0.5> , <-0.125, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.843137254902, 0.843137254902, 0.843137254902, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.187501, 0.124999, -0.5> , <-0.12499, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.843137254902, 0.843137254902, 0.843137254902, 0, 0> }


      pigment { color rgb<0.843137254902, 0.843137254902, 0.843137254902> }



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




/*
difference
{

box {
    <-0.125, 0.125, -0.5> , <-0.0625, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.125001, 0.124999, -0.5> , <-0.06249, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, 0.125, -0.5> , <0.0, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.98431372549, 0.98431372549, 0.98431372549, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, 0.124999, -0.5> , <1e-05, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.98431372549, 0.98431372549, 0.98431372549, 0, 0> }


      pigment { color rgb<0.98431372549, 0.98431372549, 0.98431372549> }



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




/*
difference
{

box {
    <0.0, 0.125, -0.5> , <0.0625, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, 0.124999, -0.5> , <0.06251, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0625, 0.125, -0.5> , <0.125, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, 0.124999, -0.5> , <0.12501, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.125, 0.125, -0.5> , <0.1875, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, 0.124999, -0.5> , <0.18751, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }


      pigment { color rgb<0.898039215686, 0.898039215686, 0.898039215686> }



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




/*
difference
{

box {
    <0.1875, 0.125, -0.5> , <0.25, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, 0.124999, -0.5> , <0.25001, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.25, 0.125, -0.5> , <0.3125, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.839215686275, 0.839215686275, 0.839215686275, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, 0.124999, -0.5> , <0.31251, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.839215686275, 0.839215686275, 0.839215686275, 0, 0> }


      pigment { color rgb<0.839215686275, 0.839215686275, 0.839215686275> }



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




/*
difference
{

box {
    <0.3125, 0.125, -0.5> , <0.375, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, 0.124999, -0.5> , <0.37501, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.375, 0.125, -0.5> , <0.4375, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, 0.124999, -0.5> , <0.43751, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.847058823529, 0.847058823529, 0.847058823529, 0, 0> }


      pigment { color rgb<0.847058823529, 0.847058823529, 0.847058823529> }



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




/*
difference
{

box {
    <0.4375, 0.125, -0.5> , <0.5, 0.1875, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, 0.124999, -0.5> , <0.50001, 0.18751, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.5, 0.1875, -0.5> , <-0.4375, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.500001, 0.187499, -0.5> , <-0.43749, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.4375, 0.1875, -0.5> , <-0.375, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.437501, 0.187499, -0.5> , <-0.37499, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.375, 0.1875, -0.5> , <-0.3125, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, 0.187499, -0.5> , <-0.31249, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.3125, 0.1875, -0.5> , <-0.25, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.976470588235, 0.976470588235, 0.976470588235, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, 0.187499, -0.5> , <-0.24999, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.976470588235, 0.976470588235, 0.976470588235, 0, 0> }


      pigment { color rgb<0.976470588235, 0.976470588235, 0.976470588235> }



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




/*
difference
{

box {
    <-0.25, 0.1875, -0.5> , <-0.1875, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.941176470588, 0.941176470588, 0.941176470588, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, 0.187499, -0.5> , <-0.18749, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.941176470588, 0.941176470588, 0.941176470588, 0, 0> }


      pigment { color rgb<0.941176470588, 0.941176470588, 0.941176470588> }



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




/*
difference
{

box {
    <-0.1875, 0.1875, -0.5> , <-0.125, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.187501, 0.187499, -0.5> , <-0.12499, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.886274509804, 0.886274509804, 0.886274509804, 0, 0> }


      pigment { color rgb<0.886274509804, 0.886274509804, 0.886274509804> }



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




/*
difference
{

box {
    <-0.125, 0.1875, -0.5> , <-0.0625, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.125001, 0.187499, -0.5> , <-0.06249, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.0625, 0.1875, -0.5> , <0.0, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.062501, 0.187499, -0.5> , <1e-05, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0, 0.1875, -0.5> , <0.0625, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, 0.187499, -0.5> , <0.06251, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0625, 0.1875, -0.5> , <0.125, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, 0.187499, -0.5> , <0.12501, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.125, 0.1875, -0.5> , <0.1875, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.929411764706, 0.929411764706, 0.929411764706, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, 0.187499, -0.5> , <0.18751, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.929411764706, 0.929411764706, 0.929411764706, 0, 0> }


      pigment { color rgb<0.929411764706, 0.929411764706, 0.929411764706> }



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




/*
difference
{

box {
    <0.1875, 0.1875, -0.5> , <0.25, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, 0.187499, -0.5> , <0.25001, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }


      pigment { color rgb<0.898039215686, 0.898039215686, 0.898039215686> }



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




/*
difference
{

box {
    <0.25, 0.1875, -0.5> , <0.3125, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, 0.187499, -0.5> , <0.31251, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.870588235294, 0.870588235294, 0.870588235294, 0, 0> }


      pigment { color rgb<0.870588235294, 0.870588235294, 0.870588235294> }



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




/*
difference
{

box {
    <0.3125, 0.1875, -0.5> , <0.375, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, 0.187499, -0.5> , <0.37501, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.375, 0.1875, -0.5> , <0.4375, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, 0.187499, -0.5> , <0.43751, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.4375, 0.1875, -0.5> , <0.5, 0.25, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.437499, 0.187499, -0.5> , <0.50001, 0.25001, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <-0.4375, 0.25, -0.5> , <-0.375, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.437501, 0.249999, -0.5> , <-0.37499, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.375, 0.25, -0.5> , <-0.3125, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, 0.249999, -0.5> , <-0.31249, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.3125, 0.25, -0.5> , <-0.25, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, 0.249999, -0.5> , <-0.24999, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <-0.25, 0.25, -0.5> , <-0.1875, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.976470588235, 0.976470588235, 0.976470588235, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, 0.249999, -0.5> , <-0.18749, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <0.976470588235, 0.976470588235, 0.976470588235, 0, 0> }


      pigment { color rgb<0.976470588235, 0.976470588235, 0.976470588235> }



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




/*
difference
{

box {
    <-0.1875, 0.25, -0.5> , <-0.125, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.187501, 0.249999, -0.5> , <-0.12499, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.0, 0.25, -0.5> , <0.0625, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, 0.249999, -0.5> , <0.06251, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0625, 0.25, -0.5> , <0.125, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, 0.249999, -0.5> , <0.12501, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.125, 0.25, -0.5> , <0.1875, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.960784313725, 0.960784313725, 0.960784313725, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, 0.249999, -0.5> , <0.18751, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <0.960784313725, 0.960784313725, 0.960784313725, 0, 0> }


      pigment { color rgb<0.960784313725, 0.960784313725, 0.960784313725> }



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




/*
difference
{

box {
    <0.1875, 0.25, -0.5> , <0.25, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.929411764706, 0.929411764706, 0.929411764706, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, 0.249999, -0.5> , <0.25001, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <0.929411764706, 0.929411764706, 0.929411764706, 0, 0> }


      pigment { color rgb<0.929411764706, 0.929411764706, 0.929411764706> }



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




/*
difference
{

box {
    <0.25, 0.25, -0.5> , <0.3125, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, 0.249999, -0.5> , <0.31251, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <0.898039215686, 0.898039215686, 0.898039215686, 0, 0> }


      pigment { color rgb<0.898039215686, 0.898039215686, 0.898039215686> }



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




/*
difference
{

box {
    <0.3125, 0.25, -0.5> , <0.375, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, 0.249999, -0.5> , <0.37501, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.375, 0.25, -0.5> , <0.4375, 0.3125, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, 0.249999, -0.5> , <0.43751, 0.31251, 0.6>
    texture {
 //       pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }


      pigment { color rgb<0.866666666667, 0.866666666667, 0.866666666667> }



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




/*
difference
{

box {
    <-0.375, 0.3125, -0.5> , <-0.3125, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.375001, 0.312499, -0.5> , <-0.31249, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.3125, 0.3125, -0.5> , <-0.25, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.312501, 0.312499, -0.5> , <-0.24999, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <-0.25, 0.3125, -0.5> , <-0.1875, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-0.250001, 0.312499, -0.5> , <-0.18749, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.0, 0.3125, -0.5> , <0.0625, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, 0.312499, -0.5> , <0.06251, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0625, 0.3125, -0.5> , <0.125, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, 0.312499, -0.5> , <0.12501, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.125, 0.3125, -0.5> , <0.1875, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, 0.312499, -0.5> , <0.18751, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.1875, 0.3125, -0.5> , <0.25, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, 0.312499, -0.5> , <0.25001, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.25, 0.3125, -0.5> , <0.3125, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, 0.312499, -0.5> , <0.31251, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <1.0, 1.0, 1.0, 0, 0> }


      pigment { color rgb<1.0, 1.0, 1.0> }



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




/*
difference
{

box {
    <0.3125, 0.3125, -0.5> , <0.375, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, 0.312499, -0.5> , <0.37501, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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




/*
difference
{

box {
    <0.375, 0.3125, -0.5> , <0.4375, 0.375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.374999, 0.312499, -0.5> , <0.43751, 0.37501, 0.6>
    texture {
 //       pigment { color rgbft <0.866666666667, 0.866666666667, 0.866666666667, 0, 0> }


      pigment { color rgb<0.866666666667, 0.866666666667, 0.866666666667> }



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




/*
difference
{

box {
    <0.0, 0.375, -0.5> , <0.0625, 0.4375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <-1.00000000003e-06, 0.374999, -0.5> , <0.06251, 0.43751, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.0625, 0.375, -0.5> , <0.125, 0.4375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.062499, 0.374999, -0.5> , <0.12501, 0.43751, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.125, 0.375, -0.5> , <0.1875, 0.4375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.124999, 0.374999, -0.5> , <0.18751, 0.43751, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.1875, 0.375, -0.5> , <0.25, 0.4375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.187499, 0.374999, -0.5> , <0.25001, 0.43751, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.25, 0.375, -0.5> , <0.3125, 0.4375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.249999, 0.374999, -0.5> , <0.31251, 0.43751, 0.6>
    texture {
 //       pigment { color rgbft <0.658823529412, 0.658823529412, 0.658823529412, 0, 0> }


      pigment { color rgb<0.658823529412, 0.658823529412, 0.658823529412> }



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




/*
difference
{

box {
    <0.3125, 0.375, -0.5> , <0.375, 0.4375, 0.55>
    scale <1.0, 1.0, .4>
    texture {
        //pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }
        //pigment { color rgbft <1, 1, 1, 0, 0> }
        pixel_pigment
        finish { pixel_finish }
    }

}
*/
box {
    <0.312499, 0.374999, -0.5> , <0.37501, 0.43751, 0.6>
    texture {
 //       pigment { color rgbft <0.6, 0.6, 0.6, 0, 0> }


      pigment { color rgb<0.6, 0.6, 0.6> }



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