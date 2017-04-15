package ar.edu.POIs

import ar.edu.Utilities.StringUtilities
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.ManyToMany
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import org.uqbar.geodds.Punto

@Entity
@Observable
@Accessors
@DiscriminatorValue("3")
class Cgp extends Poi {
	
	@OneToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)// Si LAZY para que cuando los metodos de este lo llamen lo pida y fue.Es cascada, porque la comuna pertenece a un cgp.
	Comuna comuna
	
//	@Transactional
	@ManyToMany(fetch = FetchType.LAZY)
//	@LazyCollection(LazyCollectionOption.FALSE)
	List<ServicioCGP> servicios = new ArrayList<ServicioCGP>

	new(Comuna _comuna, Direccion _miDireccion) {
		comuna = _comuna
		_direccion = _miDireccion
	}
	
	new() {}
	
	override getNombre(){
		comuna.numeroComuna
	}

	override estaCerca(Punto unPunto) {
		comuna.getZonaComuna.isInside(unPunto) || super.estaCerca(unPunto)
		// val point = new Point(unPunto.x, unPunto.y)
		// comuna.getZonaComuna.isInside(point) || super.estaCerca(unPunto)
	}

	override estaDisponible(DateTime momento) {
		servicios.exists[s|s.estaDisponible(momento)]
	}

	def boolean estaDisponible(DateTime momento, String valorBuscado) {
		servicios.exists[s|StringUtilities.match(s.nombre, valorBuscado) && s.estaDisponible(momento)]
	}

	override matchearPoi(String valorBuscado) {
		super.matchearPoi(valorBuscado) || StringUtilities.alMenosUnServicioComienzaCon(valorBuscado, servicios)|| matchearNombrePoi(valorBuscado)
	}

}
