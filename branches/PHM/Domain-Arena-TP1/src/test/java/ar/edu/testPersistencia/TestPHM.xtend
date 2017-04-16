package ar.edu.testPersistencia

import ar.edu.POIs.Banco
import ar.edu.POIs.Cgp
import ar.edu.POIs.Colectivo
import ar.edu.POIs.Comuna
import ar.edu.POIs.Direccion
import ar.edu.POIs.HorarioDeAtencion
import ar.edu.POIs.LocalComercial
import ar.edu.POIs.Poi
import ar.edu.POIs.Rubro
import ar.edu.POIs.Servicio
import ar.edu.POIs.ServicioCGP
import ar.edu.Repositorios.RepositorioCalificacion
import ar.edu.Repositorios.RepositorioPoi
import ar.edu.Repositorios.RepositorioReview
import ar.edu.Repositorios.RepositorioRubro
import ar.edu.Repositorios.RepositorioServicio
import ar.edu.Repositorios.RepositorioUsuario
import ar.edu.builder.BancoBuilder
import ar.edu.builder.ColectivoBuilder
import ar.edu.builder.DireccionBuilder
import ar.edu.builder.HorarioDeAtencionBuilder
import ar.edu.builder.LocalComercialBuilder
import ar.edu.usuario.Usuario
import ar.edu.visitas.Calificacion
import ar.edu.visitas.Review
import java.util.Arrays
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration
import org.joda.time.LocalTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.geodds.Point
import org.uqbar.geodds.Poligono
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Punto

class TestPHM {
	

	Poligono poligono1
	Calificacion calificacion1
	Calificacion calificacion2
	Servicio deposito
	Review opinion1
	Review opinion2
	Rubro rubroVerduleria
	Usuario admin
	Cgp sedeComuna1
	Colectivo colectivo78
	Banco bancoSantander
	LocalComercial verduleriaManolo
	RepositorioRubro repositorioRubro
	RepositorioServicio repositorioServicio
	RepositorioUsuario repositorioUsuario
	RepositorioPoi repositorioPoi
	RepositorioReview repositorioReview
	RepositorioCalificacion repositorioCalificacion
	
		SessionFactory sessionFactoryTest = new Configuration().configure("/ar/edu/testPersistencia/testPoi.cfg.xml").addAnnotatedClass(Poi).
		addAnnotatedClass(Direccion).addAnnotatedClass(Banco).addAnnotatedClass(Colectivo).addAnnotatedClass(Cgp).
		addAnnotatedClass(LocalComercial).addAnnotatedClass(Comuna).addAnnotatedClass(HorarioDeAtencion).
		addAnnotatedClass(Rubro).addAnnotatedClass(Servicio).addAnnotatedClass(Usuario).addAnnotatedClass(Calificacion).
		addAnnotatedClass(Servicio).addAnnotatedClass(ServicioCGP).addAnnotatedClass(Review).addAnnotatedClass(Point).
		addAnnotatedClass(Polygon).addAnnotatedClass(Poligono).addAnnotatedClass(Punto).buildSessionFactory()
	@Before
	def void init() {
	
		repositorioRubro = RepositorioRubro.instance
		repositorioServicio = RepositorioServicio.instance
		repositorioUsuario = RepositorioUsuario.instance
		repositorioPoi = RepositorioPoi.instance
		repositorioReview = RepositorioReview.instance
		repositorioCalificacion = RepositorioCalificacion.instance
		
		
		ApplicationContext.instance.configureSingleton(typeof(Usuario), RepositorioUsuario.instance)
		ApplicationContext.instance.configureSingleton(typeof(Rubro), RepositorioRubro.instance)
		ApplicationContext.instance.configureSingleton(typeof(Servicio), RepositorioServicio.instance)
		ApplicationContext.instance.configureSingleton(typeof(Review), RepositorioReview.instance)
		ApplicationContext.instance.configureSingleton(typeof(Calificacion), RepositorioCalificacion.instance)
		ApplicationContext.instance.configureSingleton(typeof(Poi), RepositorioPoi.instance)


		crearUsuarios()
		crearReviews()
		crearCalificaciones() 	
		crearColectivos()
		crearBancos()
		crearLocalesComerciales()
		crearCGPs()		
		agregarPoisFavoritosAUsuarios() 
		}

		
	def void crearUsuario(Usuario usuario){
			val repoUsuario = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepositorioUsuario
			val listaUsuario = repoUsuario.searchByExample(usuario)
				if (listaUsuario.isEmpty) {
				repoUsuario.createOrUpdate(usuario)
				println("Usuario " + usuario.cuenta + " creado")
			} else {
				val usuarioBD = listaUsuario.head
				usuario.id = usuarioBD.id
				repoUsuario.createOrUpdate(usuario)
			}
		}

	def void crearRubros(Rubro rubro){
			val repoRubro = ApplicationContext.instance.getSingleton(typeof(Rubro)) as RepositorioRubro
			val listaRubro = repoRubro.searchByExample(rubro)
				if (listaRubro.isEmpty) {
				repoRubro.createOrUpdate(rubro)
				println("Rubro " + rubro.nombre + " creado")
			} else {
				val rubroBD = listaRubro.head
				rubro.id = rubroBD.id
				repoRubro.createOrUpdate(rubro)
			}
		}
		
