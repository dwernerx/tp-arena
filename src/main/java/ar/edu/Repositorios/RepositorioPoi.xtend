package ar.edu.Repositorios

import ar.edu.POIs.Poi
import ar.edu.usuario.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions

@Accessors
class RepositorioPoi extends RepoDefault<Poi> {

	static RepositorioPoi instance

	private new() {
	}

	static def getInstance() {
		if (instance == null) {
			instance = new RepositorioPoi
		}
		instance
	}

	def List<Poi> search(String valorBuscado) {
		allInstances().filter[o|o.matchearPoi(valorBuscado)].toList
		//add RepositorioCgp.instance.allInstances.search(valorBuscado)
	}

	def List<Poi> buscadorPoisPersonales(Usuario usuario) {
		var pois = this.allInstances()
		pois.forEach [ poi |
			poi.setDisponibilidad()
			poi.setPoiEstaCerca(usuario.ubicacion)
			poi.setDistancia(usuario.ubicacion)
			createOrUpdate(poi)
		]
		return pois
	}

	override getEntityType() {
		typeof(Poi)
	}

	override addQueryByExample(Criteria criteria, Poi poi) {
		if (poi.nombre != null) {
			criteria.add(Restrictions.eq("nombre", poi.nombre))
		}
	}

	def Poi searchById(Long id) {
		val session = openSession
		try {
			session.createCriteria(Poi)
//			.setFetchMode("pois", FetchMode.JOIN)
			.setFetchMode("palabraClave", FetchMode.JOIN)
			.setFetchMode("servicios", FetchMode.JOIN)
			.add(Restrictions.eq("id", id)).uniqueResult as Poi
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def Poi searchById(int id) {
		searchById(Long.valueOf(id))
	}


}
