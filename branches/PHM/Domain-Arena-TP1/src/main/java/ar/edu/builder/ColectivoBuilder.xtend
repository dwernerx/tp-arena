package ar.edu.builder

import ar.edu.POIs.Colectivo
import ar.edu.Utilities.BuildException
import ar.edu.visitas.Calificacion
import ar.edu.visitas.Review
import java.util.List

class ColectivoBuilder {

	Colectivo colectivo

	new() {
		colectivo = new Colectivo()
	}

	def Colectivo build() {
		if (colectivo.recorrido.size() == 0) { 						// *Validacion
			throw new BuildException("Colectivo sin paradas")
		}
		if (colectivo.linea == null) {
			throw new BuildException("Colectivo sin Linea")
		} 															
		colectivo
	}

	def ColectivoBuilder agregarNombre(String nombre) {
		colectivo.linea = nombre
		colectivo.palabrasClave.add(nombre)
		this
	}

	def ColectivoBuilder agregarParada(double x, double y) {
		colectivo.addParada(x, y)
		this
	}
	
	def ColectivoBuilder agregarOpinion(Review opinion){
		colectivo.calificacion.agregarReview(opinion)
		this
	}
	
	def ColectivoBuilder agregarOpiniones(List<Review> opiniones){
		colectivo.calificacion.agregarReviews(opiniones)
		this
	}
	def ColectivoBuilder agregarCalificacion(Calificacion calificacion){
		colectivo.calificacion = calificacion
		this
	}
}
