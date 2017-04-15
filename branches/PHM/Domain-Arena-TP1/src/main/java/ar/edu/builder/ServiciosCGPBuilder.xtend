package ar.edu.builder

import ar.edu.POIs.HorarioDeAtencion
import ar.edu.POIs.ServicioCGP

class ServiciosCGPBuilder {

	ServicioCGP servicio

	new() {
		servicio = new ServicioCGP()
	}

	def ServicioCGP build() {
		servicio
	}

	def ServiciosCGPBuilder agregarHorario(HorarioDeAtencion horario) {
		servicio.horario = horario
		this
	}

	def ServiciosCGPBuilder agregarNombreServicio(String nombreServicio) {
		servicio.nombre = nombreServicio
		this
	}
}
