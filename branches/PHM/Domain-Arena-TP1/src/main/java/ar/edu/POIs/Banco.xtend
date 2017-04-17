package ar.edu.POIs

import ar.edu.Utilities.StringUtilities
import java.util.List
import javax.persistence.Column
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.ManyToMany
import javax.persistence.FetchType
import org.hibernate.annotations.LazyCollectionOption
import org.hibernate.annotations.LazyCollection

@Entity
@Observable
@Accessors
@DiscriminatorValue("1")
class Banco extends Poi {

	@Column(length=50)
	String nombreBanco

	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToMany(fetch=FetchType.LAZY)
	List<Servicio> servicios = newArrayList

	override getNombre() {
		"Banco " + nombreBanco
	}

	new(Direccion _miDireccion, HorarioDeAtencion _horario, String _nombreBanco) {
		_direccion = _miDireccion
		horario = _horario
		nombreBanco = _nombreBanco
	}

	new() {
	}

	override matchearPoi(String valorBuscado) {
		StringUtilities.queComienceCon(valorBuscado, nombreBanco) || super.matchearPoi(valorBuscado) ||
			matchearNombrePoi(valorBuscado)
	}

	def String nombreBancoMasBarrio() {
		val nombreMasBarrio = nombreBanco + " " + getBarrio
		nombreMasBarrio
	}

	def String serviciosToString(){
			var listaNombreServicios = servicios.map[s|s.nombre].toList
			String.join("\n", listaNombreServicios)
	}

}
