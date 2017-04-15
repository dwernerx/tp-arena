package ar.edu.builder

import ar.edu.POIs.Cgp
import ar.edu.POIs.Comuna
import ar.edu.POIs.Direccion
import java.util.List
import ar.edu.visitas.Review
import ar.edu.POIs.ServicioCGP

class CGPBuilder {

	Cgp cgp

	new() {	
		cgp = new Cgp()
	}
	
	def Cgp build(){
		cgp
	}
	
	def CGPBuilder agregarComuna(Comuna comuna) {
		cgp.comuna = comuna
		cgp.palabrasClave.add(comuna.getNumeroComuna())
		this
	}

	def CGPBuilder agregarDireccion(Direccion direccion) {
		cgp._direccion = direccion
		this
	}
	
	def CGPBuilder agregarServicios(List<ServicioCGP> servicio) {
		cgp.servicios.addAll(servicio)
		this
	}

	def CGPBuilder agregarOpinion(Review opinion){
		cgp.calificacion.agregarReview(opinion)
		this
	}
	
	def CGPBuilder agregarOpiniones(List<Review> opiniones){
		cgp.calificacion.agregarReviews(opiniones)
		this
	}

}
