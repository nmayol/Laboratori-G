#include "isafloor.h"
#include "glwidget.h"


void Isafloor::calculLambda() {
    const Object &obj=scene()->objects()[0];
    vector<Face> Cares = obj.faces();       
        
    float total = (float) Cares.size();
    float count = 0.;
    for (int i = 0; i < (int)Cares.size(); ++i) {
        Face f = Cares[i];
        Vector fnormal = f.normal().normalized();
        if(fnormal.z() > 0.7) count = count + 1;
    }

    lambda = count / total;
    cout << lambda << endl;
}

void Isafloor::onPluginLoad()
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
	"uniform float lambda;"
    "void main()"
    "{"
    	"vec3 N = normalize(normalMatrix * normal);"
    	"frontColor = mix(vec4(1,0,0,0),vec4(0,1,0,0),lambda)*N.z;"
    	
    
    	"gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);"
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
    calculLambda();
}



void Isafloor::preFrame()
{
    // bind shader and define uniforms
    program->bind();
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP);
    program->setUniformValue("normalMatrix", camera()->viewMatrix().normalMatrix()); 
	program->setUniformValue("lambda", lambda); 
	
}

void Isafloor::postFrame()
{
    // unbind shader
    program->release();
	
}

void Isafloor::onObjectAdd()
{
	calculLambda();
}

bool Isafloor::drawScene()
{
	return false; // return true only if implemented
}

bool Isafloor::drawObject(int)
{
	return false; // return true only if implemented
}

bool Isafloor::paintGL()
{
	return false; // return true only if implemented
}

void Isafloor::keyPressEvent(QKeyEvent *)
{
	
}

void Isafloor::mouseMoveEvent(QMouseEvent *)
{
	
}
