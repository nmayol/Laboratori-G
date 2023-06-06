#ifndef _OBJECTESELECCIONATTECLAT_H
#define _OBJECTESELECCIONATTECLAT_H

#include "plugin.h" 
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>

class ObjecteSeleccionatTeclat: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	void onPluginLoad();
	void postFrame();
	void keyPressEvent(QKeyEvent*e);

	QOpenGLShaderProgram* program;
	QOpenGLShader* vs;
	QOpenGLShader* fs;

	bool created = false;
	int i = 0;
	GLuint cubeVAO;
	GLuint verticesVBO;
	GLuint colorVBO;



  private:
	// add private methods and attributes here
};

#endif
