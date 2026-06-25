import republica.*
import poderJudicial.*

class Ciudadano {
  method denunciarAOtroCiudadano(ciudadano) {
    justicia.recibirDenunciaA(ciudadano)
  }
  method esInmune() = false
  method serIntervenido()
}

class Civil inherits Ciudadano {
  const hsDiariasEstudio
  const hsDiariasPropaganda
  const usaIAEnExceso

  method prefierePensar() = hsDiariasEstudio > hsDiariasPropaganda * 1.5
  method esAlergico() = !self.prefierePensar() and usaIAEnExceso
  override method serIntervenido() {
    if (!self.prefierePensar()) {
      burro.detener(self)
    } else {
      burro.incomunicarYTrasladar(self)
    } 
  }
}

class Mangate inherits Ciudadano {
  var patrimonio = 100

  override method esInmune() = true
  method deslomarse() { patrimonio += 10 * republica.cantidadDeCivilesAlergicos() }
  override method serIntervenido() { }
}

class Legislador inherits Ciudadano {
  
  method dieta() = 3
  method puedeVotarPositivo(unProyecto)
  method votarPositivo(unProyecto) { unProyecto.sumarVotoPositivo() }
  method votarNegativo(unProyecto) { unProyecto.sumarVotoNegativo() }
  method abstenerse(unProyecto) { unProyecto.sumarAbstencion() }
  method votar(unProyecto) {
    if (self.puedeVotarPositivo(unProyecto)) {
      self.votarPositivo(unProyecto)
    } else {
      self.votarNegativo(unProyecto)
    }
  }
  override method serIntervenido() { burro.demorar(self) }
}

class Reaccionario inherits Legislador {
  var dietaExtra = 5

  override method dieta() = super() + dietaExtra
  override method puedeVotarPositivo(unProyecto) = unProyecto.beneficiaAMagnate()

  override method votarPositivo(unProyecto) {
    super(unProyecto)
    dietaExtra += unProyecto.montoAdicional()
  }
  override method esInmune() = self.dieta() >= 10
}

class Moderado inherits Reaccionario {
  var nivelDeNetworking

  override method esInmune() = super() and nivelDeNetworking >= 20
  method deliberar(horas) { nivelDeNetworking = (nivelDeNetworking + 3*horas).min(20) }
  override method votar(unProyecto) {
    self.deliberar(2)
    super(unProyecto)
  }
}

class Vanguardista inherits Legislador {
  var estaPeleadx

  override method puedeVotarPositivo(unProyecto) = !unProyecto.beneficiaAMagnate()
  method cambiarDeHumor() { estaPeleadx = !estaPeleadx }
  override method votar(unProyecto) {
    if (estaPeleadx) { 
      self.abstenerse(unProyecto)
    } else {
      super(unProyecto)
    }
  }
  override method serIntervenido() { burro.incomunicarYTrasladar(self) }
}