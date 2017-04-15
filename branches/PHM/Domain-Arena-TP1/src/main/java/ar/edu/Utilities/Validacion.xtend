package ar.edu.Utilities

import ar.edu.Utilities.BussinessException
import ar.edu.POIs.Colectivo
import ar.edu.POIs.Poi

class Validacion {
	
	def static general(Poi poi) {
		if (poi.ubicacion.equals(null)) {
			throw new BussinessException("No tiene direccion asignada.")
		}
	}
	
	def static colectivo(Colectivo colectivo){
		if (colectivo.linea.equals(null)){
			throw new BussinessException("No pertenece a una Linea de colectivo.")
		}
	}
	
}