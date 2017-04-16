package ar.edu.usuario

import ar.edu.POIs.Poi
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.Repositorios.RepositorioPoi
import javax.persistence.ManyToMany
import org.uqbar.geodds.Punto

@Entity
@Accessors
@JsonIgnoreProperties(ignoreUnknown=true)
class Usuario {

	@Id
	@GeneratedValue
	private Long id

	@Column(length=150)
	String cuenta

	@Column(length=150)
	String password

    @ManyToMany(fetch=FetchType.LAZY)
	List<Poi> listaFavoritos = newArrayList

	@OneToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	Punto ubicacion

	new() {
	}

	new(Long _id) {
		id = _id
	}
	
	new(String _cuenta, String _password) {
		this.cuenta = _cuenta
		this.password = _password
	}

	new(String _cuenta, String _password, Punto _ubicacion) {
		this.cuenta = _cuenta
		this.password = _password
		this.ubicacion = _ubicacion
	}

	/** para web **/
	new(String _cuenta, String _password, Integer _id, Punto _ubicacion) {
		this.cuenta = _cuenta
		this.password = _password
		this.id = id
		this.ubicacion = _ubicacion
	}


//	def void actualizarListaFavoritos(Long poiID) {
//		val id = poiID.toString()
//		if (listaFavoritos.contains(id)) {
//			eliminarPoiFavorito(id)
//		} else {
//			//TODO //agregarPoiFavorito(id) // Esto y todos los metodos que use String tienen que cambiar a Poi, en poi controller, utlitiesDetallesPoi y aca en Usuario, para poder usar la Lista de favoritos
//		}
//	}

	def eliminarPoiFavorito(Poi poi) {
		listaFavoritos.remove(poi)
	}

	def agregarPoiFavorito(Poi poi) {
		listaFavoritos.add(poi)
	}

	/**Login */
	def boolean verificarCuenta(String cuenta, String password) {
		this.cuenta == cuenta && this.password == password
	}

	def Poi searchPoiFavoritoById( /*int*/ Long id) {
		RepositorioPoi.instance.searchById(id)
	}
	
	def boolean poiEstaEnFavoritos(Poi poiAVerificar) { // TODO le pongo get por si lo usamos de propiedad //ño D:
		listaFavoritos.contains(poiAVerificar)
	}

}
