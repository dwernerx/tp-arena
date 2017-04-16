package ar.edu.POIs

import ar.edu.Utilities.StringUtilities
import javax.persistence.Column
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Punto

@Entity
@Observable
@Accessors
@DiscriminatorValue("4")
class LocalComercial extends Poi {
	
	@ManyToOne(fetch=FetchType.EAGER)//Lo necesito siempre para mostrar por pantalla el nombre que uso en getNombre papu.
	Rubro rubro
	
	@Column(length=150)
	String nombre

	new(Direccion _miDireccion, String _nombre, HorarioDeAtencion _horario, Rubro _rubro) {
		_direccion = _miDireccion
		rubro = _rubro
		nombre = _nombre
		horario = _horario
	}
	
	new() {	}
	
	override getNombre(){
		rubro.nombre + " " + nombre
	}

	override estaCerca(Punto unPunto) {
		getDistancia(unPunto) < rubro.getCercania()
	}

	override matchearPoi(String valorBuscado) {
		StringUtilities.queComienceCon(valorBuscado, nombre) ||
		super.matchearPoi(valorBuscado)||
		StringUtilities.match(rubro.getNombre, valorBuscado)|| matchearNombrePoi(valorBuscado)
		}

}
