#include "reflection.h"
#include <QCoreApplication>




//////////////////////////// DISCLAIMER ///////////////////////////
// Aquesta es una versio extesa de reflection en que pots posar el
// mirall en qualsevol dels tres plans x, y i z. Es pot fer
// canviant el valor de la constant mode:
const int mode = 1; // (0 = y; 1 = x; 2 = z)
// Per pintar mes d'un pla a la vegada shauria de fer multiples 
// copies de les linies [42-51], i canviar el valor de mode en
// textureId[mode] segons el pla/ns que es vulgui:
                                        //  (0 = y; 1 = x; 2 = z).



const int IMAGE_WIDTH = 512;
const int IMAGE_HEIGHT = 512;


void Reflection::onPluginLoad()
{

    GLWidget &g = *glwidget();
    g.makeCurrent();
    // Resize to power-of-two viewport

    // Carregar shader, compile & link 
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile(glwidget()->getPluginPath()+"/../reflection/reflection.vert");
    //cout << "vs" << endl;

    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile(glwidget()->getPluginPath()+"/../reflection/reflection.frag");
    //cout << "fs" << endl;

    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    if (!program->isLinked()) cout << "Shader link error" << endl; 

    // Setup texture
    g.glActiveTexture(GL_TEXTURE0);
    g.glGenTextures( 1, &textureId[mode]);
    g.glBindTexture(GL_TEXTURE_2D, textureId[mode]);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR );
    g.glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    g.glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, IMAGE_WIDTH, IMAGE_HEIGHT, 0, GL_RGB, GL_FLOAT, NULL);

    // Camera
    g.resize(IMAGE_WIDTH,IMAGE_HEIGHT);

}


// TODO: update VBO coords after creation...
void Reflection::drawQuad(const Point& p0, const Point& p1, const Point& p2, const Point& p3)
{
    static bool created = false;
    static GLuint VAO_rect;
    GLWidget &g = *glwidget();
    g.makeCurrent();

    // 1. Create VBO Buffers
    if (!created)
    {
        created = true;        

        // Create & bind empty VAO
        g.glGenVertexArrays(1, &VAO_rect);
        g.glBindVertexArray(VAO_rect);

        // Create VBO with (x,y,z) coordinates
        float coords[] = { p0.x(), p0.y(), p0.z(), p1.x(), p1.y(), p1.z(), p3.x(), p3.y(), p3.z(), p2.x(), p2.y(), p2.z() };

        GLuint VBO_coords;
        g.glGenBuffers(1, &VBO_coords);
        g.glBindBuffer(GL_ARRAY_BUFFER, VBO_coords);
        g.glBufferData(GL_ARRAY_BUFFER, sizeof(coords), coords, GL_STATIC_DRAW);
        g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
        g.glEnableVertexAttribArray(0);
        //glBindVertexArray(0);

        float normals[] = { 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0};

        GLuint VBO_normals;
        g.glGenBuffers(1, &VBO_normals);
        g.glBindBuffer(GL_ARRAY_BUFFER, VBO_normals);
        g.glBufferData(GL_ARRAY_BUFFER, sizeof(normals), normals, GL_STATIC_DRAW);
        g.glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, 0);
        g.glEnableVertexAttribArray(1);
        g.glBindVertexArray(0);
    }

    // 2. Draw
    g.glBindVertexArray(VAO_rect);
    g.glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    g.glBindVertexArray(0);
}



bool Reflection::paintGL()
{
    // Pass 1. Build depth map
    GLWidget &g = *glwidget();
    g.makeCurrent();
    g.glClearColor(0.8,0.8,0.8,0);
    g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);


    //////////////////////////////////////////////////// Creem textura ////////////////////////////////////////////////////
    
    QMatrix4x4 reflection;
    if (mode == 0) { // Y
	    reflection.scale(1,-1,1); // I negativa = (Canviem de sentit? nose)
	    reflection.translate(0, -2*scene()->boundingBox().min().y(), 0);
    }
    else if (mode == 1) { // X
        reflection.scale(1,1,1); // I negativa = (Canviem de sentit? nose)
	    reflection.translate(2*scene()->boundingBox().min().x(), 0, 0);
    }
    else { // Z
        reflection.scale(1,1,1);
	    reflection.translate(0, 0, 2*scene()->boundingBox().min().z());
    }

    QMatrix4x4 CMVP = camera()->projectionMatrix() * camera()->viewMatrix() * reflection;
    g.defaultProgram()->setUniformValue("modelViewProjectionMatrix", CMVP); 
    // Draw scene 
    if (drawPlugin()) drawPlugin()->drawScene();
    // Get texture
    glBindTexture(GL_TEXTURE_2D, textureId[mode]);
    glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
    g.glGenerateMipmap(GL_TEXTURE_2D);


    //////////////////////////////////////////////////// Segons Z ////////////////////////////////////////////////////

    // Pass 2. Dibuixa l'escena
    g.glClearColor(1,1,1,0);
	g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
	g.defaultProgram()->setUniformValue("modelViewProjectionMatrix", 	
		camera()->projectionMatrix() * camera()->viewMatrix() );
	if (drawPlugin()) drawPlugin()->drawScene();


    // Pas3: Dibuix del quad nou
    Box b = scene()->boundingBox();
    program->bind();
    program->setUniformValue("colorMap", 0);
    program->setUniformValue("SIZE", float(IMAGE_WIDTH));  
    program->setUniformValue("modelViewProjectionMatrix", camera()->projectionMatrix() * camera()->viewMatrix() );

    // draw quad with texture
    float maxX = b.max().x();
    float maxY = b.max().y();
    float maxZ = b.max().z();
    float minX = b.min().x();
    float minY = b.min().y();
    float minZ = b.min().z();

	g.glBindTexture(GL_TEXTURE_2D, textureId[mode]);
    
	Point V0 = b.min();
	Point V1 = Point(maxX, minY, minZ);
	Point V2 = Point(maxX, minY, maxZ);
	Point V3 = Point(minX, minY, maxZ);   
    Point V4 = Point(minX, maxY, minZ);
    Point V5 = Point(minX, maxY, maxZ);
    Point V6 = Point(maxX, maxY, minZ);

    if (mode == 0) drawQuad(V0, V1, V2, V3);
    else if (mode == 1) drawQuad(V0, V4, V5, V3);
    else if (mode == 2) drawQuad(V0, V1, V6, V4);


    // restore state
    g.defaultProgram()->bind();
    g.glBindTexture(GL_TEXTURE_2D, 0);
    
    return true;
}

