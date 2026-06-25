object justicia {
  const procesados = []

  method recibirDenunciaA(ciudadano) {
    if (!ciudadano.esInmune()) {
      procesados.add(ciudadano)
      burro.intervenir(ciudadano)
    }
  }
}

object burro {
  const detenidos = []
  const rebeldes = []

  method intervenir(ciudadano) { ciudadano.serIntervenido() }
  method detener(ciudadano) { detenidos.add(ciudadano) }
  method incomunicarYTrasladar(ciudadano) { rebeldes.add(ciudadano) }
  method demorar(ciudadano) { detenidos.add(ciudadano); detenidos.remove(ciudadano) }
}