import QtQuick 2.9
import QtQuick.Controls 2.2

import TaoQuick 1.0


CusShaderToy {
    anchors.fill: parent
    pixelShader:"
// Interesting findings from original NES Super Mario Bros.:
// -Clouds and brushes of all sizes are drawn using the same small sprite (32x24)
// -Hills, clouds and bushes weren't placed manually. Every background object type is repeated after 768 pixels.
// -Overworld (main theme) drum sound uses only the APU noise generator

#define SPRITE_DEC( x, i ) 	mod( floor( i / pow( 4.0, mod( x, 8.0 ) ) ), 4.0 )
#define SPRITE_DEC2( x, i ) mod( floor( i / pow( 4.0, mod( x, 11.0 ) ) ), 4.0 )
#define RGB( r, g, b ) vec3( float( r ) / 255.0, float( g ) / 255.0, float( b ) / 255.0 )

const float MARIO_SPEED	 = 89.0;
const float GOOMBA_SPEED = 32.0;
const float INTRO_LENGTH = 2.0;

void SpriteBlock( inout vec3 color, float x, float y )
{
    // black
    float idx = 1.0;

    // light orange
    idx = x < y ? 3.0 : idx;

    // dark orange
    idx = x > 3.0 && x < 12.0 && y > 3.0 && y < 12.0 ? 2.0 : idx;
    idx = x == 15.0 - y ? 2.0 : idx;

    color = RGB( 0, 0, 0 );
    color = idx == 2.0 ? RGB( 231,  90,  16 ) : color;
    color = idx == 3.0 ? RGB( 247, 214, 181 ) : color;
}

void SpriteHill( inout vec3 color, float x, float y )
{
    float idx = 0.0;

    // dark green
    idx = ( x > y && 79.0 - x > y ) && y < 33.0 ? 2.0 : idx;
    idx = ( x >= 37.0 && x <= 42.0 ) && y == 33.0 ? 2.0 : idx;

    // black
    idx = ( x == y || 79.0 - x == y ) && y < 33.0 ? 1.0 : idx;
    idx = ( x == 33.0 || x == 46.0 ) && y == 32.0 ? 1.0 : idx;
    idx = ( x >= 34.0 && x <= 36.0 ) && y == 33.0 ? 1.0 : idx;
    idx = ( x >= 43.0 && x <= 45.0 ) && y == 33.0 ? 1.0 : idx;
    idx = ( x >= 37.0 && x <= 42.0 ) && y == 34.0 ? 1.0 : idx;
    idx = ( x >= 25.0 && x <= 26.0 ) && ( y >= 8.0  && y <= 11.0 ) ? 1.0 : idx;
    idx = ( x >= 41.0 && x <= 42.0 ) && ( y >= 24.0 && y <= 27.0 ) ? 1.0 : idx;
    idx = ( x >= 49.0 && x <= 50.0 ) && ( y >= 8.0  && y <= 11.0 ) ? 1.0 : idx;
    idx = ( x >= 28.0 && x <= 30.0 ) && ( y >= 11.0 && y <= 14.0 ) ? 1.0 : idx;
    idx = ( x >= 28.0 && x <= 30.0 ) && ( y >= 11.0 && y <= 14.0 ) ? 1.0 : idx;
    idx = ( x >= 44.0 && x <= 46.0 ) && ( y >= 27.0 && y <= 30.0 ) ? 1.0 : idx;
    idx = ( x >= 44.0 && x <= 46.0 ) && ( y >= 27.0 && y <= 30.0 ) ? 1.0 : idx;
    idx = ( x >= 52.0 && x <= 54.0 ) && ( y >= 11.0 && y <= 14.0 ) ? 1.0 : idx;
    idx = ( x == 29.0 || x == 53.0 ) && ( y >= 10.0 && y <= 15.0 ) ? 1.0 : idx;
    idx = x == 45.0 && ( y >= 26.0 && y <= 31.0 ) ? 1.0 : idx;

    color = idx == 1.0 ? RGB( 0,     0,  0 ) : color;
    color = idx == 2.0 ? RGB( 0,   173,  0 ) : color;
}

void SpritePipe( inout vec3 color, float x, float y, float h )
{
    float offset = h * 16.0;

    // light green
    float idx = 3.0;

    // dark green
    idx = ( ( x > 5.0 && x < 8.0 ) || ( x == 13.0 ) || ( x > 15.0 && x < 23.0 ) ) && y < 17.0 + offset ? 2.0 : idx;
    idx = ( ( x > 4.0 && x < 7.0 ) || ( x == 12.0 ) || ( x > 14.0 && x < 24.0 ) ) && ( y > 17.0 + offset && y < 30.0 + offset ) ? 2.0 : idx;
    idx = ( x < 5.0 || x > 11.0 ) && y == 29.0 + offset ? 2.0 : idx;
    idx = fract( x * 0.5 + y * 0.5 ) == 0.5 && x > 22.0 && ( ( x < 26.0 && y < 17.0 + offset ) || ( x < 28.0 && y > 17.0 + offset && y < 30.0 + offset ) ) ? 2.0 : idx;

    // black
    idx = y == 31.0 + offset || x == 0.0 || x == 31.0 || y == 17.0 + offset ? 1.0 : idx;
    idx = ( x == 2.0 || x == 29.0 ) && y < 18.0 + offset ? 1.0 : idx;
    idx = ( x > 1.0 && x < 31.0 ) && y == 16.0 + offset ? 1.0 : idx;

    // transparent
    idx = ( x < 2.0 || x > 29.0 ) && y < 17.0 + offset ? 0.0 : idx;

    color = idx == 1.0 ? RGB( 0,     0,  0 ) : color;
    color = idx == 2.0 ? RGB( 0,   173,  0 ) : color;
    color = idx == 3.0 ? RGB( 189, 255, 24 ) : color;
}

void SpriteCloud( inout vec3 color, float x, float y, float isBush )
{
    float idx = 0.0;

    idx = y == 23.0 ? ( x <= 10.0 ? 0.0 : ( x <= 21.0 ? 5440.0 : 0.0 ) ) : idx;
    idx = y == 22.0 ? ( x <= 10.0 ? 0.0 : ( x <= 21.0 ? 32720.0 : 0.0 ) ) : idx;
    idx = y == 21.0 ? ( x <= 10.0 ? 0.0 : ( x <= 21.0 ? 131061.0 : 0.0 ) ) : idx;
    idx = y == 20.0 ? ( x <= 10.0 ? 1048576.0 : ( x <= 21.0 ? 1179647.0 : 0.0 ) ) : idx;
    idx = y == 19.0 ? ( x <= 10.0 ? 1048576.0 : ( x <= 21.0 ? 3670015.0 : 1.0 ) ) : idx;
    idx = y == 18.0 ? ( x <= 10.0 ? 1048576.0 : ( x <= 21.0 ? 4190207.0 : 7.0 ) ) : idx;
    idx = y == 17.0 ? ( x <= 10.0 ? 3407872.0 : ( x <= 21.0 ? 4177839.0 : 7.0 ) ) : idx;
    idx = y == 16.0 ? ( x <= 10.0 ? 3997696.0 : ( x <= 21.0 ? 4194299.0 : 7.0 ) ) : idx;
    idx = y == 15.0 ? ( x <= 10.0 ? 4150272.0 : ( x <= 21.0 ? 4194303.0 : 1055.0 ) ) : idx;
    idx = y == 14.0 ? ( x <= 10.0 ? 4193536.0 : ( x <= 21.0 ? 4194303.0 : 7455.0 ) ) : idx;
    idx = y == 13.0 ? ( x <= 10.0 ? 4194112.0 : ( x <= 21.0 ? 4194303.0 : 8063.0 ) ) : idx;
    idx = y == 12.0 ? ( x <= 10.0 ? 4194240.0 : ( x <= 21.0 ? 4194303.0 : 73727.0 ) ) : idx;
    idx = y == 11.0 ? ( x <= 10.0 ? 4194260.0 : ( x <= 21.0 ? 4194303.0 : 491519.0 ) ) : idx;
    idx = y == 10.0 ? ( x <= 10.0 ? 4194301.0 : ( x <= 21.0 ? 4194303.0 : 524287.0 ) ) : idx;
    idx = y == 9.0 ? ( x <= 10.0 ? 4194301.0 : ( x <= 21.0 ? 4194303.0 : 524287.0 ) ) : idx;
    idx = y == 8.0 ? ( x <= 10.0 ? 4194292.0 : ( x <= 21.0 ? 4194303.0 : 131071.0 ) ) : idx;
    idx = y == 7.0 ? ( x <= 10.0 ? 4193232.0 : ( x <= 21.0 ? 4194303.0 : 32767.0 ) ) : idx;
    idx = y == 6.0 ? ( x <= 10.0 ? 3927872.0 : ( x <= 21.0 ? 4193279.0 : 131071.0 ) ) : idx;
    idx = y == 5.0 ? ( x <= 10.0 ? 2800896.0 : ( x <= 21.0 ? 4193983.0 : 524287.0 ) ) : idx;
    idx = y == 4.0 ? ( x <= 10.0 ? 3144960.0 : ( x <= 21.0 ? 3144362.0 : 262143.0 ) ) : idx;
    idx = y == 3.0 ? ( x <= 10.0 ? 4150272.0 : ( x <= 21.0 ? 3845099.0 : 98303.0 ) ) : idx;
    idx = y == 2.0 ? ( x <= 10.0 ? 3997696.0 : ( x <= 21.0 ? 4107775.0 : 6111.0 ) ) : idx;
    idx = y == 1.0 ? ( x <= 10.0 ? 1310720.0 : ( x <= 21.0 ? 4183167.0 : 325.0 ) ) : idx;
    idx = y == 0.0 ? ( x <= 10.0 ? 0.0 : ( x <= 21.0 ? 1392661.0 : 0.0 ) ) : idx;

    idx = SPRITE_DEC2( x, idx );

    vec3 colorB = isBush == 1.0 ? RGB( 0,   173,  0 ) : RGB(  57, 189, 255 );
    vec3 colorC = isBush == 1.0 ? RGB( 189, 255, 24 ) : RGB( 254, 254, 254 );

    color = idx == 1.0 ? RGB( 0, 0, 0 ) : color;
    color = idx == 2.0 ? colorB 		: color;
    color = idx == 3.0 ? colorC 		: color;
}

void SpriteFlag( inout vec3 color, float x, float y )
{
    float idx = 0.0;
    idx = y == 15.0 ? 43690.0 : idx;
    idx = y == 14.0 ? ( x <= 7.0 ? 43688.0 : 42326.0 ) : idx;
    idx = y == 13.0 ? ( x <= 7.0 ? 43680.0 : 38501.0 ) : idx;
    idx = y == 12.0 ? ( x <= 7.0 ? 43648.0 : 39529.0 ) : idx;
    idx = y == 11.0 ? ( x <= 7.0 ? 43520.0 : 39257.0 ) : idx;
    idx = y == 10.0 ? ( x <= 7.0 ? 43008.0 : 38293.0 ) : idx;
    idx = y == 9.0 ? ( x <= 7.0 ? 40960.0 : 38229.0 ) : idx;
    idx = y == 8.0 ? ( x <= 7.0 ? 32768.0 : 43354.0 ) : idx;
    idx = y == 7.0 ? ( x <= 7.0 ? 0.0 : 43690.0 ) : idx;
    idx = y == 6.0 ? ( x <= 7.0 ? 0.0 : 43688.0 ) : idx;
    idx = y == 5.0 ? ( x <= 7.0 ? 0.0 : 43680.0 ) : idx;
    idx = y == 4.0 ? ( x <= 7.0 ? 0.0 : 43648.0 ) : idx;
    idx = y == 3.0 ? ( x <= 7.0 ? 0.0 : 43520.0 ) : idx;
    idx = y == 2.0 ? ( x <= 7.0 ? 0.0 : 43008.0 ) : idx;
    idx = y == 1.0 ? ( x <= 7.0 ? 0.0 : 40960.0 ) : idx;
    idx = y == 0.0 ? ( x <= 7.0 ? 0.0 : 32768.0 ) : idx;

    idx = SPRITE_DEC( x, idx );

    color = idx == 1.0 ? RGB(   0, 173,   0 ) : color;
    color = idx == 2.0 ? RGB( 255, 255, 255 ) : color;
}

void SpriteCastleFlag( inout vec3 color, float x, float y )
{
    float idx = 0.0;
    idx = y == 13.0 ? ( x <= 10.0 ? 8.0 : 0.0 ) : idx;
    idx = y == 12.0 ? ( x <= 10.0 ? 42.0 : 0.0 ) : idx;
    idx = y == 11.0 ? ( x <= 10.0 ? 8.0 : 0.0 ) : idx;
    idx = y == 10.0 ? ( x <= 10.0 ? 4194292.0 : 15.0 ) : idx;
    idx = y == 9.0 ? ( x <= 10.0 ? 4161524.0 : 15.0 ) : idx;
    idx = y == 8.0 ? ( x <= 10.0 ? 4161524.0 : 15.0 ) : idx;
    idx = y == 7.0 ? ( x <= 10.0 ? 1398260.0 : 15.0 ) : idx;
    idx = y == 6.0 ? ( x <= 10.0 ? 3495924.0 : 15.0 ) : idx;
    idx = y == 5.0 ? ( x <= 10.0 ? 4022260.0 : 15.0 ) : idx;
    idx = y == 4.0 ? ( x <= 10.0 ? 3528692.0 : 15.0 ) : idx;
    idx = y == 3.0 ? ( x <= 10.0 ? 3667956.0 : 15.0 ) : idx;
    idx = y == 2.0 ? ( x <= 10.0 ? 4194292.0 : 15.0 ) : idx;
    idx = y == 1.0 ? ( x <= 10.0 ? 4.0 : 0.0 ) : idx;
    idx = y == 0.0 ? ( x <= 10.0 ? 4.0 : 0.0 ) : idx;

    idx = SPRITE_DEC2( x, idx );

    color = idx == 1.0 ? RGB( 181,  49,  33 ) : color;
    color = idx == 2.0 ? RGB( 230, 156,  33 ) : color;
    color = idx == 3.0 ? RGB( 255, 255, 255 ) : color;
}

void SpriteGoomba( inout vec3 color, float x, float y, float frame )
{
    float idx = 0.0;

    // second frame is flipped first frame
    x = frame == 1.0 ? 15.0 - x : x;

    if ( frame <= 1.0 )
    {
        idx = y == 15.0 ? ( x <= 7.0 ? 40960.0 : 10.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 43008.0 : 42.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 43520.0 : 170.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 43648.0 : 682.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 43360.0 : 2410.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 42920.0 : 10970.0 ) : idx;
        idx = y ==  9.0 ? ( x <= 7.0 ? 22440.0 : 10965.0 ) : idx;
        idx = y ==  8.0 ? ( x <= 7.0 ? 47018.0 : 43742.0 ) : idx;
        idx = y ==  7.0 ? ( x <= 7.0 ? 49066.0 : 43774.0 ) : idx;
        idx = y ==  6.0 ? 43690.0 : idx;
        idx = y ==  5.0 ? ( x <= 7.0 ? 65192.0 : 10943.0 ) : idx;
        idx = y ==  4.0 ? ( x <= 7.0 ? 65280.0 : 255.0 ) : idx;
        idx = y ==  3.0 ? ( x <= 7.0 ? 65280.0 : 1535.0 ) : idx;
        idx = y ==  2.0 ? ( x <= 7.0 ? 64832.0 : 5471.0 ) : idx;
        idx = y ==  1.0 ? ( x <= 7.0 ? 62784.0 : 5463.0 ) : idx;
        idx = y ==  0.0 ? ( x <= 7.0 ? 5376.0 : 1364.0 ) : idx;
    }
    else
    {
        idx = y == 7.0 ? ( x <= 7.0 ? 40960.0 : 10.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 43648.0 : 682.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 42344.0 : 10586.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 24570.0 : 45045.0 ) : idx;
        idx = y == 3.0 ? 43690.0 : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 65472.0 : 1023.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 65280.0 : 255.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 1364.0 : 5456.0 ) : idx;
    }

    idx = SPRITE_DEC( x, idx );

    color = idx == 1.0 ? RGB( 0,     0,   0 ) : color;
    color = idx == 2.0 ? RGB( 153,  75,  12 ) : color;
    color = idx == 3.0 ? RGB( 255, 200, 184 ) : color;
}

