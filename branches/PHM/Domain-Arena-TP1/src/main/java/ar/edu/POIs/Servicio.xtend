package ar.edu.POIs

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.Table
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Table(name="Servicios_Banco")
@Accessors
@Inheritance(strategy=InheritanceType.TABLE_PER_CLASS)
class Servicio {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column
	String nombre //nombreServicio
	
	new(){}
		
	new(String _nombre) {	
		nombre = _nombre
	}

}
