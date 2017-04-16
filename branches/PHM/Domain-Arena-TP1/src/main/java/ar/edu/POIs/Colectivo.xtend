package ar.edu.POIs

import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import ar.edu.Utilities.StringUtilities
import org.uqbar.geodds.Punto
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption

@Entity
@Observable
@Accessors
@DiscriminatorValue("2")
class Colectivo extends Poi {
	@Column(length=20)
	String linea
	
	@LazyCollection(LazyCollectionOption.FALSE)//MALO MUY MALO PERO FUNCA, EAGER NO SIRVE...
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	List<Punto> recorrido = new ArrayList<Punto>

	new(String _linea) {
		linea = _linea
	}

	new() {
	}

	override getNombre() {
		"Linea " + linea
	}

	override getDireccion() {
		""
	}

	override getDistancia(Punto gpsPosicion) {
		puntoMasCerca(recorrido, gpsPosicion).distance(gpsPosicion)
	}

	def Punto puntoMasCerca(List<Punto> recorrido, Punto unPunto) {
		(recorrido.sortBy[parada|parada.distance(unPunto)]).get(0)

	}

	def void addParada(double x, double y) {
		recorrido.add(new Punto(x, y))
		recorrido.get(0)
	}

	override estaCerca(Punto unPunto) {
		recorrido.exists[parada|cercaniaParada(unPunto, parada)]
	}

	override estaDisponible(DateTime momento) {
		true
	}

	override matchearPoi(String valorBuscado) {
		StringUtilities.queComienceCon(valorBuscado, linea) || matchearNombrePoi(valorBuscado)
	}

	def boolean cercaniaParada(Punto unPunto, Punto parada) {
		parada.distance(unPunto) < 0.1
	}

}
