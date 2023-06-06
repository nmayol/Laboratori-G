#ifndef _OBJECTESELECCIONAT_H
#define _OBJECTESELECCIONAT_H

#include "plugin.h" 
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>

class ObjecteSeleccionat: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	void onPluginLoad();
	void postFrame();

	QOpenGLShaderProgram* program;
	QOpenGLShader* vs;
	QOpenGLShader* fs;

	bool created=false;
	GLuint cubeVAO;
	GLuint verticesVBO;
	GLuint colorVBO;



  private:
	// add private methods and attributes here
};

#endif