void SpriteKoopa( inout vec3 color, float x, float y, float frame )
{
    float idx = 0.0;

    if ( frame == 0.0 )
    {
        idx = y == 23.0 ? ( x <= 7.0 ? 768.0 : 0.0 ) : idx;
        idx = y == 22.0 ? ( x <= 7.0 ? 4032.0 : 0.0 ) : idx;
        idx = y == 21.0 ? ( x <= 7.0 ? 4064.0 : 0.0 ) : idx;
        idx = y == 20.0 ? ( x <= 7.0 ? 12128.0 : 0.0 ) : idx;
        idx = y == 19.0 ? ( x <= 7.0 ? 12136.0 : 0.0 ) : idx;
        idx = y == 18.0 ? ( x <= 7.0 ? 12136.0 : 0.0 ) : idx;
        idx = y == 17.0 ? ( x <= 7.0 ? 12264.0 : 0.0 ) : idx;
        idx = y == 16.0 ? ( x <= 7.0 ? 11174.0 : 0.0 ) : idx;
        idx = y == 15.0 ? ( x <= 7.0 ? 10922.0 : 0.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 10282.0 : 341.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 30730.0 : 1622.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 31232.0 : 1433.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 24192.0 : 8037.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 24232.0 : 7577.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 28320.0 : 9814.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 40832.0 : 6485.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 26496.0 : 9814.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 23424.0 : 5529.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 22272.0 : 5477.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 24320.0 : 64921.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 65024.0 : 12246.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 59904.0 : 11007.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 43008.0 : 10752.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 40960.0 : 2690.0 ) : idx;
    }
    else
    {
        idx = y == 22.0 ? ( x <= 7.0 ? 192.0 : 0.0 ) : idx;
        idx = y == 21.0 ? ( x <= 7.0 ? 1008.0 : 0.0 ) : idx;
        idx = y == 20.0 ? ( x <= 7.0 ? 3056.0 : 0.0 ) : idx;
        idx = y == 19.0 ? ( x <= 7.0 ? 11224.0 : 0.0 ) : idx;
        idx = y == 18.0 ? ( x <= 7.0 ? 11224.0 : 0.0 ) : idx;
        idx = y == 17.0 ? ( x <= 7.0 ? 11224.0 : 0.0 ) : idx;
        idx = y == 16.0 ? ( x <= 7.0 ? 11256.0 : 0.0 ) : idx;
        idx = y == 15.0 ? ( x <= 7.0 ? 10986.0 : 0.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 10918.0 : 0.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 2730.0 : 341.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 18986.0 : 1622.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 18954.0 : 5529.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 24202.0 : 8037.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 24200.0 : 7577.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 28288.0 : 9814.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 40864.0 : 6485.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 26496.0 : 9814.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 23424.0 : 5529.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 22272.0 : 5477.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 24320.0 : 64921.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 65152.0 : 4054.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 60064.0 : 11007.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 2728.0 : 43520.0 ) : idx;
    }

    idx = SPRITE_DEC( x, idx );

    color = idx == 1.0 ? RGB( 30,  132,   0 ) : color;
    color = idx == 2.0 ? RGB( 215, 141,  34 ) : color;
    color = idx == 3.0 ? RGB( 255, 255, 255 ) : color;
}

