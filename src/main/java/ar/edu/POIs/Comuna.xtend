package ar.edu.POIs

import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Poligono

@Entity
@Observable
@Accessors
class Comuna {
	@Id
	@GeneratedValue
	private Long id


	//LA IDEA ERA QUE FUESE LAZY :(
	@OneToOne(fetch=FetchType.EAGER, cascade=CascadeType.ALL) // Traigo el poligono cuando necesito saber la ubicacion, borro el poligono en cascada, solo pertenecen a este cgp.
	Poligono zonaComuna

	@Column
	String numeroComuna

	new(Poligono _comuna, String _numeroComuna) {
		zonaComuna = _comuna
		numeroComuna = _numeroComuna
	}

	new() {
	}

}
