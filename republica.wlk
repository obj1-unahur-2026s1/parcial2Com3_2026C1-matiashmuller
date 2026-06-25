import poderJudicial.*
object republica {
  const civiles = #{}
  const legisladores = #{}
  const partidoGobernante = new Partido(esAutoritario = true)

  method gastoTotalDietas() = legisladores.sum({ l => l.dieta() })
  method legisladorMasCaro() = legisladores.max({ l => l.dieta() })
  method legisladorQueVotaPositivo(unProyecto) {
    if (self.puedenVotarPositivo(unProyecto).isEmpty()) {
      self.error("No hay legislador que pueda votar positivo este proyecto.")
    }
    return self.puedenVotarPositivo(unProyecto).anyOne()
  }
  method puedenVotarPositivo(unProyecto) = legisladores.filter({ l => l.puedeVotarPositivo(unProyecto) })
  method existeRiesgoDeRebelion() = self.cantidadDePensantes() > self.cantidadDeCivilesAlergicos()
  method cantidadDePensantes() = civiles.count({ c => c.prefierePensar() })
  method cantidadDeCivilesAlergicos() = civiles.count({ c => c.esAlergico() })
  method esAutoritaria() = partidoGobernante.esAutoritario()

  method agregarCiviles(listaCiviles) { civiles.addAll(listaCiviles) }
  method agregarLegisladores(listaCiviles) { legisladores.addAll(listaCiviles) }
  
  method ponerOrden() {
    if (self.esAutoritaria() and self.existeRiesgoDeRebelion()) {
      civiles.forEach({ c => burro.intervenir(c) })
    }
  }
  method llevarProyectoAlCongreso(unProyecto) { legisladores.forEach({ l => l.votar(unProyecto) }) }
}

class Partido {
  const property esAutoritario
}

class ProyectoDeLey {
  const beneficiaAMagnate
  var cantidadPositivos = 0
  var cantidadNegativos = 0
  var cantidadAbstenciones = 0

  method beneficiaAMagnate() = beneficiaAMagnate
  method montoAdicional() = 5
  method fueAprobado() = cantidadPositivos > cantidadNegativos
  method sumarVotoPositivo() { cantidadPositivos += 1 }
  method sumarVotoNegativo() { cantidadNegativos += 1 }
  method sumarAbstencion() { cantidadAbstenciones += 1 }
}