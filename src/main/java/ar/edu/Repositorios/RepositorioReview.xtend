package ar.edu.Repositorios

import ar.edu.visitas.Review
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

@Accessors
class RepositorioReview extends RepoDefault<Review> {
	

	static RepositorioReview instance

	private new() {
	}
static def getInstance() {
		if (instance == null) {
			instance = new RepositorioReview
		}
		instance
	}

	override getEntityType() {
		typeof(Review)
	}

	override addQueryByExample(Criteria criteria, Review review) {
		if (review.usuario != null) {
			criteria.add(Restrictions.eq("usuario", review.usuario))
		}

	}

}