void SpriteQuestion( inout vec3 color, float x, float y, float t )
{
    float idx = 0.0;
    idx = y == 15.0 ? ( x <= 7.0 ? 43688.0 : 10922.0 ) : idx;
    idx = y == 14.0 ? ( x <= 7.0 ? 65534.0 : 32767.0 ) : idx;
    idx = y == 13.0 ? ( x <= 7.0 ? 65502.0 : 30719.0 ) : idx;
    idx = y == 12.0 ? ( x <= 7.0 ? 44030.0 : 32762.0 ) : idx;
    idx = y == 11.0 ? ( x <= 7.0 ? 23294.0 : 32745.0 ) : idx;
    idx = y == 10.0 ? ( x <= 7.0 ? 56062.0 : 32619.0 ) : idx;
    idx = y == 9.0 ? ( x <= 7.0 ? 56062.0 : 32619.0 ) : idx;
    idx = y == 8.0 ? ( x <= 7.0 ? 55294.0 : 32618.0 ) : idx;
    idx = y == 7.0 ? ( x <= 7.0 ? 49150.0 : 32598.0 ) : idx;
    idx = y == 6.0 ? ( x <= 7.0 ? 49150.0 : 32758.0 ) : idx;
    idx = y == 5.0 ? ( x <= 7.0 ? 65534.0 : 32757.0 ) : idx;
    idx = y == 4.0 ? ( x <= 7.0 ? 49150.0 : 32766.0 ) : idx;
    idx = y == 3.0 ? ( x <= 7.0 ? 49150.0 : 32758.0 ) : idx;
    idx = y == 2.0 ? ( x <= 7.0 ? 65502.0 : 30709.0 ) : idx;
    idx = y == 1.0 ? ( x <= 7.0 ? 65534.0 : 32767.0 ) : idx;
    idx = y == 0.0 ? 21845.0 : idx;

    idx = SPRITE_DEC( x, idx );

    color = idx == 1.0 ? RGB( 0,     0,   0 ) : color;
    color = idx == 2.0 ? RGB( 231,  90,  16 ) : color;
    color = idx == 3.0 ? mix( RGB( 255,  165, 66 ), RGB( 231,  90,  16 ), t ) : color;
}

void SpriteMushroom( inout vec3 color, float x, float y )
{
    float idx = 0.0;
    idx = y == 15.0 ? ( x <= 7.0 ? 40960.0 : 10.0 ) : idx;
    idx = y == 14.0 ? ( x <= 7.0 ? 43008.0 : 22.0 ) : idx;
    idx = y == 13.0 ? ( x <= 7.0 ? 43520.0 : 85.0 ) : idx;
    idx = y == 12.0 ? ( x <= 7.0 ? 43648.0 : 341.0 ) : idx;
    idx = y == 11.0 ? ( x <= 7.0 ? 43680.0 : 2646.0 ) : idx;
    idx = y == 10.0 ? ( x <= 7.0 ? 42344.0 : 10922.0 ) : idx;
    idx = y == 9.0 ? ( x <= 7.0 ? 38232.0 : 10922.0 ) : idx;
    idx = y == 8.0 ? ( x <= 7.0 ? 38234.0 : 42410.0 ) : idx;
    idx = y == 7.0 ? ( x <= 7.0 ? 38234.0 : 38314.0 ) : idx;
    idx = y == 6.0 ? ( x <= 7.0 ? 42346.0 : 38570.0 ) : idx;
    idx = y == 5.0 ? 43690.0 : idx;
    idx = y == 4.0 ? ( x <= 7.0 ? 64856.0 : 9599.0 ) : idx;
    idx = y == 3.0 ? ( x <= 7.0 ? 65280.0 : 255.0 ) : idx;
    idx = y == 2.0 ? ( x <= 7.0 ? 65280.0 : 239.0 ) : idx;
    idx = y == 1.0 ? ( x <= 7.0 ? 65280.0 : 239.0 ) : idx;
    idx = y == 0.0 ? ( x <= 7.0 ? 64512.0 : 59.0 ) : idx;

    idx = SPRITE_DEC( x, idx );

    color = idx == 1.0 ? RGB( 181, 49,   33 ) : color;
    color = idx == 2.0 ? RGB( 230, 156,  33 ) : color;
    color = idx == 3.0 ? RGB( 255, 255, 255 ) : color;
}

void SpriteGround( inout vec3 color, float x, float y )
{
    float idx = 0.0;
    idx = y == 15.0 ? ( x <= 7.0 ? 65534.0 : 49127.0 ) : idx;
    idx = y == 14.0 ? ( x <= 7.0 ? 43691.0 : 27318.0 ) : idx;
    idx = y == 13.0 ? ( x <= 7.0 ? 43691.0 : 27318.0 ) : idx;
    idx = y == 12.0 ? ( x <= 7.0 ? 43691.0 : 27318.0 ) : idx;
    idx = y == 11.0 ? ( x <= 7.0 ? 43691.0 : 27254.0 ) : idx;
    idx = y == 10.0 ? ( x <= 7.0 ? 43691.0 : 38246.0 ) : idx;
    idx = y == 9.0 ? ( x <= 7.0 ? 43691.0 : 32758.0 ) : idx;
    idx = y == 8.0 ? ( x <= 7.0 ? 43691.0 : 27318.0 ) : idx;
    idx = y == 7.0 ? ( x <= 7.0 ? 43691.0 : 27318.0 ) : idx;
    idx = y == 6.0 ? ( x <= 7.0 ? 43691.0 : 27318.0 ) : idx;
    idx = y == 5.0 ? ( x <= 7.0 ? 43685.0 : 27309.0 ) : idx;
    idx = y == 4.0 ? ( x <= 7.0 ? 43615.0 : 27309.0 ) : idx;
    idx = y == 3.0 ? ( x <= 7.0 ? 22011.0 : 27307.0 ) : idx;
    idx = y == 2.0 ? ( x <= 7.0 ? 32683.0 : 27307.0 ) : idx;
    idx = y == 1.0 ? ( x <= 7.0 ? 27307.0 : 23211.0 ) : idx;
    idx = y == 0.0 ? ( x <= 7.0 ? 38230.0 : 38231.0 ) : idx;

    idx = SPRITE_DEC( x, idx );

    color = RGB( 0, 0, 0 );
    color = idx == 2.0 ? RGB( 231,  90,  16 ) : color;
    color = idx == 3.0 ? RGB( 247, 214, 181 ) : color;
}

void SpriteFlagpoleEnd( inout vec3 color, float x, float y )
{
    float idx = 0.0;

    idx = y == 7.0 ? 1360.0  : idx;
    idx = y == 6.0 ? 6836.0  : idx;
    idx = y == 5.0 ? 27309.0 : idx;
    idx = y == 4.0 ? 27309.0 : idx;
    idx = y == 3.0 ? 27305.0 : idx;
    idx = y == 2.0 ? 27305.0 : idx;
    idx = y == 1.0 ? 6820.0  : idx;
    idx = y == 0.0 ? 1360.0  : idx;

    idx = SPRITE_DEC( x, idx );

    color = idx == 1.0 ? RGB( 0,     0,  0 ) : color;
    color = idx == 2.0 ? RGB( 0,   173,  0 ) : color;
    color = idx == 3.0 ? RGB( 189, 255, 24 ) : color;
}

