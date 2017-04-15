package org.uqbar.geodds

import javax.persistence.OneToMany
import javax.persistence.CascadeType
import javax.persistence.FetchType
import java.util.List
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Id
import javax.persistence.GeneratedValue
import org.uqbar.commons.utils.Observable

@Observable
@Entity
@Accessors
class Poligono extends DecoradorDeSuperficie {

	@Id
	@GeneratedValue
	Long id

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	List<Punto> superficie
	
	new(){
		superficie = newArrayList
	}
	
	def add(Punto punto){
		super.add(new Point(punto.x,punto.y))
	}
	
	
	def isInside(Punto punto){
		super.isInside(new Point(punto.x,punto.y))
	}
	
}