package ar.edu.builder

import ar.edu.POIs.Banco
import ar.edu.POIs.Direccion
import ar.edu.POIs.HorarioDeAtencion
import ar.edu.POIs.Servicio
import ar.edu.visitas.Calificacion
import ar.edu.visitas.Review
import java.util.List

class BancoBuilder {

	Banco banco
	new() {
		banco =  new Banco()
	}
	
	def Banco build() {
		banco
	}
	
	def BancoBuilder agregarDireccion(Direccion direccion){
		banco._direccion = direccion
	this
	}	
	
	def BancoBuilder agregarHorarioBanco(HorarioDeAtencion horario){
		banco.horario = horario
		this
	}
		
	def BancoBuilder agregarNombre(String nombre) {
		banco.nombreBanco = nombre
		banco.palabrasClave.add(banco.nombreBancoMasBarrio())
		this
	}
	
	def BancoBuilder agregarServicios(List<Servicio> servicios){
		banco.servicios = servicios
		this
	}
	
	def BancoBuilder agregarOpinion(Review opinion){
		banco.calificacion.agregarReview(opinion)
		this
	}
	
	def BancoBuilder agregarOpiniones(List<Review> opiniones){
		banco.calificacion.agregarReviews(opiniones)
		this
	}
	def BancoBuilder agregarCalificacion(Calificacion calificacion){
		banco.calificacion = calificacion
		this
	}
}
