package ar.edu.Repositorios

import ar.edu.POIs.Rubro
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

@Accessors
class RepositorioRubro extends RepoDefault<Rubro> {

	static RepositorioRubro instance

	private new() {
	}

	static def getInstance() {
		if (instance == null) {
			instance = new RepositorioRubro
		}
		instance
	}

	override getEntityType() {
		typeof(Rubro)
	}

	override addQueryByExample(Criteria criteria, Rubro rubro) {
		if (rubro.nombre != null) {
			criteria.add(Restrictions.eq("nombre", rubro.nombre))
		}

	}

}
