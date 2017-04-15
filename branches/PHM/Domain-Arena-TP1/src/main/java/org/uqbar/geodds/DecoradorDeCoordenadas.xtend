package org.uqbar.geodds

class DecoradorDeCoordenadas implements Coordenadas {
	
	Point point
	
	new() {}
	
	new(double x,double y){
		point = new Point(x,y)
	}
	
	override and(double aX, double aY) {
		point.and(aX,aY)
	}
	
	override latitude() {
		point.latitude
	}
	
	override longitude() {
		point.longitude
	}
	
	override distance(Point anotherPoint) {
		point.distance(anotherPoint)
	}
	
	override toRadian(double angle) {
		point.toRadian(angle)
	}
	
	override toDegree(double angle) {
		point.toDegree(angle)
	}
	
	override xIntersection(Point p1, Point p2) {
		point.xIntersection(p1,p2)
	}
	
	override intersects(Point point1, Point point2) {
		point.intersects(point1,point2)
	}
	
	override getX() {
		point.getX
	}
	
	override setX(double aX) {
		point.setX(aX)
	}
	
	override getY() {
		point.getY
	}
	
	override setY(double aY) {
		point.setY(aY)
	}
	
}