void SpriteMario( inout vec3 color, float x, float y, float frame )
{
    float idx = 0.0;

    if ( frame == 0.0 )
    {
        idx = y == 14.0 ? ( x <= 7.0 ? 40960.0 : 42.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 43008.0 : 2730.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 21504.0 : 223.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 56576.0 : 4063.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 23808.0 : 16255.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 62720.0 : 1375.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 61440.0 : 1023.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 21504.0 : 793.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 22272.0 : 4053.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 23488.0 : 981.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 43328.0 : 170.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 43584.0 : 170.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 10832.0 : 42.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 16400.0 : 5.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 16384.0 : 21.0 ) : idx;
    }
    else if ( frame == 1.0 )
    {
        idx = y == 15.0 ? ( x <= 7.0 ? 43008.0 : 10.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 43520.0 : 682.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 54528.0 : 55.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 63296.0 : 1015.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 55104.0 : 4063.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 64832.0 : 343.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 64512.0 : 255.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 25856.0 : 5.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 38208.0 : 22.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 42304.0 : 235.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 38208.0 : 170.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 62848.0 : 171.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 62976.0 : 42.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 43008.0 : 21.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 21504.0 : 85.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 21504.0 : 1.0 ) : idx;
    }
    else if ( frame == 2.0 )
    {
        idx = y == 15.0 ? ( x <= 7.0 ? 43008.0 : 10.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 43520.0 : 682.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 54528.0 : 55.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 63296.0 : 1015.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 55104.0 : 4063.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 64832.0 : 343.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 64512.0 : 255.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 42320.0 : 5.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 42335.0 : 16214.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 58687.0 : 15722.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 43535.0 : 1066.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 43648.0 : 1450.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 43680.0 : 1450.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 2708.0 : 1448.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 84.0 : 0.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 336.0 : 0.0 ) : idx;
    }
    else if ( frame == 3.0 )
    {
        idx = y == 15.0 ? ( x <= 7.0 ? 0.0 : 64512.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 40960.0 : 64554.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 43008.0 : 64170.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 21504.0 : 21727.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 56576.0 : 22495.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 23808.0 : 32639.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 62720.0 : 5471.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 61440.0 : 2047.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 38224.0 : 405.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 21844.0 : 16982.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 21855.0 : 17066.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 39487.0 : 23470.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 43596.0 : 23210.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 43344.0 : 23210.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 43604.0 : 42.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 43524.0 : 0.0 ) : idx;
    }
    else if ( frame == 4.0 )
    {
        idx = y == 29.0 ? ( x <= 7.0 ? 32768.0 : 170.0 ) : idx;
        idx = y == 28.0 ? ( x <= 7.0 ? 43008.0 : 234.0 ) : idx;
        idx = y == 27.0 ? ( x <= 7.0 ? 43520.0 : 250.0 ) : idx;
        idx = y == 26.0 ? ( x <= 7.0 ? 43520.0 : 10922.0 ) : idx;
        idx = y == 25.0 ? ( x <= 7.0 ? 54528.0 : 1015.0 ) : idx;
        idx = y == 24.0 ? ( x <= 7.0 ? 57152.0 : 16343.0 ) : idx;
        idx = y == 23.0 ? ( x <= 7.0 ? 24384.0 : 65535.0 ) : idx;
        idx = y == 22.0 ? ( x <= 7.0 ? 24400.0 : 65407.0 ) : idx;
        idx = y == 21.0 ? ( x <= 7.0 ? 65360.0 : 5463.0 ) : idx;
        idx = y == 20.0 ? ( x <= 7.0 ? 64832.0 : 5471.0 ) : idx;
        idx = y == 19.0 ? ( x <= 7.0 ? 62464.0 : 4095.0 ) : idx;
        idx = y == 18.0 ? ( x <= 7.0 ? 43264.0 : 63.0 ) : idx;
        idx = y == 17.0 ? ( x <= 7.0 ? 22080.0 : 6.0 ) : idx;
        idx = y == 16.0 ? ( x <= 7.0 ? 22080.0 : 25.0 ) : idx;
        idx = y == 15.0 ? ( x <= 7.0 ? 22096.0 : 4005.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 22160.0 : 65365.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 23184.0 : 65365.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 23168.0 : 64853.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 27264.0 : 64853.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 43648.0 : 598.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 43648.0 : 682.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 43648.0 : 426.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 43605.0 : 2666.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 43605.0 : 2710.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 43605.0 : 681.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 10837.0 : 680.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 85.0 : 340.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 5.0 : 340.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 1.0 : 5460.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 0.0 : 5460.0 ) : idx;
    }
    else if ( frame == 5.0 )
    {
        idx = y == 30.0 ? ( x <= 7.0 ? 40960.0 : 42.0 ) : idx;
        idx = y == 29.0 ? ( x <= 7.0 ? 43520.0 : 58.0 ) : idx;
        idx = y == 28.0 ? ( x <= 7.0 ? 43648.0 : 62.0 ) : idx;
        idx = y == 27.0 ? ( x <= 7.0 ? 43648.0 : 2730.0 ) : idx;
        idx = y == 26.0 ? ( x <= 7.0 ? 62784.0 : 253.0 ) : idx;
        idx = y == 25.0 ? ( x <= 7.0 ? 63440.0 : 4085.0 ) : idx;
        idx = y == 24.0 ? ( x <= 7.0 ? 55248.0 : 16383.0 ) : idx;
        idx = y == 23.0 ? ( x <= 7.0 ? 55252.0 : 16351.0 ) : idx;
        idx = y == 22.0 ? ( x <= 7.0 ? 65492.0 : 1365.0 ) : idx;
        idx = y == 21.0 ? ( x <= 7.0 ? 65360.0 : 1367.0 ) : idx;
        idx = y == 20.0 ? ( x <= 7.0 ? 64832.0 : 1023.0 ) : idx;
        idx = y == 19.0 ? ( x <= 7.0 ? 43520.0 : 15.0 ) : idx;
        idx = y == 18.0 ? ( x <= 7.0 ? 38464.0 : 22.0 ) : idx;
        idx = y == 17.0 ? ( x <= 7.0 ? 21904.0 : 26.0 ) : idx;
        idx = y == 16.0 ? ( x <= 7.0 ? 21904.0 : 90.0 ) : idx;
        idx = y == 15.0 ? ( x <= 7.0 ? 21904.0 : 106.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 21904.0 : 125.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 21904.0 : 255.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 21920.0 : 767.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 22176.0 : 2815.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 23200.0 : 2751.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 43680.0 : 2725.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 43648.0 : 661.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 27136.0 : 341.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 23040.0 : 85.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 26624.0 : 21.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 41984.0 : 86.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 21504.0 : 81.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 21760.0 : 1.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 21760.0 : 21.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 20480.0 : 21.0 ) : idx;
    }
    else if ( frame == 6.0 )
    {
        idx = y == 31.0 ? ( x <= 7.0 ? 40960.0 : 42.0 ) : idx;
        idx = y == 30.0 ? ( x <= 7.0 ? 43520.0 : 58.0 ) : idx;
        idx = y == 29.0 ? ( x <= 7.0 ? 43648.0 : 62.0 ) : idx;
        idx = y == 28.0 ? ( x <= 7.0 ? 43648.0 : 2730.0 ) : idx;
        idx = y == 27.0 ? ( x <= 7.0 ? 62784.0 : 253.0 ) : idx;
        idx = y == 26.0 ? ( x <= 7.0 ? 63440.0 : 4085.0 ) : idx;
        idx = y == 25.0 ? ( x <= 7.0 ? 55248.0 : 16383.0 ) : idx;
        idx = y == 24.0 ? ( x <= 7.0 ? 55252.0 : 16351.0 ) : idx;
        idx = y == 23.0 ? ( x <= 7.0 ? 65492.0 : 1365.0 ) : idx;
        idx = y == 22.0 ? ( x <= 7.0 ? 65364.0 : 1367.0 ) : idx;
        idx = y == 21.0 ? ( x <= 7.0 ? 64832.0 : 1023.0 ) : idx;
        idx = y == 20.0 ? ( x <= 7.0 ? 21504.0 : 15.0 ) : idx;
        idx = y == 19.0 ? ( x <= 7.0 ? 43520.0 : 12325.0 ) : idx;
        idx = y == 18.0 ? ( x <= 7.0 ? 38208.0 : 64662.0 ) : idx;
        idx = y == 17.0 ? ( x <= 7.0 ? 21840.0 : 64922.0 ) : idx;
        idx = y == 16.0 ? ( x <= 7.0 ? 21844.0 : 65114.0 ) : idx;
        idx = y == 15.0 ? ( x <= 7.0 ? 21844.0 : 30298.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 38228.0 : 5722.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 42325.0 : 1902.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 43605.0 : 682.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 44031.0 : 682.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 44031.0 : 17066.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 43775.0 : 21162.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 43772.0 : 21866.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 43392.0 : 21866.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 42640.0 : 21866.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 23189.0 : 21866.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 43605.0 : 21824.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 2389.0 : 0.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 84.0 : 0.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 84.0 : 0.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 336.0 : 0.0 ) : idx;
    }
    else
    {
        idx = y == 31.0 ? ( x <= 7.0 ? 0.0 : 16128.0 ) : idx;
        idx = y == 30.0 ? ( x <= 7.0 ? 0.0 : 63424.0 ) : idx;
        idx = y == 29.0 ? ( x <= 7.0 ? 40960.0 : 55274.0 ) : idx;
        idx = y == 28.0 ? ( x <= 7.0 ? 43520.0 : 65514.0 ) : idx;
        idx = y == 27.0 ? ( x <= 7.0 ? 43648.0 : 21866.0 ) : idx;
        idx = y == 26.0 ? ( x <= 7.0 ? 43648.0 : 23210.0 ) : idx;
        idx = y == 25.0 ? ( x <= 7.0 ? 62784.0 : 22013.0 ) : idx;
        idx = y == 24.0 ? ( x <= 7.0 ? 63440.0 : 24573.0 ) : idx;
        idx = y == 23.0 ? ( x <= 7.0 ? 55248.0 : 32767.0 ) : idx;
        idx = y == 22.0 ? ( x <= 7.0 ? 55248.0 : 32735.0 ) : idx;
        idx = y == 21.0 ? ( x <= 7.0 ? 65492.0 : 5461.0 ) : idx;
        idx = y == 20.0 ? ( x <= 7.0 ? 64852.0 : 7511.0 ) : idx;
        idx = y == 19.0 ? ( x <= 7.0 ? 64832.0 : 6143.0 ) : idx;
        idx = y == 18.0 ? ( x <= 7.0 ? 43520.0 : 5477.0 ) : idx;
        idx = y == 17.0 ? ( x <= 7.0 ? 38228.0 : 1382.0 ) : idx;
        idx = y == 16.0 ? ( x <= 7.0 ? 21845.0 : 1430.0 ) : idx;
        idx = y == 15.0 ? ( x <= 7.0 ? 21845.0 : 410.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 22005.0 : 602.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 38909.0 : 874.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 43007.0 : 686.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 44031.0 : 682.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 43763.0 : 17066.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 43708.0 : 21162.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 43648.0 : 21930.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 43584.0 : 21930.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 42389.0 : 21930.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 23189.0 : 21930.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 43669.0 : 21920.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 43669.0 : 0.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 10901.0 : 0.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 5.0 : 0.0 ) : idx;
    }

    idx = SPRITE_DEC( x, idx );

    color = idx == 1.0 ? RGB( 106, 107,  4 ) : color;
    color = idx == 2.0 ? RGB( 177,  52, 37 ) : color;
    color = idx == 3.0 ? RGB( 227, 157, 37 ) : color;
}

