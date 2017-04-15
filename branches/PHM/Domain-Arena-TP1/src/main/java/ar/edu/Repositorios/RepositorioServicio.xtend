package ar.edu.Repositorios

import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import ar.edu.POIs.Servicio

@Accessors
class RepositorioServicio extends RepoDefault<Servicio> {

	static RepositorioServicio instance

	private new() {
	}

	static def getInstance() {
		if (instance == null) {
			instance = new RepositorioServicio
		}
		instance
	}

	override getEntityType() {
		typeof(Servicio)
	}

	override addQueryByExample(Criteria criteria, Servicio servicio) {
		if (servicio.nombre != null) {
			criteria.add(Restrictions.eq("nombre", servicio.nombre))
		}

	}

}
