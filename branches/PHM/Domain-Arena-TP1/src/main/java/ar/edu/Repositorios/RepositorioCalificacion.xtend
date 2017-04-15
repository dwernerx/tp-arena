package ar.edu.Repositorios

import ar.edu.visitas.Calificacion
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

@Accessors
class RepositorioCalificacion extends RepoDefault<Calificacion> {
	

	static RepositorioCalificacion instance

	private new() {
	}
static def getInstance() {
		if (instance == null) {
			instance = new RepositorioCalificacion
		}
		instance
	}

	override getEntityType() {
		typeof(Calificacion)
	}

//	override addQueryByExample(Criteria criteria, Calificacion calificacion) {
//		if (calificacion.listaReview != null) {											//aca no se si esta bien!!!!!!!!!!!!!!!
//			criteria.add(Restrictions.eq("listaReview", calificacion.listaReview))
//		}
override addQueryByExample(Criteria criteria, Calificacion calificacion) {
		if (calificacion.listaReview.size != 0) {
			criteria.add(Restrictions.eq("id", calificacion.id))
		}
	}

}
