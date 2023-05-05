#include "animateVertices.h"
#include "glwidget.h"

void AnimateVertices::onPluginLoad()
{
	// Carregar shader, compile & link 
    QString vs_src =
    "#version 330 core\n"
    "uniform mat4 modelViewProjectionMatrix;"
    "in vec3 vertex;"
    "in vec3 color;"
    "in vec3 normal;"
    "out vec4 frontColor;"
    "out vec2 vtexCoord;"

	"uniform mat3 normalMatrix;"
	"uniform float time;"
	"uniform float amplitude = 0.1;"
	"uniform float freq = 1;"
	"const float PI = 3.141592;"
    "void main()"
    "{"
    	"vec3 N = normalize(normalMatrix * normal);"
    	"frontColor = vec4(N.z,N.z,N.z,1.0)  ;"
    	
    
    	"gl_Position = modelViewProjectionMatrix * vec4(vertex+normal*amplitude*sin(2*PI*freq*time), 1.0);"
    "}";
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceCode(vs_src);
    cout << "VS log:" << vs->log().toStdString() << endl;

    QString fs_src =
    "#version 330 core\n"

	"in vec4 frontColor;"
	"out vec4 fragColor;"

	"void main()"
	"{"
    		"fragColor = frontColor;"
	"}";

    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceCode(fs_src);
    cout << "FS log:" << fs->log().toStdString() << endl;

    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    cout << "Link log:" << program->log().toStdString() << endl;
    elapsedTimer.start();
    // keep repainting
    QTimer *timer = new QTimer(this);
    // connect(timer, SIGNAL(timeout()), glwidget(), SLOT(updateGL()));
    timer->start();	
}

void AnimateVertices::preFrame()
{
    // bind shader and define uniforms
    program->bind();
    program->setUniformValue("n", 6);
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP);
    program->setUniformValue("time", float(elapsedTimer.elapsed()/1000.0f));
	
}

void AnimateVertices::postFrame()
{
    // unbind shader
    program->release();
	
}

void AnimateVertices::onObjectAdd()
{
	
}

bool AnimateVertices::drawScene()
{
	return false; // return true only if implemented
}

bool AnimateVertices::drawObject(int)
{
	return false; // return true only if implemented
}

bool AnimateVertices::paintGL()
{
	return false; // return true only if implemented
}

void AnimateVertices::keyPressEvent(QKeyEvent *)
{
	
}

void AnimateVertices::mouseMoveEvent(QMouseEvent *)
{
	
}

