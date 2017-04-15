package ar.edu.Repositorios

import ar.edu.usuario.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions
import org.uqbar.commons.model.UserException

@Accessors
class RepositorioUsuario extends  RepoDefault<Usuario> {

	static RepositorioUsuario instance

	private new() {
	}

	static def getInstance() {
		if (instance == null) {
			instance = new RepositorioUsuario
		}
		instance
	}

	def Usuario iniciarSesion(Usuario usuario) {
		val cuenta = usuario.cuenta
		val password = usuario.password

		if (cuenta.nullOrEmpty) {
			throw new UserException("Debe ingresar la cuenta")
		} else if (password.nullOrEmpty) {
			throw new UserException("Debe ingresar la clave")
		} else if (getListaUsuario(cuenta, password).isEmpty) {
			throw new UserException("Credenciales Incorrectas")
		} else {
			val usuarioExampliado = searchByExample(usuario).get(0)
			val usuarioPosta = searchById(usuarioExampliado.id)
			usuarioPosta
		}
	}

	def List<Usuario> getListaUsuario(String cuenta, String password) {
		allInstances().filter[u|u.verificarCuenta(cuenta, password)].toList
	}

	override getEntityType() {
		typeof(Usuario)
	}

	
	def Usuario searchById(Long id) {
		val session = openSession
		try {
			session.createCriteria(Usuario)
				.setFetchMode("listaFavoritos", FetchMode.JOIN)
				.setFetchMode("ubicacion", FetchMode.JOIN)
				.add(Restrictions.eq("id", id))
				.uniqueResult as Usuario
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
		

	def Usuario searchById(int id) {
		searchById(Long.valueOf(id))
	}

	override addQueryByExample(Criteria criteria, Usuario usuario) {
		if (usuario.cuenta != null) {
			criteria.add(Restrictions.eq("cuenta", usuario.cuenta))
		}
	}

}
