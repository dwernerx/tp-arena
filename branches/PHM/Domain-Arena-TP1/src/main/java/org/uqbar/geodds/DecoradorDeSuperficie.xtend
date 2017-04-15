package org.uqbar.geodds

class DecoradorDeSuperficie implements Superficie {
	
	Polygon polygon
	
	new() {
		polygon = new Polygon()
	}
	
	override add(Point point){
		polygon.add(point)
	}

	override asPolygon(Point point){
		polygon.asPolygon(point)
	}

	override isInsideOld(Point point){
		polygon.isInsideOld(point)
	}

	override isInside(Point point){
		polygon.isInside(point)
	}

	override pointOnVertex(Point point){
		polygon.pointOnVertex(point)
	}
	
}