	def void crearServicio(Servicio servicio){
			val repoServicio = ApplicationContext.instance.getSingleton(typeof(Servicio)) as RepositorioServicio
			val listaServicio = repoServicio.searchByExample(servicio)
				if (listaServicio.isEmpty) {
				repoServicio.createOrUpdate(servicio)
				println("Servicio " + servicio.nombre + " creado")
			} else {
				val servicioBD = listaServicio.head
				servicio.id = servicioBD.id
				repoServicio.createOrUpdate(servicio)
			}
		}
		
	def void crearPoi(Poi poi) {
			val repoPoi = ApplicationContext.instance.getSingleton(typeof(Poi)) as RepositorioPoi
			val listaPoi = repoPoi.searchByExample(poi)
			if (listaPoi.isEmpty) {
				repoPoi.createOrUpdate(poi)
				println("Poi " + poi.nombre +  " creado")
			} else {
				val poiBD = listaPoi.head
				poi.id = poiBD.id
				repoPoi.createOrUpdate(poi)
			}
	}
	
	def void agregarPoiFavorito(Usuario usuario, Poi poi) {
			val repoFavorito = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepositorioUsuario
			val listaFavorito = repoFavorito.searchByExample(usuario)
				val favoritoBD = listaFavorito.head
				usuario.id = favoritoBD.id
				usuario.agregarPoiFavorito(poi)
				repoFavorito.createOrUpdate(usuario)
	}
	
	def void crearReview(Review review) {
			val repoReview = ApplicationContext.instance.getSingleton(typeof(Review)) as RepositorioReview
				repoReview.createOrUpdate(review)

	}
	
	def void crearCalificacion(Calificacion calificacion) {
			val repoCalificacion = ApplicationContext.instance.getSingleton(typeof(Calificacion)) as RepositorioCalificacion
			val listaCalificacion = repoCalificacion.searchByExample(calificacion)
			if (listaCalificacion.isEmpty) {
				repoCalificacion.createOrUpdate(calificacion)
				println("Calificacion " + /*calificacion.nombre +*/  " creada")
			} else {
				val calificacionBD = listaCalificacion.head
				calificacion.id = calificacionBD.id
				repoCalificacion.createOrUpdate(calificacion)
			}
	}
	
	def void crearUsuarios() {
		
		admin = new Usuario("admin", "admin", new Punto(-34.579100, -58.528108))
		crearUsuario(admin)
		}
			
	def void crearColectivos() {

		colectivo78 = new ColectivoBuilder()
			.agregarNombre("78")
			.agregarParada(-34.570444, -58.538289)
			.agregarParada(-34.578555, -58.528354)
			.agregarParada(-34.568666, -58.542023)
			.agregarCalificacion(calificacion1)
			.build
			crearPoi(colectivo78)
	}

	def void crearBancos() {
		deposito = new Servicio("Depósitos")
		crearServicio(deposito)

		bancoSantander = new BancoBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.565000, -58.542023).agregarCalle("Rondeau").
				agregarEntreCalle1("Av Primavera").agregarEntreCalle2("6 de Julio").agregarNumero(250).
				agregarCodigoPostal(1650).agregarLocalidad("San Martin").agregarBarrio("San Martin").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorarioBanco(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(10, 0, 0)).agregarHoraFin(new LocalTime(15, 0, 0)).build)
			.agregarNombre("Santander")
			.agregarServicios(#[deposito])
			.agregarCalificacion(calificacion2)
			.build
			crearPoi(bancoSantander)
		}

	def void crearLocalesComerciales() {
		
		rubroVerduleria = new Rubro("Verduleria", 0.4)
		crearRubros(rubroVerduleria)
		verduleriaManolo = new LocalComercialBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.579999, -58.521234).agregarCalle("Quirno").
				agregarEntreCalle1("Bolivia").agregarEntreCalle2("San Pedrito").agregarNumero(343).
				agregarCodigoPostal(1650).agregarLocalidad("Flores").agregarBarrio("C.A.B.A").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorario(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(8, 0, 0)).agregarHoraFin(new LocalTime(17, 0, 0)).build)
			.agregarNombre("Don Manolo")
			.agregarRubro(rubroVerduleria)
			.agregarPalabrasClave(Arrays.asList("Maracuya", "Mango", "Melon", "Cereza"))
			//.agregarCalificacion(calificacion2)
			.build
				crearPoi(verduleriaManolo)
				}

	def void crearCGPs() {

			poligono1 = new Poligono() =>[
				add(new Punto(-34.577777, -58.528354))
				add(new Punto(-34.578555, -58.528974))
				add(new Punto(-34.578555, -58.528974))
				add(new Punto(-34.599284, -58.386868))
				add(new Punto(-34.579900, -58.528354))
			]
		val comuna1 = new Comuna(poligono1, "CGP Comuna 1")
		
		val direccionComuna1 = new Direccion(new Punto(-107.567801, -128.397822), "La Paz", "Bolivia", "Paraguay", 281,
			1986, "Altamirano", "Buenos Aires", "Buenos Aires", "Argentina")

		val horarioServicioRentas = new HorarioDeAtencion(new LocalTime(7, 30, 0), new LocalTime(15, 30, 0))
		val rentas = new ServicioCGP("Rentas", horarioServicioRentas)
		crearServicio(rentas)
		sedeComuna1 = new Cgp(comuna1, direccionComuna1)
		sedeComuna1.servicios.addAll(Arrays.asList(rentas))
		
		//sedeComuna1.calificacion = calificacion4
		crearPoi(sedeComuna1)
			
	}

	def void agregarPoisFavoritosAUsuarios() {

	agregarPoiFavorito(admin,bancoSantander)
	agregarPoiFavorito(admin,colectivo78)
	}

	def void crearReviews(){
		
		opinion1 = new Review(admin, "Que buen Poi pero le pongo 1", 1)
		opinion2 = new Review(admin, "No me gusto el lugar", 2)
		crearReview(opinion1)
		crearReview(opinion2)
			}
	
	def void crearCalificaciones() {

		calificacion1 = new Calificacion()=>[
			agregarReview(opinion1)
			agregarReview(opinion2)
		]
		calificacion2 = new Calificacion()=>[
			agregarReview(opinion1)
	

		crearCalificacion(calificacion1)
		crearCalificacion(calificacion2)
	]
	
	}