void SpriteCoin( inout vec3 color, float x, float y, float frame )
{
    float idx = 0.0;
    if ( frame == 0.0 )
    {
        idx = y == 14.0 ? ( x <= 7.0 ? 32768.0 : 1.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 32768.0 : 1.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 24576.0 : 5.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 24576.0 : 5.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 24576.0 : 5.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 24576.0 : 5.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 28672.0 : 5.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 28672.0 : 5.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 24576.0 : 5.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 24576.0 : 5.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 24576.0 : 5.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 24576.0 : 5.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 32768.0 : 1.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 32768.0 : 1.0 ) : idx;
    }
    else if ( frame == 1.0 )
    {
        idx = y == 14.0 ? ( x <= 7.0 ? 32768.0 : 2.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 40960.0 : 10.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 43008.0 : 42.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 59392.0 : 41.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 47616.0 : 166.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 47616.0 : 166.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 47616.0 : 166.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 47616.0 : 166.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 47616.0 : 166.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 47616.0 : 166.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 59392.0 : 41.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 43008.0 : 42.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 40960.0 : 10.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 32768.0 : 2.0 ) : idx;;
    }
    else if ( frame == 2.0 )
    {
        idx = y == 14.0 ? ( x <= 7.0 ? 49152.0 : 1.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 49152.0 : 1.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 61440.0 : 7.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 49152.0 : 1.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 49152.0 : 1.0 ) : idx;
    }
    else
    {
        idx = y == 14.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 0.0 : 3.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 0.0 : 3.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 0.0 : 2.0 ) : idx;
    }

    idx = SPRITE_DEC( x, idx );

    color = idx == 1.0 ? RGB( 181, 49,   33 ) : color;
    color = idx == 2.0 ? RGB( 230, 156,  33 ) : color;
    color = idx == 3.0 ? RGB( 255, 255, 255 ) : color;
}

void SpriteBrick( inout vec3 color, float x, float y )
{
    float ymod4 = floor( mod( y, 4.0 ) );
    float xmod8 = floor( mod( x, 8.0 ) );
    float ymod8 = floor( mod( y, 8.0 ) );

    // dark orange
    float idx = 2.0;

    // black
    idx = ymod4 == 0.0 ? 1.0 : idx;
    idx = xmod8 == ( ymod8 < 4.0 ? 3.0 : 7.0 ) ? 1.0 : idx;

    // light orange
    idx = y == 15.0 ? 3.0 : idx;

    color = idx == 1.0 ? RGB( 0,     0,   0 ) : color;
    color = idx == 2.0 ? RGB( 231,  90,  16 ) : color;
    color = idx == 3.0 ? RGB( 247, 214, 181 ) : color;
}

void DrawCastle( inout vec3 color, float x, float y )
{
    if ( x >= 0.0 && x < 80.0 && y >= 0.0 && y < 80.0 )
    {
        float ymod4    = mod( y, 4.0 );
        float xmod8    = mod( x, 8.0 );
        float xmod16_4 = mod( x + 4.0, 16.0 );
        float xmod16_3 = mod( x + 5.0, 16.0 );
        float ymod8    = mod( y, 8.0 );

        // dark orange
        float idx = 2.0;

        // black
        idx = ymod4 == 0.0 && y <= 72.0 && ( y != 44.0 || xmod16_3 > 8.0 ) ? 1.0 : idx;
        idx = x >= 24.0 && x <= 32.0 && y >= 48.0 && y <= 64.0 ? 1.0 : idx;
        idx = x >= 48.0 && x <= 56.0 && y >= 48.0 && y <= 64.0 ? 1.0 : idx;
        idx = x >= 32.0 && x <= 47.0 && y <= 25.0 ? 1.0 : idx;
        idx = xmod8 == ( ymod8 < 4.0 ? 3.0 : 7.0 ) && y <= 72.0 && ( xmod16_3 > 8.0 || y <= 40.0 || y >= 48.0 ) ? 1.0 : idx;

        // white
        idx = y == ( xmod16_4 < 8.0 ? 47.0 : 40.0 ) ? 3.0 : idx;
        idx = y == ( xmod16_4 < 8.0 ? 79.0 : 72.0 ) ? 3.0 : idx;
        idx = xmod8 == 3.0 && y >= 40.0 && y <= 47.0 ? 3.0 : idx;
        idx = xmod8 == 3.0 && y >= 72.0 ? 3.0 : idx;

        // transparent
        idx = ( x < 16.0 || x >= 64.0 ) && y >= 48.0 ? 0.0 : idx;
        idx = x >= 4.0  && x <= 10.0 && y >= 41.0 && y <= 47.0 ? 0.0 : idx;
        idx = x >= 68.0 && x <= 74.0 && y >= 41.0 && y <= 47.0 ? 0.0 : idx;
        idx = y >= 73.0 && xmod16_3 > 8.0 ? 0.0 : idx;

        color = idx == 1.0 ? RGB(   0,   0,   0 ) : color;
        color = idx == 2.0 ? RGB( 231,  90,  16 ) : color;
        color = idx == 3.0 ? RGB( 247, 214, 181 ) : color;
    }
}

void DrawKoopa( inout vec3 color, float x, float y, float frame )
{
    if ( x >= 0.0 && x <= 15.0 )
    {
        SpriteKoopa( color, x, y, frame );
    }
}

void KoopaWalk( inout vec3 color, float worldX, float worldY, float time, float frame, float startX )
{
    float x = worldX - startX + floor( time * GOOMBA_SPEED );
    DrawKoopa( color, x, worldY - 16.0, frame );
}

void DrawHitQuestion( inout vec3 color, float questionX, float questionY, float time, float questionT, float questionHitTime )
{
    float t = clamp( ( time - questionHitTime ) / 0.25, 0.0, 1.0 );
    t = 1.0 - abs( 2.0 * t - 1.0 );

    questionY -= floor( t * 8.0 );
    if ( questionX >= 0.0 && questionX <= 15.0 )
    {
        if ( time >= questionHitTime )
        {
            SpriteQuestion( color, questionX, questionY, 1.0 );
            if ( questionX >= 3.0 && questionX <= 12.0 && questionY >= 1.0 && questionY <= 15.0 )
            {
                color = RGB( 231, 90, 16 );
            }
        }
        else
        {
            SpriteQuestion( color, questionX, questionY, questionT );
        }
    }
}

void DrawW( inout vec3 color, float x, float y )
{
    if ( x >= 0.0 && x < 14.0 && y >= 0.0 && y < 14.0 )
    {
        if (    ( x <= 3.0 || x >= 10.0 )
             || ( x >= 4.0 && x <= 5.0 && y >= 2.0 && y <= 7.0 )
             || ( x >= 8.0 && x <= 9.0 && y >= 2.0 && y <= 7.0 )
             || ( x >= 6.0 && x <= 7.0 && y >= 4.0 && y <= 9.0 )
           )
        {
            color = RGB( 255, 255, 255 );
        }
    }
}

void DrawO( inout vec3 color, float x, float y )
{
    if ( x >= 0.0 && x < 14.0 && y >= 0.0 && y < 14.0 )
    {
        if (    ( x <= 1.0 || x >= 12.0 ) && ( y >= 2.0 && y <= 11.0 )
             || ( x >= 2.0 && x <= 4.0 )
             || ( x >= 9.0 && x <= 11.0 )
             || ( y <= 1.0 || y >= 11.0 ) && ( x >= 2.0 && x <= 11.0 )
           )
        {
            color = RGB( 255, 255, 255 );
        }
    }
}

void DrawR( inout vec3 color, float x, float y )
{
    if ( x >= 0.0 && x < 14.0 && y >= 0.0 && y < 14.0 )
    {
        if (    ( x <= 3.0 )
             || ( y >= 12.0 && x <= 11.0 )
             || ( x >= 10.0 && y >= 6.0 && y <= 11.0 )
             || ( x >= 8.0  && x <= 9.0 && y <= 7.0 )
             || ( x <= 9.0  && y >= 4.0 && y <= 5.0 )
             || ( x >= 8.0  && y <= 1.0 )
             || ( x >= 6.0  && x <= 11.0 && y >= 2.0 && y <= 3.0 )
           )
        {
            color = RGB( 255, 255, 255 );
        }
    }
}

