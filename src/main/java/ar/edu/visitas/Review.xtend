package ar.edu.visitas

import ar.edu.usuario.Usuario
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Observable
@Accessors
//@JsonIgnoreProperties(ignoreUnknown = true)
class Review {
	@Id
	@GeneratedValue
	private Long id
	
	@ManyToOne(fetch=FetchType.EAGER) //TODO no tiene que ser cascada, hay que hacer repo Review.
	Usuario usuario
	
	@Column
	String comentario
	
	@Column
	int puntuacion
	
	new(){}
	
	new(Usuario _usuario, String _comentario, int _puntuacion){
		usuario = _usuario
		comentario = _comentario
		puntuacion = _puntuacion
	}
	def getNombreDeUsuario(){
		usuario.getCuenta
	}
}
