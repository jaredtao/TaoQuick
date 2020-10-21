import QtQuick 2.9
import QtQuick.Controls 2.2

import TaoQuick 1.0


CusShaderToy {
    anchors.fill: parent
    pixelShader:"// Created by inigo quilez - 2015
    // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0


    // antialiasing - make AA 2, meaning 4x AA, if you have a fast machine
    #define AA 1


    // http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm
    float sdSphere( in vec3 p, in vec4 s )
    {
        return length(p-s.xyz) - s.w;
    }

    // http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm
    float sdEllipsoid( in vec3 p, in vec3 c, in vec3 r )
    {
        return (length( (p-c)/r ) - 1.0) * min(min(r.x,r.y),r.z);
    }

    // http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm
    float sdCircle( in vec2 p, in vec2 c, in float r )
    {
        return length(p-c) - r;
    }

    // http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm
    float sdTorus( vec3 p, vec2 t )
    {
        return length( vec2(length(p.xz)-t.x,p.y) )-t.y;
    }

    // http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm
    float sdCapsule( vec3 p, vec3 a, vec3 b, float r )
    {
        vec3 pa = p-a, ba = b-a;
        float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
        return length( pa - ba*h ) - r;
    }

    // http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm
    vec2 udSegment( vec3 p, vec3 a, vec3 b )
    {
        vec3 pa = p-a, ba = b-a;
        float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
        return vec2( length( pa - ba*h ), h );
    }

    // http://research.microsoft.com/en-us/um/people/hoppe/ravg.pdf
    float det( vec2 a, vec2 b ) { return a.x*b.y-b.x*a.y; }
    vec3 getClosest( vec2 b0, vec2 b1, vec2 b2 )
    {
        float a =     det(b0,b2);
        float b = 2.0*det(b1,b0);
        float d = 2.0*det(b2,b1);
        float f = b*d - a*a;
        vec2  d21 = b2-b1;
        vec2  d10 = b1-b0;
        vec2  d20 = b2-b0;
        vec2  gf = 2.0*(b*d21+d*d10+a*d20); gf = vec2(gf.y,-gf.x);
        vec2  pp = -f*gf/dot(gf,gf);
        vec2  d0p = b0-pp;
        float ap = det(d0p,d20);
        float bp = 2.0*det(d10,d0p);
        float t = clamp( (ap+bp)/(2.0*a+b+d), 0.0 ,1.0 );
        return vec3( mix(mix(b0,b1,t), mix(b1,b2,t),t), t );
    }

    vec4 sdBezier( vec3 a, vec3 b, vec3 c, vec3 p )
    {
        vec3 w = normalize( cross( c-b, a-b ) );
        vec3 u = normalize( c-b );
        vec3 v =          ( cross( w, u ) );

        vec2 a2 = vec2( dot(a-b,u), dot(a-b,v) );
        vec2 b2 = vec2( 0.0 );
        vec2 c2 = vec2( dot(c-b,u), dot(c-b,v) );
        vec3 p3 = vec3( dot(p-b,u), dot(p-b,v), dot(p-b,w) );

        vec3 cp = getClosest( a2-p3.xy, b2-p3.xy, c2-p3.xy );

        return vec4( sqrt(dot(cp.xy,cp.xy)+p3.z*p3.z), cp.z, length(cp.xy), p3.z );
    }

    // http://iquilezles.org/www/articles/smin/smin.htm
    float smin( float a, float b, float k )
    {
        float h = clamp( 0.5 + 0.5*(b-a)/k, 0.0, 1.0 );
        return mix( b, a, h ) - k*h*(1.0-h);
    }

    // http://iquilezles.org/www/articles/smin/smin.htm
    float smax( float a, float b, float k )
    {
        float h = clamp( 0.5 + 0.5*(b-a)/k, 0.0, 1.0 );
        return mix( a, b, h ) + k*h*(1.0-h);
    }

    // http://iquilezles.org/www/articles/smin/smin.htm
    vec3 smax( vec3 a, vec3 b, float k )
    {
        vec3 h = clamp( 0.5 + 0.5*(b-a)/k, 0.0, 1.0 );
        return mix( a, b, h ) + k*h*(1.0-h);
    }

    //---------------------------------------------------------------------------

    float hash1( float n )
    {
        return fract(sin(n)*43758.5453123);
    }

    vec3 hash3( float n )
    {
        return fract(sin(n+vec3(0.0,13.1,31.3))*158.5453123);
    }

    vec3 forwardSF( float i, float n)
    {
        const float PI  = 3.141592653589793238;
        const float PHI = 1.618033988749894848;
        float phi = 2.0*PI*fract(i/PHI);
        float zi = 1.0 - (2.0*i+1.0)/n;
        float sinTheta = sqrt( 1.0 - zi*zi);
        return vec3( cos(phi)*sinTheta, sin(phi)*sinTheta, zi);
    }

    //---------------------------------------------------------------------------

    #define ZERO (min(iFrame,0))

    const float pi = 3.1415927;

    //---------------------------------------------------------------------------

    float mapShell( in vec3 p, out vec4 matInfo )
    {

        const float sc = 1.0/1.0;
        p -= vec3(0.05,0.12,-0.09);

        p *= sc;

        vec3 q = mat3(-0.6333234236, -0.7332753384, 0.2474039592,
                       0.7738444477, -0.6034162289, 0.1924931824,
                       0.0081370606,  0.3133626215, 0.9495986813) * p;

        const float b = 0.1759;

        float r = length( q.xy );
        float t = atan( q.y, q.x );

        // https://swiftcoder.wordpress.com/2010/06/21/logarithmic-spiral-distance-field/
        float n = (log(r)/b - t)/(2.0*pi);

        const float th = 0.11;
        float nm = (log(th)/b-t)/(2.0*pi);

        n = min(n,nm);

        float ni = floor( n );

        float r1 = exp( b * (t + 2.0*pi*ni));
        float r2 = r1 * 3.019863;

        //-------

        float h1 = q.z + 1.5*r1 - 0.5;
        float d1 = sqrt( (r1-r)*(r1-r) + h1*h1) - r1;
        float h2 = q.z + 1.5*r2 - 0.5;
        float d2 = sqrt( (r2-r)*(r2-r) + h2*h2) - r2;

        float d, dx, dy;
        if( d1<d2 ) { d = d1; dx=r1-r; dy=h1; }
        else        { d = d2; dx=r2-r; dy=h2; }


        float di = textureLod( iChannel2, vec2(t+r,0.5), 0. ).x;
        d += 0.002*di;

        matInfo = vec4(dx,dy,r/0.4,t/3.14159);

        vec3 s = q;
        q = q - vec3(0.34,-0.1,0.03);
        q.xy = mat2(0.8,0.6,-0.6,0.8)*q.xy;
        d = smin( d, sdTorus( q, vec2(0.28,0.05) ), 0.06);
        d = smax( d, -sdEllipsoid(q,vec3(0.0,0.0,0.0),vec3(0.24,0.36,0.24) ), 0.03 );

        d = smax( d, -sdEllipsoid(s,vec3(0.52,-0.0,0.0),vec3(0.42,0.23,0.5) ), 0.05 );

        return d/sc;
    }

    vec2 mapSnail( vec3 p, out vec4 matInfo )
    {
        vec3 head = vec3(-0.76,0.6,-0.3);

        vec3 q = p - head;

        // body
    #if 1
        vec4 b1 = sdBezier( vec3(-0.13,-0.65,0.0), vec3(0.24,0.9+0.1,0.0), head+vec3(0.04,0.01,0.0), p );
        float d1 = b1.x;
        d1 -= smoothstep(0.0,0.2,b1.y)*(0.16 - 0.07*smoothstep(0.5,1.0,b1.y));
        b1 = sdBezier( vec3(-0.085,0.0,0.0), vec3(-0.1,0.9-0.05,0.0), head+vec3(0.06,-0.08,0.0), p );
        float d2 = b1.x;
        d2 -= 0.1 - 0.06*b1.y;
        d1 = smin( d1, d2, 0.03 );
        matInfo.xyz = b1.yzw;
    #else
        vec4 b1 = sdBezier( vec3(-0.13,-0.65,0.0), vec3(0.24,0.9+0.11,0.0), head+vec3(0.05,0.01-0.02,0.0), p );
        float d1 = b1.x;
        d1 -= smoothstep(0.0,0.2,b1.y)*(0.16 - 0.75*0.07*smoothstep(0.5,1.0,b1.y));
        matInfo.xyz = b1.yzw;
        float d2;
    #endif
        d2 = sdSphere( q, vec4(0.0,-0.06,0.0,0.085) );
        d1 = smin( d1, d2, 0.03 );

        d1 = smin( d1, sdSphere(p,vec4(0.05,0.52,0.0,0.13)), 0.07 );

        q.xz = mat2(0.8,0.6,-0.6,0.8)*q.xz;

        vec3 sq = vec3( q.xy, abs(q.z) );

        // top antenas
        vec3 af = 0.05*sin(0.5*iTime+vec3(0.0,1.0,3.0) + vec3(2.0,1.0,0.0)*sign(q.z) );
        vec4 b2 = sdBezier( vec3(0.0), vec3(-0.1,0.2,0.2), vec3(-0.3,0.2,0.3)+af, sq );
        float d3 = b2.x;
        d3 -= 0.03 - 0.025*b2.y;
        d1 = smin( d1, d3, 0.04 );
        d3 = sdSphere( sq, vec4(-0.3,0.2,0.3,0.016) + vec4(af,0.0) );
        d1 = smin( d1, d3, 0.01 );

        // bottom antenas
        vec3 bf = 0.02*sin(0.3*iTime+vec3(4.0,1.0,2.0) + vec3(3.0,0.0,1.0)*sign(q.z) );
        vec2 b3 = udSegment( sq, vec3(0.06,-0.05,0.0), vec3(-0.04,-0.2,0.18)+bf );
        d3 = b3.x;
        d3 -= 0.025 - 0.02*b3.y;
        d1 = smin( d1, d3, 0.06 );
        d3 = sdSphere( sq, vec4(-0.04,-0.2,0.18,0.008)+vec4(bf,0.0) );
        d1 = smin( d1, d3, 0.02 );

        // bottom
        vec3 pp = p-vec3(-0.17,0.15,0.0);
        float co = 0.988771078;
        float si = 0.149438132;
        pp.xy = mat2(co,-si,si,co)*pp.xy;
        d1 = smin( d1, sdEllipsoid( pp, vec3(0.0,0.0,0.0), vec3(0.084,0.3,0.15) ), 0.05 );
        d1 = smax( d1, -sdEllipsoid( pp, vec3(-0.08,-0.0,0.0), vec3(0.06,0.55,0.1) ), 0.02 );

        // disp
        float dis = textureLod( iChannel1, 5.0*p.xy, 0. ).x;
        float dx = 0.5 + 0.5*(1.0-smoothstep(0.5,1.0,b1.y));
        d1 -= 0.005*dis*dx*0.5;

        return vec2(d1,1.0);
    }

    float mapDrop( in vec3 p )
    {
        p -= vec3(-0.26,0.25,-0.02);
        p.x -= 2.5*p.y*p.y;
        return sdCapsule( p, vec3(0.0,-0.06,0.0), vec3(0.014,0.06,0.0), 0.037 );
    }

    float mapLeaf( in vec3 p )
    {
        p -= vec3(-1.8,0.6,-0.75);

        p = mat3(0.671212, 0.366685, -0.644218,
                -0.479426, 0.877583,  0.000000,
                 0.565354, 0.308854,  0.764842)*p;

        p.y += 0.2*exp(-abs(2.0*p.z) );


        float ph = 0.25*50.0*p.x - 0.25*75.0*abs(p.z);// + 1.0*sin(5.0*p.x)*sin(5.0*p.z);
        float rr = sin( ph );
        rr = rr*rr;
        rr = rr*rr;
        p.y += 0.005*rr;

        float r = clamp((p.x+2.0)/4.0,0.0,1.0);
        r = 0.0001 + r*(1.0-r)*(1.0-r)*6.0;

        rr = sin( ph*2.0 );
        rr = rr*rr;
        rr *= 0.5+0.5*sin( p.x*12.0 );

        float ri = 0.035*rr;

        float d = sdEllipsoid( p, vec3(0.0), vec3(2.0,0.25*r,r+ri) );

        float d2 = p.y-0.02;
        d = smax( d, -d2, 0.02 );

        return d;
    }

    vec2 mapOpaque( vec3 p, out vec4 matInfo )
    {
        matInfo = vec4(0.0);

        //--------------
        vec2 res = mapSnail( p, matInfo );

        //---------------
        vec4 tmpMatInfo;
        float d4 = mapShell( p, tmpMatInfo );
        if( d4<res.x  ) { res = vec2(d4,2.0); matInfo = tmpMatInfo; }

        //---------------

        // plant
        vec4 b3 = sdBezier( vec3(-0.15,-1.5,0.0), vec3(-0.1,0.5,0.0), vec3(-0.6,1.5,0.0), p );
        d4 = b3.x;
        d4 -= 0.04 - 0.02*b3.y;
        if( d4<res.x  ) { res = vec2(d4,3.0); }

        //----------------------------

        float d5 = mapLeaf( p );
        if( d5<res.x ) res = vec2(d5,4.0);

        return res;
    }

    // http://iquilezles.org/www/articles/normalsSDF/normalsSDF.htm
    vec3 calcNormalOpaque( in vec3 pos, in float eps )
    {
        vec4 kk;
    #if 0
        vec2 e = vec2(1.0,-1.0)*0.5773*eps;
        return normalize( e.xyy*mapOpaque( pos + e.xyy, kk ).x +
                          e.yyx*mapOpaque( pos + e.yyx, kk ).x +
                          e.yxy*mapOpaque( pos + e.yxy, kk ).x +
                          e.xxx*mapOpaque( pos + e.xxx, kk ).x );
    #else
        // inspired by klems - a way to prevent the compiler from inlining map() 4 times
        vec3 n = vec3(0.0);
        for( int i=ZERO; i<4; i++ )
        {
            vec3 e = 0.5773*(2.0*vec3((((i+3)>>1)&1),((i>>1)&1),(i&1))-1.0);
            n += e*mapOpaque(pos+eps*e,kk).x;
        }
        return normalize(n);
    #endif
    }

    //=========================================================================

    float mapLeafWaterDrops( in vec3 p )
    {
        p -= vec3(-1.8,0.6,-0.75);
        vec3 s = p;
        p = mat3(0.671212, 0.366685, -0.644218,
                -0.479426, 0.877583,  0.000000,
                 0.565354, 0.308854,  0.764842)*p;

        vec3 q = p;
        p.y += 0.2*exp(-abs(2.0*p.z) );

        //---------------

        float r = clamp((p.x+2.0)/4.0,0.0,1.0);
        r = r*(1.0-r)*(1.0-r)*6.0;
        float d0 = sdEllipsoid( p, vec3(0.0), vec3(2.0,0.25*r,r) );
        float d1 = sdEllipsoid( q, vec3(0.5,0.0,0.2), 1.0*vec3(0.15,0.13,0.15) );
        float d2 = sdEllipsoid( q, vec3(0.8,-0.07,-0.15), 0.5*vec3(0.15,0.13,0.15) );
        float d3 = sdEllipsoid( s, vec3(0.76,-0.8,0.6), 0.5*vec3(0.15,0.2,0.15) );
        float d4 = sdEllipsoid( q, vec3(-0.5,0.09,-0.2), vec3(0.04,0.03,0.04) );

        d3 = max( d3, p.y-0.01);

        return min( min(d1,d4), min(d2,d3) );
    }

    vec2 mapTransparent( vec3 p, out vec4 matInfo )
    {
        matInfo = vec4(0.0);

        float d5 = mapDrop( p );
        vec2  res = vec2(d5,4.0);

        float d6 = mapLeafWaterDrops( p );
        res.x = min( res.x, d6 );

        return res;
    }

    // http://iquilezles.org/www/articles/normalsSDF/normalsSDF.htm
    vec3 calcNormalTransparent( in vec3 pos, in float eps )
    {
        vec4 kk;
        vec2 e = vec2(1.0,-1.0)*0.5773*eps;
        return normalize( e.xyy*mapTransparent( pos + e.xyy, kk ).x +
                          e.yyx*mapTransparent( pos + e.yyx, kk ).x +
                          e.yxy*mapTransparent( pos + e.yxy, kk ).x +
                          e.xxx*mapTransparent( pos + e.xxx, kk ).x );
    }

    //=========================================================================

    float calcAO( in vec3 pos, in vec3 nor )
    {
        vec4 kk;
        float ao = 0.0;
        for( int i=ZERO; i<32; i++ )
        {
            vec3 ap = forwardSF( float(i), 32.0 );
            float h = hash1(float(i));
            ap *= sign( dot(ap,nor) ) * h*0.1;
            ao += clamp( mapOpaque( pos + nor*0.01 + ap, kk ).x*3.0, 0.0, 1.0 );
        }
        ao /= 32.0;

        return clamp( ao*6.0, 0.0, 1.0 );
    }

    float calcSSS( in vec3 pos, in vec3 nor )
    {
        vec4 kk;
        float occ = 0.0;
        for( int i=ZERO; i<8; i++ )
        {
            float h = 0.002 + 0.11*float(i)/7.0;
            vec3 dir = normalize( sin( float(i)*13.0 + vec3(0.0,2.1,4.2) ) );
            dir *= sign(dot(dir,nor));
            occ += (h-mapOpaque(pos-h*dir, kk).x);
        }
        occ = clamp( 1.0 - 11.0*occ/8.0, 0.0, 1.0 );
        return occ*occ;
    }

    // http://iquilezles.org/www/articles/rmshadows/rmshadows.htm
    float calcSoftShadow( in vec3 ro, in vec3 rd, float k )
    {
        vec4 kk;
        float res = 1.0;
        float t = 0.01;
        for( int i=ZERO; i<32; i++ )
        {
            float h = mapOpaque(ro + rd*t, kk ).x;
            res = min( res, smoothstep(0.0,1.0,k*h/t) );
            t += clamp( h, 0.04, 0.1 );
            if( res<0.01 ) break;
        }
        return clamp(res,0.0,1.0);
    }

    const vec3 sunDir = normalize( vec3(0.2,0.1,0.02) );

    vec3 shadeOpaque( in vec3 ro, in vec3 rd, in float t, in float m, in vec4 matInfo )
    {
        float eps = 0.002;

        vec3 pos = ro + t*rd;
        vec3 nor = calcNormalOpaque( pos, eps );

        vec3 mateD = vec3(0.0);
        vec3 mateS = vec3(0.0);
        vec2 mateK = vec2(0.0);
        vec3 mateE = vec3(0.0);

        float focc = 1.0;
        float fsha = 1.0;

        if( m<1.5 ) // snail body
        {
            float dis = texture( iChannel1, 5.0*pos.xy ).x;

            float be = sdEllipsoid( pos, vec3(-0.3,-0.5,-0.1), vec3(0.2,1.0,0.5) );
            be = 1.0-smoothstep( -0.01, 0.01, be );

            float ff = abs(matInfo.x-0.20);

            mateS = 6.0*mix( 0.7*vec3(2.0,1.2,0.2), vec3(2.5,1.8,0.9), ff );
            mateS += 2.0*dis;
            mateS *= 1.5;
            mateS *= 1.0 + 0.5*ff*ff;
            mateS *= 1.0-0.5*be;

            mateD = vec3(1.0,0.8,0.4);
            mateD *= dis;
            mateD *= 0.015;
            mateD += vec3(0.8,0.4,0.3)*0.15*be;

            mateK = vec2( 60.0, 0.7 + 2.0*dis );

            float f = clamp( dot( -rd, nor ), 0.0, 1.0 );
            f = 1.0-pow( f, 8.0 );
            f = 1.0 - (1.0-f)*(1.0-texture( iChannel2, 0.3*pos.xy ).x);
            mateS *= vec3(0.5,0.1,0.0) + f*vec3(0.5,0.9,1.0);

            float b = 1.0-smoothstep( 0.25,0.55,abs(pos.y));
            focc = 0.2 + 0.8*smoothstep( 0.0, 0.15, sdSphere(pos,vec4(0.05,0.52,0.0,0.13)) );
        }
        else if( m<2.5 ) // shell
        {
            mateK = vec2(0.0);

            float tip = 1.0-smoothstep(0.05,0.4, length(pos-vec3(0.17,0.2,0.35)) );
            mateD = mix( 0.7*vec3(0.2,0.21,0.22), 0.2*vec3(0.15,0.1,0.0), tip );

            vec2 uv = vec2( .5*atan(matInfo.x,matInfo.y)/3.1416, 1.5*matInfo.w );

            vec3 ral = texture( iChannel1, vec2(2.0*matInfo.w+matInfo.z*0.5,0.5) ).xxx;
            mateD *= 0.25 + 0.75*ral;

            float pa = smoothstep(-0.2,0.2, 0.3+sin(2.0+40.0*uv.x + 3.0*sin(11.0*uv.x)) );
            float bar = mix(pa,1.0,smoothstep(0.7,1.0,tip));
            bar *= (matInfo.z<0.6) ? 1.0 : smoothstep( 0.17, 0.21, abs(matInfo.w)  );
            mateD *= vec3(0.06,0.03,0.0)+vec3(0.94,0.97,1.0)*bar;

            mateK = vec2( 64.0, 0.2 );
            mateS = 1.5*vec3(1.0,0.65,0.6) * (1.0-tip);//*0.5;
        }
        else if( m<3.5 ) // plant
        {
            mateD = vec3(0.05,0.1,0.0)*0.2;
            mateS = vec3(0.1,0.2,0.02)*25.0;
            mateK = vec2(5.0,1.0);

            float fre = clamp(1.0+dot(nor,rd), 0.0, 1.0 );
            mateD += 0.2*fre*vec3(1.0,0.5,0.1);

            vec3 te = texture( iChannel2, pos.xy*0.2 ).xyz;
            mateS *= 0.5 + 1.5*te;
            mateE = 0.5*vec3(0.1,0.1,0.03)*(0.2+0.8*te.x);
        }
        else //if( m<4.5 ) // leave
        {
            vec3 p = pos - vec3(-1.8,0.6,-0.75);
            vec3 s = p;
            p = mat3(0.671212, 0.366685, -0.644218,
                    -0.479426, 0.877583,  0.000000,
                     0.565354, 0.308854,  0.764842)*p;

            vec3 q = p;
            p.y += 0.2*exp(-abs(2.0*p.z) );

            float v = smoothstep( 0.01, 0.02, abs(p.z));

            float rr = sin( 4.0*0.25*50.0*p.x - 4.0*0.25*75.0*abs(p.z) );

            vec3 te = texture( iChannel2, p.xz*0.35 ).xyz;

            float r = clamp((p.x+2.0)/4.0,0.0,1.0);
            r = r*(1.0-r)*(1.0-r)*6.0;
            float ff = length(p.xz/vec2(2.0,r));

            mateD = mix( vec3(0.07,0.1,0.0), vec3(0.05,0.2,0.01)*0.25, v );
            mateD = mix( mateD, vec3(0.16,0.2,0.01)*0.25, ff );
            mateD *= 1.0 + 0.25*te;
            mateD *= 0.8;

            mateS = vec3(0.15,0.2,0.02)*0.8;
            mateS *= 1.0 + 0.2*rr;
            mateS *= 0.8;

            mateK = vec2(64.0,0.25);

            //---------------------

            nor.xz += v*0.15*(-1.0+2.0*texture( iChannel3, 1.0*p.xz ).xy);
            nor = normalize( nor );

            float d1 = sdEllipsoid( q, vec3( 0.5-0.07, 0.0,  0.20), 1.0*vec3(1.4*0.15,0.13,0.15) );
            float d2 = sdEllipsoid( q, vec3( 0.8-0.05,-0.07,-0.15), 0.5*vec3(1.3*0.15,0.13,0.15) );
            float d4 = sdEllipsoid( q, vec3(-0.5-0.07, 0.09,-0.20), 1.0*vec3(1.4*0.04,0.03,0.04) );
            float dd = min(d1,min(d2,d4));
            fsha = 0.05 + 0.95*smoothstep(0.0,0.05,dd);

            d1 = abs( sdCircle( q.xz, vec2( 0.5, 0.20), 1.0*0.15 ));
            d2 = abs( sdCircle( q.xz, vec2( 0.8,-0.15), 0.5*0.15 ));
            d4 = abs( sdCircle( q.xz, vec2(-0.5,-0.20), 1.0*0.04 ));
            dd = min(d1,min(d2,d4));
            focc *= 0.55 + 0.45*smoothstep(0.0,0.08,dd);

            d1 = distance( q.xz, vec2( 0.5-0.07, 0.20) );
            d2 = distance( q.xz, vec2( 0.8-0.03,-0.15) );
            fsha += (1.0-smoothstep(0.0,0.10,d1))*1.5;
            fsha += (1.0-smoothstep(0.0,0.05,d2))*1.5;
        }


        vec3 hal = normalize( sunDir-rd );
        float fre = clamp(1.0+dot(nor,rd), 0.0, 1.0 );
        float occ = calcAO( pos, nor )*focc;
        float sss = calcSSS( pos, nor );
        sss = sss*occ + fre*occ + (0.5+0.5*fre)*pow(abs(matInfo.x-0.2),1.0)*occ;

        float dif1 = clamp( dot(nor,sunDir), 0.0, 1.0 );
        float sha = calcSoftShadow( pos, sunDir, 20.0 );
        dif1 *= sha*fsha;
        float spe1 = clamp( dot(nor,hal), 0.0, 1.0 );

        float bou = clamp( 0.3-0.7*nor.y, 0.0, 1.0 );

        // illumination

        vec3 col = vec3(0.0);
        col += 7.0*vec3(1.7,1.2,0.6)*dif1*2.0;           // sun
        col += 4.0*vec3(0.2,1.2,1.6)*occ*(0.5+0.5*nor.y);    // sky
        col += 1.8*vec3(0.1,2.0,0.1)*bou*occ;                // bounce

        col *= mateD;

        col += 0.4*sss*(vec3(0.15,0.1,0.05)+vec3(0.85,0.9,0.95)*dif1)*(0.05+0.95*occ)*mateS; // sss
        col = pow(col,vec3(0.6,0.8,1.0));

        col += vec3(1.0,1.0,1.0)*0.2*pow( spe1, 1.0+mateK.x )*dif1*(0.04+0.96*pow(fre,4.0))*mateK.x*mateK.y;   // sun lobe1
        col += vec3(1.0,1.0,1.0)*0.1*pow( spe1, 1.0+mateK.x/3.0 )*dif1*(0.1+0.9*pow(fre,4.0))*mateK.x*mateK.y; // sun lobe2
        col += 0.1*vec3(1.0,max(1.5-0.7*col.y,0.0),2.0)*occ*occ*smoothstep( 0.0, 0.3, reflect( rd, nor ).y )*mateK.x*mateK.y*(0.04+0.96*pow(fre,5.0)); // sky

        col += mateE;

        return col;
    }

    vec3 shadeTransparent( in vec3 ro, in vec3 rd, in float t, in float m, in vec4 matInfo, in vec3 col, in float depth )
    {
        vec3 oriCol = col;

        float dz = depth - t;
        float ao = clamp(dz*50.0,0.0,1.0);
        vec3  pos = ro + t*rd;
        vec3  nor = calcNormalTransparent( pos, 0.002 );
        float fre = clamp( 1.0 + dot( rd, nor ), 0.0, 1.0 );
        vec3  hal = normalize( sunDir-rd );
        vec3  ref = reflect( -rd, nor );
        float spe1 = clamp( dot(nor,hal), 0.0, 1.0 );
        float spe2 = clamp( dot(ref,sunDir), 0.0, 1.0 );


        float ds = 1.6 - col.y;

        col *= mix( vec3(0.0,0.0,0.0), vec3(0.4,0.6,0.4), ao );

        col += ds*1.5*vec3(1.0,0.9,0.8)*pow( spe1, 80.0 );
        col += ds*0.2*vec3(0.9,1.0,1.0)*smoothstep(0.4,0.8,fre);
        col += ds*0.9*vec3(0.6,0.7,1.0)*smoothstep( -0.5, 0.5, -reflect( rd, nor ).y )*smoothstep(0.2,0.4,fre);
        col += ds*0.5*vec3(1.0,0.9,0.8)*pow( spe2, 80.0 );
        col += ds*0.5*vec3(1.0,0.9,0.8)*pow( spe2, 16.0 );
        col += vec3(0.8,1.0,0.8)*0.5*smoothstep(0.3,0.6,texture( iChannel1, 0.8*nor.xy ).x)*(0.1+0.9*fre*fre);

        // hide aliasing a bit
        return mix( col, oriCol, smoothstep(0.6,1.0,fre) );
    }

    //--------------------------------------------

    vec2 intersectOpaque( in vec3 ro, in vec3 rd, const float mindist, const float maxdist, out vec4 matInfo )
    {
        vec2 res = vec2(-1.0);

        float t = mindist;
        for( int i=ZERO; i<64; i++ )
        {
            vec3 p = ro + t*rd;
            vec2 h = mapOpaque( p, matInfo );
            res = vec2(t,h.y);

            if( h.x<(0.001*t) ||  t>maxdist ) break;

            t += h.x*0.9;
        }
        return res;
    }

    vec2 intersectTransparent( in vec3 ro, in vec3 rd, const float mindist, const float maxdist, out vec4 matInfo )
    {
        vec2 res = vec2(-1.0);

        float t = mindist;
        for( int i=ZERO; i<64; i++ )
        {
            vec3 p = ro + t*rd;
            vec2 h = mapTransparent( p, matInfo );
            res = vec2(t,h.y);

            if( h.x<(0.001*t) ||  t>maxdist ) break;

            t += h.x;
        }
        return res;
    }

    vec3 background( in vec3 d )
    {
        // cheap cubemap
        vec3 n = abs(d);
        vec2 uv = (n.x>n.y && n.x>n.z) ? d.yz/d.x:
                  (n.y>n.x && n.y>n.z) ? d.zx/d.y:
                                         d.xy/d.z;

        // fancy blur
        vec3  col = vec3( 0.0 );
        for( int i=ZERO; i<200; i++ )
        {
            float h = float(i)/200.0;
            float an = 31.0*6.2831*h;
            vec2  of = vec2( cos(an), sin(an) ) * h;

            vec3 tmp = texture( iChannel2, uv*0.25 + 0.0075*of, 4.0 ).yxz;
            col = smax( col, tmp, 0.5 );
        }

        return pow(col,vec3(3.5,3.0,6.0))*0.2;
    }


    vec3 render( in vec3 ro, in vec3 rd, in vec2 q )
    {
        //-----------------------------

        vec3 col = background( rd );

        //-----------------------------

        float mindist = 1.0;
        float maxdist = 4.0;

        vec4 matInfo;
        vec2 tm = intersectOpaque( ro, rd, mindist, maxdist, matInfo );
        if( tm.y>-0.5 && tm.x < maxdist )
        {
            col = shadeOpaque( ro, rd, tm.x, tm.y, matInfo );
            maxdist = tm.x;
        }

        //-----------------------------

        tm = intersectTransparent( ro, rd, mindist, maxdist, matInfo );
        if( tm.y>-0.5 && tm.x < maxdist )
        {
            col = shadeTransparent( ro, rd, tm.x, tm.y, matInfo, col, maxdist );
        }

        //-----------------------------

        float sun = clamp(dot(rd,sunDir),0.0,1.0);
        col += 1.0*vec3(1.5,0.8,0.7)*pow(sun,4.0);

        //-----------------------------

        col = pow( col, vec3(0.45) );

        col = vec3(1.05,1.0,1.0)*col*(0.7+0.3*col*max(3.0-2.0*col,0.0)) + vec3(0.0,0.0,0.04);

        col *= 0.3 + 0.7*pow(16.0*q.x*q.y*(1.0-q.x)*(1.0-q.y),0.1);

        return clamp( col, 0.0, 1.0 );
    }

    mat3 setCamera( in vec3 ro, in vec3 rt )
    {
        vec3 w = normalize(ro-rt);

        float m = sqrt(1.0-w.y*w.y);

        return mat3( w.z,     0.0, -w.x,
                     0.0,     m*m, -w.z*w.y,
                     w.x*m, w.y*m,  w.z*m );
    }

    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {

        #if AA<2

            vec2  p = (-iResolution.xy+2.0*fragCoord.xy)/iResolution.y;
            vec2  q = fragCoord.xy/iResolution.xy;
            float an = 1.87 - 0.04*(1.0-cos(0.5*iTime));

            vec3  ro = vec3(-0.4,0.2,0.0) + 2.2*vec3(cos(an),0.0,sin(an));
            vec3  ta = vec3(-0.6,0.2,0.0);
            mat3  ca = setCamera( ro, ta );
            vec3  rd = normalize( ca * vec3(p,-2.8) );

            vec3 col = render( ro, rd, q );

        #else

            vec3 col = vec3(0.0);
            for( int m=ZERO; m<AA; m++ )
            for( int n=ZERO; n<AA; n++ )
            {
                vec2 rr = vec2( float(m), float(n) ) / float(AA);

                vec2 p = (-iResolution.xy+2.0*(fragCoord.xy+rr))/iResolution.y;
                float an = 1.87 - 0.04*(1.0-cos(0.5*iTime));
                vec2 q = (fragCoord.xy+rr)/iResolution.xy;

                vec3 ro = vec3(-0.4,0.2,0.0) + 2.2*vec3(cos(an),0.0,sin(an));
                vec3 ta = vec3(-0.6,0.2,0.0);
                mat3 ca = setCamera( ro, ta );
                vec3 rd = normalize( ca * vec3(p,-2.8) );

                col += render( ro, rd, q );
            }
            col /= float(AA*AA);
        #endif


        fragColor = vec4( col, 1.0 );
    }"
}
