pragma Singleton
import QtQuick 2.9
QtObject {
    property string versionString: GraphicsInfo.renderableType === GraphicsInfo.SurfaceFormatOpenGLES ?
                                       "#version 100 es" : "#version 130"
    property string fragmentShaderCommon: versionString + "
#ifdef GL_ES
    precision mediump float;
#else
#   define lowp
#   define mediump
#   define highp
#endif // GL_ES
        "

}

