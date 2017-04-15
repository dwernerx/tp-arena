package org.uqbar.geodds

interface Coordenadas {
	

	def abstract Point and(double aX, double aY)
	
	/**
	 * Indica la latitud del punto (su abscisa) es X
	 */
	def abstract double latitude()

	/**
	 * Indica la longitud del punto (su ordenada) es Y
	 */
	def abstract double longitude()

	/** 
	 * Distancia en kilómetros con respecto a otro punto
	 *  
	 * @author Internet
	 *  
	 **/
	def abstract double distance(Point anotherPoint)

	/**
	 * Conversión de un punto a radianes en base al ángulo que describe
	 */
	def abstract double toRadian(double angle)
	
	/**
	 * Conversión de un punto a grados en base al ángulo que describe
	 */
	def abstract double toDegree(double angle)

	def abstract double xIntersection(Point p1, Point p2)
	
	/**
	 * Indica si un punto está en el medio de dos puntos 
 	*/
	def abstract Boolean intersects(Point point, Point point2)

	/**
	 * Representación de un punto como un String
	 */
	override abstract String toString()
	
	
	/**
	 * Public accessors para que los puedan usar algun
	 * framework
	 */
	 
	def abstract double getX()
	
	def abstract void setX(double aX)
	
	def abstract double getY()

	def abstract void setY(double aY)
	
}