package org.uqbar.geodds

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Column

@Observable
@Accessors
@Entity
class Punto extends DecoradorDeCoordenadas {

	@Id
	@GeneratedValue
	private Long id

	@Column
	double x

	@Column
	double y

	new() {
	}

	new(double ax, double ay) {
		super(ax, ay)
		x = ax
		y = ay
	}

	def distance(Punto anotherPoint) {
		super.distance(new Point(anotherPoint.x, anotherPoint.y))
	}

	def intersects(Punto anotherPoint, Punto anotherAnotherPoint) {
		super.intersects(new Point(anotherPoint.x, anotherPoint.y), new Point(anotherAnotherPoint.x, anotherAnotherPoint.y) )

	}
}
