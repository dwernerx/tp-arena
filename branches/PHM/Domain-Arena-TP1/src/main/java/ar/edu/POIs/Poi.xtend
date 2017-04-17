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
import javax.persistence.Transient

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
	
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)//EAGER porque todas las pantallas lo necesitan.Bah excepto la de login, al traer listaDeFavoritos.
	Direccion _direccion
	
	@ElementCollection
	@CollectionTable(name = "Palabras_Clave", joinColumns=@JoinColumn(name="id_poi"))
	@Column(name = "palabraClave")
	@LazyCollection(LazyCollectionOption.FALSE) //no probé con TRUE,//Se usa tmb en Cgp, ahi esta explicado el funcionamiento de la funcion en FALSE
	Set<String> palabrasClave = newHashSet
	
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	Calificacion calificacion = new Calificacion()
	
	@Column(length=150)
	String tipo = setTipoPoi
	
	@Column(length=150) // Es para matchear por nombre de poi (????)
	String nombre
	
	@Column(length=150) //Al pedo.
	String descripcion = ""
	
	/*
	 * baja : Esto es un atributo para el componenete de la base
	 */
	@Column
	Boolean baja = false
	
	/*
	 * estaCerca: atributo que se usa para el buscador en la vista de arena
	 * estaEnFavoritos: atributo que se usa para el buscador en la vista de arena
	 * NO se persisten, porque varian con cada usuario y poi. Para este tp no es necesario.
	 * distancia: Atributo que se usa para la vista del detalle de poi, dice a cuantos kilometros se encuentra.
	 * disponibilidad: Atributo que se usa en la pantalla de detalles, para ver si se encuentra en el horario actual,abierto,                                                     como tu vieja.
	 */
	 
	//@JsonIgnore // se puso esto para http://stackoverflow.com/questions/6346018/deserializing-json-into-object-with-overloaded-methods-using-jackson
	//@Column
	@Transient
	BigDecimal distancia = new BigDecimal(0.00)
	@Transient
	Boolean estaCerca
	@Transient
	Boolean estaEnFavoritos
	@Transient
	Boolean disponibilidad = false
	

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
		StringUtilities.queComienceCon(valorBuscado, getNombre())
	}
	
	def void setDisponibilidad(){
		disponibilidad = this.estaDisponible(DateTime.now)
	}
	
	def void setPoiEstaCerca(Punto unPunto) {  //Metodo para actualizar la cercania en la pantalla de Buscador.
		estaCerca = estaCerca(unPunto)
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
