#include "objecteSeleccionatTeclat.h"
#include "glwidget.h"

void ObjecteSeleccionatTeclat::onPluginLoad()
{
	GLWidget &g = *glwidget();
    g.makeCurrent();

    // Carregar shader, compile & link 
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile(glwidget()->getPluginPath()+"/../objecteSeleccionatTeclat/objecteSeleccionatTeclat.vert");
    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile(glwidget()->getPluginPath()+"/../objecteSeleccionatTeclat/objecteSeleccionatTeclat.frag"); 

    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
	
}



void ObjecteSeleccionatTeclat::postFrame()
{
	program->bind();
    
    // crear buffers
    GLWidget& g = *glwidget();
    g.makeCurrent();

	int sel = scene()->selectedObject();
	cout << sel << endl;
	if (sel >= 0 && sel < (int) scene()->objects().size()) {
		program->bind();

		// Create buffers
		GLWidget& g = *glwidget();
		g.makeCurrent();
		if (!created) {
			created = true;

			GLfloat vertices[] = {
				0, 0, 0,
				0, 0, 1,
				0, 1, 0,

				0, 0, 1,
				0, 1, 0,
				0, 1, 1,

				1, 0, 0,
				1, 0, 1,
				1, 1, 0,

				1, 0, 1,
				1, 1, 0,
				1, 1, 1,

				0, 0, 0,
				0, 0, 1,
				1, 0, 0,

				0, 0, 1,
				1, 0, 0,
				1, 0, 1,

				0, 1, 0,
				0, 1, 1,
				1, 1, 0,

				0, 1, 1,
				1, 1, 0,
				1, 1, 1,

				0, 0, 0,
				0, 1, 0,
				1, 0, 0,

				0, 1, 0,
				1, 0, 0,
				1, 1, 0,

				0, 0, 1,
				0, 1, 1,
				1, 0, 1,

				0, 1, 1,
				1, 0, 1,
				1, 1, 1
			};

			// definim que el color del filferro sera vermell
			GLfloat colors[] = {1, 0, 0,  1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0	};

			// VA
			g.glGenVertexArrays(1, &cubeVAO);
			g.glBindVertexArray(cubeVAO);

			// VBOs Box
			g.glGenBuffers(1, &verticesVBO);
			g.glBindBuffer(GL_ARRAY_BUFFER, verticesVBO);
			g.glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
			g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
			g.glEnableVertexAttribArray(0);

			g.glGenBuffers(1, &colorVBO);
			g.glBindBuffer(GL_ARRAY_BUFFER, colorVBO);
			g.glBufferData(GL_ARRAY_BUFFER, sizeof(colors), colors, GL_STATIC_DRAW);
			g.glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, 0, 0);
			g.glEnableVertexAttribArray(2);

			g.glBindVertexArray(0);
		}

		QMatrix4x4 MVP=camera()->projectionMatrix()*camera()->viewMatrix();
    	program->setUniformValue("modelViewProjectionMatrix", MVP);
		
		const Object &obj = scene()->objects()[sel];
		program->setUniformValue("boundingBoxMin", obj.boundingBox().min());
		program->setUniformValue("boundingBoxMax", obj.boundingBox().max());
		g.glBindVertexArray(cubeVAO);
		g.glPolygonMode(GL_FRONT_AND_BACK, GL_LINE); // PER PINTAR EN FILFERROS
		g.glDrawArrays(GL_TRIANGLES, 0, 36);
		g.glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
		g.glBindVertexArray(0);
	}

}

void ObjecteSeleccionatTeclat::keyPressEvent(QKeyEvent*e)
{
	const vector<Object> &objs = scene()->objects();
	if (e->key() == Qt::Key_0 && objs.size() > 0) i = 0;
	if (e->key() == Qt::Key_1 && objs.size() > 1) i = 1;
	if (e->key() == Qt::Key_2 && objs.size() > 2) i = 2;
	if (e->key() == Qt::Key_3 && objs.size() > 3) i = 3;
	if (e->key() == Qt::Key_4 && objs.size() > 4) i = 4;
	if (e->key() == Qt::Key_5 && objs.size() > 5) i = 5;
	if (e->key() == Qt::Key_6 && objs.size() > 6) i = 6;
	if (e->key() == Qt::Key_7 && objs.size() > 7) i = 7;
	if (e->key() == Qt::Key_8 && objs.size() > 8) i = 8;
	if (e->key() == Qt::Key_9 && objs.size() > 9) i = 9;
	scene()->setSelectedObject(i);
	postFrame();

		
}

	

