package ar.edu.builder

import ar.edu.POIs.Comuna
import org.uqbar.geodds.Poligono

class ComunaBuilder {

	Comuna comuna

	new() {
		comuna = new Comuna()
	}

	def Comuna build() {
		comuna
	}

	def ComunaBuilder agregarZonaComuna(Poligono zonaComuna) {
		comuna.zonaComuna = zonaComuna
		this
	}

	def ComunaBuilder agregarNumeroComuna(String numeroComuna) {
		comuna.numeroComuna = numeroComuna
		this
	}

}
