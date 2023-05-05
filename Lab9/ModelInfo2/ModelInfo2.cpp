#include "ModelInfo2.h"
#include "glwidget.h"

void ModelInfo2::onPluginLoad()
{
	numVertices = 0;
	numObjects = scene()->objects().size();
	for(int i = 0; i < scene()->objects().size(); ++ i) {
		numVertices += scene()->objects()[i].vertices().size();
	}
	
}

void ModelInfo2::preFrame()
{
	
}

void ModelInfo2::postFrame()
{
	QFont font;
  	font.setPixelSize(16);
  	painter.begin(glwidget());
  	painter.setFont(font);
  	int x = 15;
  	int y = 40;
  	painter.drawText(x, y, QString("Number of objects: ") + QString::number(numObjects));
	painter.drawText(x, y-20, QString("Number of vertices: ") + QString::number(numVertices));
  	painter.end();
	
}

void ModelInfo2::onObjectAdd()
{
	numObjects = scene()->objects().size();
	numVertices = 0;
	for(int i = 0; i < scene()->objects().size(); ++ i) {
		numVertices += scene()->objects()[i].vertices().size();
	}
}

void ModelInfo2::onSceneClear()
{
	numObjects = 0;
	numVertices = 0;
}

bool ModelInfo2::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo2::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo2::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo2::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo2::mouseMoveEvent(QMouseEvent *)
{
	
}