//------------------- TESTS--------------------------// 

//FUNCIONANDO

//@Test
//	def void poiBancoSantanderEnLaBD(){
//		var bancoBD = repositorioPoi.searchById(bancoSantander.id)
//		Assert.assertEquals(this.bancoSantander.nombre, bancoBD.nombre)		
//	}
//@Test
//	def void elBancoSeLlamaSantander(){ 
//		var bancoBD = repositorioPoi.searchById(bancoSantander.id)
//		Assert.assertEquals(bancoBD.nombre,"Banco Santander")		
//}
//@Test
//	def void poiVerduleriaEnLaBD(){
//		var verduDB = repositorioPoi.searchById(verduleriaManolo.id)
//		Assert.assertEquals(this.verduleriaManolo.nombre, verduDB.nombre)		
//	}

//@Test
//	def void elLocalComercialSeLlamaVerduleriaManolo(){ 
//		var verduleriaManoloBD = repositorioPoi.searchById(verduleriaManolo.id)
//		Assert.assertEquals(verduleriaManoloBD.nombre,"Verduleria Don Manolo")		
//}

////Modificacion de un Poi	
//@Test
//	def void cambioDeNombreVerduleriaManoloEnBD(){ 
//		var verduleriaManoloBD = repositorioPoi.searchById(verduleriaManolo.id)
//		verduleriaManoloBD.setNombre("Jacinto")
//		repositorioPoi.createOrUpdate(verduleriaManoloBD)
//		Assert.assertEquals(verduleriaManoloBD.nombre,"Verduleria Jacinto")
//}

//FUNCIONAN CON EAGER EN CALIFICACION Y REVIEW	
@Test
	def void agregarUnReview(){ 
		var colectivo78BD = repositorioPoi.searchById(colectivo78.id)
			colectivo78BD.calificacion.agregarReview(opinion2)	
		var cantidadDeReviews = colectivo78BD.calificacion.cantidadDeReview
		Assert.assertEquals(cantidadDeReviews,3)		
}
@Test
	def void cantidadDeReviews(){ 
		var colectivo78BD = repositorioPoi.searchById(bancoSantander.id)
		var cantidadDeReviews = colectivo78BD.calificacion.cantidadDeReview
		Assert.assertEquals(cantidadDeReviews,2)		
}
//---------------------------------------------------------------------	


//DA ERROR DE CONSTRAIN
//@Test
//	def void poiDadoDeBaja(){
//		var bancoBD = repositorioPoi.searchById(bancoSantander.id)
//		repositorioPoi.remove(bancoBD)
//		Assert.assertEquals(null,(repositorioPoi.searchById(bancoSantander.id)))
//	}


//INTETOS DE FECHMODE JOIN PARA EVITAR EAGER

//@Test
//	def void cantidadDeReviews(){ 
//		var colectivo78BD = repositorioPoi.searchById(bancoSantander.id)
//		val session = repositorioCalificacion.openSession
//		try {
//			session.createCriteria(Calificacion)
//			.setFetchMode("calificacion", FetchMode.JOIN)
//			//.add(Restrictions.eq("id", id))
//		//	.uniqueResult as Calificacion
//		} catch (HibernateException e) {
//			throw new RuntimeException(e)
//		} finally {
//			
//			
//			}
//		val session2 = repositorioReview.openSession
//		try {
//			session2.createCriteria(Review)
//			.setFetchMode("review", FetchMode.JOIN)
//		//	.uniqueResult as Review
//		} catch (HibernateException e) {
//			throw new RuntimeException(e)
//		} finally {
//		var cantidadDeReviews = colectivo78BD.calificacion.cantidadDeReview
//		Assert.assertEquals(cantidadDeReviews,2)		
//			session2.close
//			session.close
//		}
//}

}

