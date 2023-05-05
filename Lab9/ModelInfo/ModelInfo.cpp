#include "ModelInfo.h"
#include "glwidget.h"

void ModelInfo::onPluginLoad()
{
	numVertices = 0;
	numObjects = scene()->objects().size();
	for(int i = 0; i < scene()->objects().size(); ++ i) {
		numVertices += scene()->objects()[i].vertices().size();
	}
	
}

void ModelInfo::preFrame()
{
	
}

void ModelInfo::postFrame()
{
	cout << "Number of objects: " << numObjects << endl;
	cout << "Number of vertices: " << numVertices << endl;
}

void ModelInfo::onObjectAdd()
{
	numObjects = scene()->objects().size();
	numVertices = 0;
	for(int i = 0; i < scene()->objects().size(); ++ i) {
		numVertices += scene()->objects()[i].vertices().size();
	}
}

void ModelInfo::onSceneClear()
{
	numObjects = 0;
	numVertices = 0;
}

bool ModelInfo::drawScene()
{
	return false; // return true only if implemented
}

bool ModelInfo::drawObject(int)
{
	return false; // return true only if implemented
}

bool ModelInfo::paintGL()
{
	return false; // return true only if implemented
}

void ModelInfo::keyPressEvent(QKeyEvent *)
{
	
}

void ModelInfo::mouseMoveEvent(QMouseEvent *)
{
	
}