void DrawL( inout vec3 color, float x, float y )
{
    if ( x >= 0.0 && x < 14.0 && y >= 0.0 && y < 14.0 )
    {
        if ( x <= 3.0 || y <= 1.0 )
        {
            color = RGB( 255, 255, 255 );
        }
    }
}

void DrawD( inout vec3 color, float x, float y )
{
    if ( x >= 0.0 && x < 14.0 && y >= 0.0 && y < 14.0 )
    {
        color = RGB( 255, 255, 255 );

        if (    ( x >= 4.0 && x <= 7.0 && y >= 2.0 && y <= 11.0 )
             || ( x >= 8.0 && x <= 9.0 && y >= 4.0 && y <= 9.0 )
             || ( x >= 12.0 && ( y <= 3.0 || y >= 10.0 ) )
             || ( x >= 10.0 && ( y <= 1.0 || y >= 12.0 ) )
           )
        {
            color = RGB( 0, 0, 0 );
        }
    }
}

void Draw1( inout vec3 color, float x, float y )
{
    if ( x >= 0.0 && x < 14.0 && y >= 0.0 && y < 14.0 )
    {
        if (    ( y <= 1.0 )
             || ( x >= 5.0 && x <= 8.0 )
             || ( x >= 3.0 && x <= 4.0 && y >= 10.0 && y <= 11.0 )
           )
        {
            color = RGB( 255, 255, 255 );
        }
    }
}

void DrawM( inout vec3 color, float x, float y )
{
    if ( x >= 0.0 && x < 14.0 && y >= 0.0 && y < 14.0 )
    {
        if ( y >= 4.0 && y <= 7.0 )
        {
            color = RGB( 255, 255, 255 );
        }
    }
}

void DrawIntro( inout vec3 color, float x, float y, float screenWidth, float screenHeight )
{
    color = RGB( 0, 0, 0 );

    float offset 	= 18.0;
    float textX 	= floor( x - ( screenWidth - offset * 8.0 - 7.0 ) / 2.0 );
    float textY 	= floor( y - ( screenHeight - 7.0 ) / 2.0 - 16.0 * 2.0 );
    float marioX	= textX - offset * 4.0;
    float marioY	= textY + 16.0 * 3.0;

    DrawW( color, textX - offset * 0.0, textY );
    DrawO( color, textX - offset * 1.0, textY );
    DrawR( color, textX - offset * 2.0, textY );
    DrawL( color, textX - offset * 3.0, textY );
    DrawD( color, textX - offset * 4.0, textY );
    Draw1( color, textX - offset * 6.0, textY );
    DrawM( color, textX - offset * 7.0, textY );
    Draw1( color, textX - offset * 8.0, textY );

    if ( marioX >= 0.0 && marioX <= 15.0 )
    {
        SpriteMario( color, marioX, marioY, 4.0 );
    }
}

float CoinAnimY( float worldY, float time, float coinTime )
{
    return worldY - 4.0 * 16.0 - floor( 64.0 * ( 1.0 - abs( 2.0 * ( clamp( ( time - coinTime ) / 0.8, 0.0, 1.0 ) ) - 1.0 ) ) );
}

float QuestionAnimY( float worldY, float time, float questionHitTime )
{
     return worldY - 4.0 * 16.0 - floor( 8.0 * ( 1.0 - abs( 2.0 * clamp( ( time - questionHitTime ) / 0.25, 0.0, 1.0 ) - 1.0 ) ) );
}

float GoombaSWalkX( float worldX, float startX, float time, float goombaLifeTime )
{
    return worldX + floor( min( time, goombaLifeTime ) * GOOMBA_SPEED ) - startX;
}

