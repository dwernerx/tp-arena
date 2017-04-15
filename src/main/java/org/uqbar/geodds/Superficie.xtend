package org.uqbar.geodds

interface Superficie {
	

	def abstract void add(Point point)

	/**
	 * Convierte un punto a un polígono conformado inicialmente por este punto. <br>
	 * No compatible con la idea de un polígono inmutable.<br>
	 */
	def abstract void asPolygon(Point point)

	/**
	 * Determina si un punto está dentro de un polígono
	 * Para la explicación véase http://erich.realtimerendering.com/ptinpoly/
	 * @Deprecated Usar isInside
	 */
	def abstract Boolean isInsideOld(Point point)

	/**
	 * Función mejorada para determinar si un punto está en el polígono
	 */
	def abstract Boolean isInside(Point point)

	/**
	 * Indica si un punto es alguno de los vértices del polígono
	 */
	def abstract Boolean pointOnVertex(Point point)

}