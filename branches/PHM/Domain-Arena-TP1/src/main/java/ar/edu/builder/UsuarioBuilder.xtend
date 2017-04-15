package ar.edu.builder

import ar.edu.usuario.Usuario
import org.uqbar.geodds.Punto

class UsuarioBuilder {

	Usuario usuario

	new() {
		usuario = new Usuario()
	}

	def Usuario build() {
		usuario
	}
	
	def UsuarioBuilder agregarCuenta(String cuenta){
		usuario.cuenta = cuenta
		this
	}
	
	def UsuarioBuilder agregarPassword(String password){
		usuario.password = password
		this
	}
	
	def UsuarioBuilder agregarUbicacion(Punto ubicacion){
		usuario.ubicacion = ubicacion
		this
	}

}