void DrawGame( inout vec3 color, float time, float pixelX, float pixelY, float screenWidth, float screenHeight )
{
    float mushroomPauseStart 	= 16.25;
    float mushroomPauseLength 	= 2.0;
    float flagPauseStart		= 38.95;
    float flagPauseLength		= 1.5;

    float cameraP1		= clamp( time - mushroomPauseStart, 0.0, mushroomPauseLength );
    float cameraP2		= clamp( time - flagPauseStart,     0.0, flagPauseLength );
    float cameraX 		= floor( min( ( time - cameraP1 - cameraP2 ) * MARIO_SPEED - 240.0, 3152.0 ) );
    float worldX 		= pixelX + cameraX;
    float worldY  		= pixelY - 8.0;
    float tileX			= floor( worldX / 16.0 );
    float tileY			= floor( worldY / 16.0 );
    float tile2X		= floor( worldX / 32.0 );
    float tile2Y		= floor( worldY / 32.0 );
    float worldXMod16	= mod( worldX, 16.0 );
    float worldYMod16 	= mod( worldY, 16.0 );


    // default background color
    color = RGB( 92, 148, 252 );


    // draw hills
    float bigHillX 	 = mod( worldX, 768.0 );
    float smallHillX = mod( worldX - 240.0, 768.0 );
    float hillX 	 = min( bigHillX, smallHillX );
    float hillY      = worldY - ( smallHillX < bigHillX ? 0.0 : 16.0 );
    SpriteHill( color, hillX, hillY );


    // draw clouds and bushes
    float sc1CloudX = mod( worldX - 296.0, 768.0 );
    float sc2CloudX = mod( worldX - 904.0, 768.0 );
    float mcCloudX  = mod( worldX - 584.0, 768.0 );
    float lcCloudX  = mod( worldX - 440.0, 768.0 );
    float scCloudX  = min( sc1CloudX, sc2CloudX );
    float sbCloudX 	= mod( worldX - 376.0, 768.0 );
    float mbCloudX  = mod( worldX - 664.0, 768.0 );
    float lbCloudX  = mod( worldX - 184.0, 768.0 );
    float cCloudX	= min( min( scCloudX, mcCloudX ), lcCloudX );
    float bCloudX	= min( min( sbCloudX, mbCloudX ), lbCloudX );
    float sCloudX	= min( scCloudX, sbCloudX );
    float mCloudX	= min( mcCloudX, mbCloudX );
    float lCloudX	= min( lcCloudX, lbCloudX );
    float cloudX	= min( cCloudX, bCloudX );
    float isBush	= bCloudX < cCloudX ? 1.0 : 0.0;
    float cloudSeg	= cloudX == sCloudX ? 0.0 : ( cloudX == mCloudX ? 1.0 : 2.0 );
    float cloudY	= worldY - ( isBush == 1.0 ? 8.0 : ( ( cloudSeg == 0.0 && sc1CloudX < sc2CloudX ) || cloudSeg == 1.0 ? 168.0 : 152.0 ) );
    if ( cloudX >= 0.0 && cloudX < 32.0 + 16.0 * cloudSeg )
    {
        if ( cloudSeg == 1.0 )
        {
            cloudX = cloudX < 24.0 ? cloudX : cloudX - 16.0;
        }
        if ( cloudSeg == 2.0 )
        {
            cloudX = cloudX < 24.0 ? cloudX : ( cloudX < 40.0 ? cloudX - 16.0 : cloudX - 32.0 );
        }

        SpriteCloud( color, cloudX, cloudY, isBush );
    }



    // draw flag pole
    if ( worldX >= 3175.0 && worldX <= 3176.0 && worldY <= 176.0 )
    {
        color = RGB( 189, 255, 24 );
    }

    // draw flag
    float flagX = worldX - 3160.0;
    float flagY = worldY - 159.0 + floor( 122.0 * clamp( ( time - 39.0 ) / 1.0, 0.0, 1.0 ) );
    if ( flagX >= 0.0 && flagX <= 15.0 )
    {
        SpriteFlag( color, flagX, flagY );
    }

    // draw flagpole end
    float flagpoleEndX = worldX - 3172.0;
    float flagpoleEndY = worldY - 176.0;
    if ( flagpoleEndX >= 0.0 && flagpoleEndX <= 7.0 )
    {
        SpriteFlagpoleEnd( color, flagpoleEndX, flagpoleEndY );
    }



    // draw blocks
    if (    ( tileX >= 134.0 && tileX < 138.0 && tileX - 132.0 > tileY )
         || ( tileX >= 140.0 && tileX < 144.0 && 145.0 - tileX > tileY )
         || ( tileX >= 148.0 && tileX < 153.0 && tileX - 146.0 > tileY && tileY < 5.0 )
         || ( tileX >= 155.0 && tileX < 159.0 && 160.0 - tileX > tileY )
         || ( tileX >= 181.0 && tileX < 190.0 && tileX - 179.0 > tileY && tileY < 9.0 )
         || ( tileX == 198.0 && tileY == 1.0 )
       )
    {
        SpriteBlock( color, worldXMod16, worldYMod16 );
    }


    // draw pipes
    float pipeY = worldY - 16.0;
    float pipeH	= 0.0;
    float pipeX = worldX - 179.0 * 16.0;
    if ( pipeX < 0.0 )
    {
        pipeX = worldX - 163.0 * 16.0;
        pipeH = 0.0;
    }
    if ( pipeX < 0.0 )
    {
        pipeX = worldX - 57.0 * 16.0;
        pipeH = 2.0;
    }
    if ( pipeX < 0.0 )
    {
        pipeX = worldX - 46.0 * 16.0;
        pipeH = 2.0;
    }
    if ( pipeX < 0.0 )
    {
        pipeX = worldX - 38.0 * 16.0;
        pipeH = 1.0;
    }
    if ( pipeX < 0.0 )
    {
        pipeX = worldX - 28.0 * 16.0;
        pipeH = 0.0;
    }
    if ( pipeX >= 0.0 && pipeX <= 31.0 && pipeY >= 0.0 && pipeY <= 31.0 + pipeH * 16.0 )
    {
        SpritePipe( color, pipeX, pipeY, pipeH );
    }


    // draw mushroom
    float mushroomStart = 15.7;
    if ( time >= mushroomStart && time <= 17.0 )
    {
        float jumpTime = 0.5;

        float mushroomX = worldX - 1248.0;
        float mushroomY = worldY - 4.0 * 16.0;
        if ( time >= mushroomStart )
        {
            mushroomY = worldY - 4.0 * 16.0 - floor( 16.0 * clamp( ( time - mushroomStart ) / 0.5, 0.0, 1.0 ) );
        }
        if ( time >= mushroomStart + 0.5 )
        {
            mushroomX -= floor( MARIO_SPEED * ( time - mushroomStart - 0.5 ) );
        }
        if ( time >= mushroomStart + 0.5 + 0.4 )
        {
            mushroomY = mushroomY + floor( sin( ( ( time - mushroomStart - 0.5 - 0.4 ) ) * 3.14 ) * 4.0 * 16.0 );
        }

        if ( mushroomX >= 0.0 && mushroomX <= 15.0 )
        {
            SpriteMushroom( color, mushroomX, mushroomY );
        }
    }


    // draw coins
    float coinFrame = floor( mod( time * 12.0, 4.0 ) );
    float coinX 	= worldX - 2720.0;
    float coinTime 	= 33.9;
    float coinY 	= CoinAnimY( worldY, time, coinTime );
    if ( coinX < 0.0 )
    {
        coinX 		= worldX - 1696.0;
        coinTime 	= 22.4;
        coinY 		= CoinAnimY( worldY, time, coinTime );
    }
    if ( coinX < 0.0 )
    {
        coinX 		= worldX - 352.0;
        coinTime 	= 5.4;
        coinY 		= CoinAnimY( worldY, time, coinTime );
    }

    if ( coinX >= 0.0 && coinX <= 15.0 && time >= coinTime + 0.1 )
    {
        SpriteCoin( color, coinX, coinY, coinFrame );
    }


    // draw questions
    float questionT = clamp( sin( time * 6.0 ), 0.0, 1.0 );
    if (    ( tileY == 4.0 && ( tileX == 16.0 || tileX == 20.0 || tileX == 109.0 || tileX == 112.0 ) )
         || ( tileY == 8.0 && ( tileX == 21.0 || tileX == 94.0 || tileX == 109.0 ) )
         || ( tileY == 8.0 && ( tileX >= 129.0 && tileX <= 130.0 ) )
       )
    {
        SpriteQuestion( color, worldXMod16, worldYMod16, questionT );
    }


    // draw hitted questions
    float questionHitTime 	= 33.9;
    float questionX 		= worldX - 2720.0;
    if ( questionX < 0.0 )
    {
        questionHitTime = 22.4;
        questionX		= worldX - 1696.0;
    }
    if ( questionX < 0.0 )
    {
        questionHitTime = 15.4;
        questionX		= worldX - 1248.0;
    }
    if ( questionX < 0.0 )
    {
        questionHitTime = 5.3;
        questionX		= worldX - 352.0;
    }
    questionT		= time >= questionHitTime ? 1.0 : questionT;
    float questionY = QuestionAnimY( worldY, time, questionHitTime );
    if ( questionX >= 0.0 && questionX <= 15.0 )
    {
        SpriteQuestion( color, questionX, questionY, questionT );
    }
    if ( time >= questionHitTime && questionX >= 3.0 && questionX <= 12.0 && questionY >= 1.0 && questionY <= 15.0 )
    {
        color = RGB( 231, 90, 16 );
    }


    // draw bricks
    if (    ( tileY == 4.0 && ( tileX == 19.0 || tileX == 21.0 || tileX == 23.0 || tileX == 77.0 || tileX == 79.0 || tileX == 94.0 || tileX == 118.0 || tileX == 168.0 || tileX == 169.0 || tileX == 171.0 ) )
         || ( tileY == 8.0 && ( tileX == 128.0 || tileX == 131.0 ) )
         || ( tileY == 8.0 && ( tileX >= 80.0 && tileX <= 87.0 ) )
         || ( tileY == 8.0 && ( tileX >= 91.0 && tileX <= 93.0 ) )
         || ( tileY == 4.0 && ( tileX >= 100.0 && tileX <= 101.0 ) )
         || ( tileY == 8.0 && ( tileX >= 121.0 && tileX <= 123.0 ) )
         || ( tileY == 4.0 && ( tileX >= 129.0 && tileX <= 130.0 ) )
       )
    {
        SpriteBrick( color, worldXMod16, worldYMod16 );
    }


    // draw castle flag
    float castleFlagX = worldX - 3264.0;
    float castleFlagY = worldY - 64.0 - floor( 32.0 * clamp( ( time - 44.6 ) / 1.0, 0.0, 1.0 ) );
    if ( castleFlagX > 0.0 && castleFlagX < 14.0 )
    {
        SpriteCastleFlag( color, castleFlagX, castleFlagY );
    }

    DrawCastle( color, worldX - 3232.0, worldY - 16.0 );

    // draw ground
    if ( tileY <= 0.0
         && !( tileX >= 69.0  && tileX < 71.0 )
         && !( tileX >= 86.0  && tileX < 89.0 )
         && !( tileX >= 153.0 && tileX < 155.0 )
       )
    {
        SpriteGround( color, worldXMod16, worldYMod16 );
    }


    // draw Koopa
    float goombaFrame = floor( mod( time * 5.0, 2.0 ) );
    KoopaWalk( color, worldX, worldY, time, goombaFrame, 2370.0 );


    // draw stomped walking Goombas
    float goombaY 			= worldY - 16.0;
    float goombaLifeTime 	= 26.3;
    float goombaX 			= GoombaSWalkX( worldX, 2850.0 + 24.0, time, goombaLifeTime );
    if ( goombaX < 0.0 )
    {
        goombaLifeTime 	= 25.3;
        goombaX 		= GoombaSWalkX( worldX, 2760.0, time, goombaLifeTime );
    }
    if ( goombaX < 0.0 )
    {
        goombaLifeTime 	= 23.5;
        goombaX 		= GoombaSWalkX( worldX, 2540.0, time, goombaLifeTime );
    }
    if ( goombaX < 0.0 )
    {
        goombaLifeTime 	= 20.29;
        goombaX 		= GoombaSWalkX( worldX, 2150.0, time, goombaLifeTime );
    }
    if ( goombaX < 0.0 )
    {
        goombaLifeTime 	= 10.3;
        goombaX 		= worldX - 790.0 - floor( abs( mod( ( min( time, goombaLifeTime ) + 6.3 ) * GOOMBA_SPEED, 2.0 * 108.0 ) - 108.0 ) );
    }
    goombaFrame = time > goombaLifeTime ? 2.0 : goombaFrame;
    if ( goombaX >= 0.0 && goombaX <= 15.0 )
    {
        SpriteGoomba( color, goombaX, goombaY, goombaFrame );
    }

    // draw walking Goombas
    goombaFrame 		= floor( mod( time * 5.0, 2.0 ) );
    float goombaWalkX 	= worldX + floor( time * GOOMBA_SPEED );
    goombaX 			= goombaWalkX - 3850.0 - 24.0;
    if ( goombaX < 0.0 ) goombaX = goombaWalkX - 3850.0;
    if ( goombaX < 0.0 ) goombaX = goombaWalkX - 2850.0;
    if ( goombaX < 0.0 ) goombaX = goombaWalkX - 2760.0 - 24.0;
    if ( goombaX < 0.0 ) goombaX = goombaWalkX - 2540.0 - 24.0;
    if ( goombaX < 0.0 ) goombaX = goombaWalkX - 2150.0 - 24.0;
    if ( goombaX < 0.0 ) goombaX = worldX - 766.0 - floor( abs( mod( ( time + 6.3 ) * GOOMBA_SPEED, 2.0 * 108.0 ) - 108.0 ) );
    if ( goombaX < 0.0 ) goombaX = worldX - 638.0 - floor( abs( mod( ( time + 6.6 ) * GOOMBA_SPEED, 2.0 * 84.0 ) - 84.0 ) );
    if ( goombaX < 0.0 ) goombaX = goombaWalkX - 435.0;
    if ( goombaX >= 0.0 && goombaX <= 15.0 )
    {
        SpriteGoomba( color, goombaX, goombaY, goombaFrame );
    }



    // Mario jump
    float marioBigJump1 	= 27.1;
    float marioBigJump2 	= 29.75;
    float marioBigJump3 	= 35.05;
    float marioJumpTime 	= 0.0;
    float marioJumpScale	= 0.0;

    if ( time >= 4.2   ) { marioJumpTime = 4.2;   marioJumpScale = 0.45; }
    if ( time >= 5.0   ) { marioJumpTime = 5.0;   marioJumpScale = 0.5;  }
    if ( time >= 6.05  ) { marioJumpTime = 6.05;  marioJumpScale = 0.7;  }
    if ( time >= 7.8   ) { marioJumpTime = 7.8;   marioJumpScale = 0.8;  }
    if ( time >= 9.0   ) { marioJumpTime = 9.0;   marioJumpScale = 1.0;  }
    if ( time >= 10.3  ) { marioJumpTime = 10.3;  marioJumpScale = 0.3;  }
    if ( time >= 11.05 ) { marioJumpTime = 11.05; marioJumpScale = 1.0;  }
    if ( time >= 13.62 ) { marioJumpTime = 13.62; marioJumpScale = 0.45; }
    if ( time >= 15.1  ) { marioJumpTime = 15.1;  marioJumpScale = 0.5;  }
    if ( time >= 18.7  ) { marioJumpTime = 18.7;  marioJumpScale = 0.6;  }
    if ( time >= 19.65 ) { marioJumpTime = 19.65; marioJumpScale = 0.45; }
    if ( time >= 20.29 ) { marioJumpTime = 20.29; marioJumpScale = 0.3;  }
    if ( time >= 21.8  ) { marioJumpTime = 21.8;  marioJumpScale = 0.35; }
    if ( time >= 22.3  ) { marioJumpTime = 22.3;  marioJumpScale = 0.35; }
    if ( time >= 23.0  ) { marioJumpTime = 23.0;  marioJumpScale = 0.40; }
    if ( time >= 23.5  ) { marioJumpTime = 23.5;  marioJumpScale = 0.3;  }
    if ( time >= 24.7  ) { marioJumpTime = 24.7;  marioJumpScale = 0.45; }
    if ( time >= 25.3  ) { marioJumpTime = 25.3;  marioJumpScale = 0.3;  }
    if ( time >= 25.75 ) { marioJumpTime = 25.75; marioJumpScale = 0.4;  }
    if ( time >= 26.3  ) { marioJumpTime = 26.3;  marioJumpScale = 0.25; }
    if ( time >= marioBigJump1 ) 		{ marioJumpTime = marioBigJump1; 		marioJumpScale = 1.0; }
    if ( time >= marioBigJump1 + 1.0 ) 	{ marioJumpTime = marioBigJump1 + 1.0; 	marioJumpScale = 0.6; }
    if ( time >= marioBigJump2 ) 		{ marioJumpTime = marioBigJump2; 		marioJumpScale = 1.0; }
    if ( time >= marioBigJump2 + 1.0 ) 	{ marioJumpTime = marioBigJump2 + 1.0;	marioJumpScale = 0.6; }
    if ( time >= 32.3  ) { marioJumpTime = 32.3;  marioJumpScale = 0.7;  }
    if ( time >= 33.7  ) { marioJumpTime = 33.7;  marioJumpScale = 0.3;  }
    if ( time >= 34.15 ) { marioJumpTime = 34.15; marioJumpScale = 0.45; }
    if ( time >= marioBigJump3 ) 				{ marioJumpTime = marioBigJump3; 				marioJumpScale = 1.0; }
    if ( time >= marioBigJump3 + 1.2 ) 			{ marioJumpTime = marioBigJump3 + 1.2; 			marioJumpScale = 0.89; }
    if ( time >= marioBigJump3 + 1.2 + 0.75 ) 	{ marioJumpTime = marioBigJump3 + 1.2 + 0.75; 	marioJumpScale = 0.5; }

    float marioJumpOffset 		= 0.0;
    float marioJumpLength 		= 1.5  * marioJumpScale;
    float marioJumpAmplitude	= 76.0 * marioJumpScale;
    if ( time >= marioJumpTime && time <= marioJumpTime + marioJumpLength )
    {
        float t = ( time - marioJumpTime ) / marioJumpLength;
        marioJumpOffset = floor( sin( t * 3.14 ) * marioJumpAmplitude );
    }


    // Mario land
    float marioLandTime 	= 0.0;
    float marioLandAplitude = 0.0;
    if ( time >= marioBigJump1 + 1.0 + 0.45 ) 			{ marioLandTime = marioBigJump1 + 1.0 + 0.45; 			marioLandAplitude = 109.0; }
    if ( time >= marioBigJump2 + 1.0 + 0.45 ) 			{ marioLandTime = marioBigJump2 + 1.0 + 0.45; 			marioLandAplitude = 109.0; }
    if ( time >= marioBigJump3 + 1.2 + 0.75 + 0.375 ) 	{ marioLandTime = marioBigJump3 + 1.2 + 0.75 + 0.375; 	marioLandAplitude = 150.0; }

    float marioLandLength = marioLandAplitude / 120.0;
    if ( time >= marioLandTime && time <= marioLandTime + marioLandLength )
    {
        float t = 0.5 * ( time - marioLandTime ) / marioLandLength + 0.5;
        marioJumpOffset = floor( sin( t * 3.14 ) * marioLandAplitude );
    }


    // Mario flag jump
    marioJumpTime 		= flagPauseStart - 0.3;
    marioJumpLength 	= 1.5  * 0.45;
    marioJumpAmplitude	= 76.0 * 0.45;
    if ( time >= marioJumpTime && time <= marioJumpTime + marioJumpLength + flagPauseLength )
    {
        float time2 = time;
        if ( time >= flagPauseStart && time <= flagPauseStart + flagPauseLength )
        {
            time2 = flagPauseStart;
        }
        else if ( time >= flagPauseStart )
        {
            time2 = time - flagPauseLength;
        }
        float t = ( time2 - marioJumpTime ) / marioJumpLength;
        marioJumpOffset = floor( sin( t * 3.14 ) * marioJumpAmplitude );
    }


    // Mario base (ground offset)
    float marioBase = 0.0;
    if ( time >= marioBigJump1 + 1.0 && time < marioBigJump1 + 1.0 + 0.45 )
    {
        marioBase = 16.0 * 4.0;
    }
    if ( time >= marioBigJump2 + 1.0 && time < marioBigJump2 + 1.0 + 0.45 )
    {
        marioBase = 16.0 * 4.0;
    }
    if ( time >= marioBigJump3 + 1.2 && time < marioBigJump3 + 1.2 + 0.75 )
    {
        marioBase = 16.0 * 3.0;
    }
    if ( time >= marioBigJump3 + 1.2 + 0.75 && time < marioBigJump3 + 1.2 + 0.75 + 0.375 )
    {
        marioBase = 16.0 * 7.0;
    }

    float marioX		= pixelX - 112.0;
    float marioY		= pixelY - 16.0 - 8.0 - marioBase - marioJumpOffset;
    float marioFrame 	= marioJumpOffset == 0.0 ? floor( mod( time * 10.0, 3.0 ) ) : 3.0;
    if ( time >= mushroomPauseStart && time <= mushroomPauseStart + mushroomPauseLength )
    {
        marioFrame = 1.0;
    }
    if ( time > mushroomPauseStart + 0.7 )
    {
        float t = time - mushroomPauseStart - 0.7;
        if ( mod( t, 0.2 ) <= mix( 0.0, 0.2, clamp( t / 1.3, 0.0, 1.0 ) ) )
        {
            // super mario offset
            marioFrame += 4.0;
        }
    }
    if ( marioX >= 0.0 && marioX <= 15.0 && cameraX < 3152.0 )
    {
        SpriteMario( color, marioX, marioY, marioFrame );
    }
}

