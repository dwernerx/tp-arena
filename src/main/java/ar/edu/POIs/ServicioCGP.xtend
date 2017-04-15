package ar.edu.POIs

import javax.persistence.CascadeType
import javax.persistence.Entity
import javax.persistence.ManyToOne
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.joda.time.DateTime

@Observable
@Accessors
@Entity
@Table(name="Servicios_CGP")
class ServicioCGP extends Servicio {
	
	@ManyToOne(cascade=CascadeType.ALL)//TODO no tiene que tener cascada
	HorarioDeAtencion horario

	new(String _nombreServicio, HorarioDeAtencion _horario) {
		super(_nombreServicio)
		horario = _horario
	}
	new(){}

	def boolean estaDisponible(DateTime momento) {
		horario.estaDisponible(momento)
	}
}
