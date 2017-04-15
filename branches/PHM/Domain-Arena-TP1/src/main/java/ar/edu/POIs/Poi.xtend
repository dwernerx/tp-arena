package ar.edu.POIs

import ar.edu.Utilities.StringUtilities
import ar.edu.visitas.Calificacion
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.math.BigDecimal
import javax.persistence.CascadeType
import javax.persistence.CollectionTable
import javax.persistence.Column
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Punto
import java.util.Set
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption
import com.fasterxml.jackson.annotation.JsonIgnore

@Entity
@Observable
@Accessors
@JsonIgnoreProperties(ignoreUnknown = true)
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="TipoDePoi", discriminatorType=DiscriminatorType.INTEGER)

abstract class Poi{
	
	@Id
	@GeneratedValue
	private Long id
	
	@ManyToOne(cascade=CascadeType.ALL)//TODO (se tiene que cargar aparte en el boostrap)
	@JoinColumn(name="HORARIO_ID",nullable=true)
	HorarioDeAtencion horario
	
	@OneToOne(fetch=FetchType.LAZY,cascade=CascadeType.ALL)
	Direccion _direccion
	
	@ElementCollection
	@CollectionTable(name = "Palabras_Clave", joinColumns=@JoinColumn(name="id_poi"))
	@Column(name = "palabraClave")
	@LazyCollection(LazyCollectionOption.FALSE) //no probé con TRUE
	Set<String> palabrasClave = newHashSet
	
	@Column(length=150)
	String nombre
	
	@Column(length=150)
	String descripcion = ""
	
	@JsonIgnore // se puso esto para http://stackoverflow.com/questions/6346018/deserializing-json-into-object-with-overloaded-methods-using-jackson
	@Column
	BigDecimal distancia = new BigDecimal(0.00)
	
	@Column
//	Boolean cercania = false
	Boolean estaCerca = false   
	//estaCerca
	// la cambié a cercania porque en js la confunde con la funcion
	
	@Column
	Boolean disponibilidad = false
	
	@OneToOne(fetch=FetchType.LAZY,cascade=CascadeType.ALL)
	Calificacion calificacion = new Calificacion()
	
	@Column
	Boolean estaEnFavoritos
	
	@Column(length=150)
	String tipo = setTipoPoi
	
	@Column
	Boolean baja = false

	def getNombre() { nombre }

	def getDireccion() {
		_direccion.toString()
	}
	def getUbicacion(){
		_direccion.ubicacion
	}
	
	def getBarrio(){
		_direccion.barrio
	}

	def getDistancia(Punto gpsPosicion) {
		_direccion.getDistancia(gpsPosicion)
	}

	def boolean estaCerca(Punto unPunto) {
		getDistancia(unPunto) < 0.5
	}

	def boolean estaDisponible(DateTime momento) {
		horario.estaDisponible(momento)
	}

	def boolean matchearPoi(String valorBuscado) {
		StringUtilities.valorBuscadoEstaContenidoExactamenteEnPalabraClave(palabrasClave, valorBuscado)
	}

	def boolean matchearNombrePoi(String valorBuscado) {
		val nombrePoi= getNombre()
		StringUtilities.queComienceCon(valorBuscado, nombrePoi)
	}
	
	def void setDisponibilidad(){
		disponibilidad = this.estaDisponible(DateTime.now)
	}
	
	def void setPoiEstaCerca(Punto unPunto) { 
//		cercania = this.estaCerca(unPunto)
		estaCerca = this.estaCerca(unPunto)
	}
	
	def String setTipoPoi(){
		 this.getClass().getSimpleName().toString
	}
	
	def void setDistancia(Punto unPunto){
		distancia = new BigDecimal(this.getDistancia(unPunto))
	}
	
	def void setEstaEnFavoritos(Boolean estado){
		estaEnFavoritos = estado
	}
	
}