vec2 CRTCurveUV( vec2 uv )
{
    uv = uv * 2.0 - 1.0;
    vec2 offset = abs( uv.yx ) / vec2( 6.0, 4.0 );
    uv = uv + uv * offset * offset;
    uv = uv * 0.5 + 0.5;
    return uv;
}

void DrawVignette( inout vec3 color, vec2 uv )
{
    float vignette = uv.x * uv.y * ( 1.0 - uv.x ) * ( 1.0 - uv.y );
    vignette = clamp( pow( 16.0 * vignette, 0.3 ), 0.0, 1.0 );
    color *= vignette;
}

void DrawScanline( inout vec3 color, vec2 uv )
{
    float scanline 	= clamp( 0.95 + 0.05 * cos( 3.14 * ( uv.y + 0.008 * iTime ) * 240.0 * 1.0 ), 0.0, 1.0 );
    float grille 	= 0.85 + 0.15 * clamp( 1.5 * cos( 3.14 * uv.x * 640.0 * 1.0 ), 0.0, 1.0 );
    color *= scanline * grille * 1.2;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // we want to see at least 224x192 (overscan) and we want multiples of pixel size
    float resMultX  = floor( iResolution.x / 224.0 );
    float resMultY  = floor( iResolution.y / 192.0 );
    float resRcp	= 1.0 / max( min( resMultX, resMultY ), 1.0 );

    float time			= iTime;
    float screenWidth	= floor( iResolution.x * resRcp );
    float screenHeight	= floor( iResolution.y * resRcp );
    float pixelX 		= floor( fragCoord.x * resRcp );
    float pixelY 		= floor( fragCoord.y * resRcp );

    vec3 color = RGB( 92, 148, 252 );
    DrawGame( color, time, pixelX, pixelY, screenWidth, screenHeight );
    if ( time < INTRO_LENGTH )
    {
        DrawIntro( color, pixelX, pixelY, screenWidth, screenHeight );
    }


    // CRT effects (curvature, vignette, scanlines and CRT grille)
    vec2 uv    = fragCoord.xy / iResolution.xy;
    vec2 crtUV = CRTCurveUV( uv );
    if ( crtUV.x < 0.0 || crtUV.x > 1.0 || crtUV.y < 0.0 || crtUV.y > 1.0 )
    {
        color = vec3( 0.0, 0.0, 0.0 );
    }
    DrawVignette( color, crtUV );
    DrawScanline( color, uv );

    fragColor.xyz 	= color;
    fragColor.w		= 1.0;
}
"
}
