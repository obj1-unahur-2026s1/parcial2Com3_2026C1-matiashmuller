# Parcial 2 - Comision 3
## Programación con Objetos 1 UNAHUR - 2026C1

- **APELLIDO, NOMBRE:**
- **DNI:**

## Criterio de evaluación

Se evaluará su solución prestando especial atención a:

- Pautas obligatorias (descritas abajo) correctamente cumplidas.
- Entendimiento y correcta aplicación de los conceptos vistos en la cursada: Objeto, mensaje, polimorfismo, colecciones, bloques, referencias, clases, herencia y tests unitarios.
- Correcto uso de recursos del lenguaje, como el atajo `property` y los métodos predefinidos disponibles para los distintos tipos de objetos.
- Prolijidad y legibilidad del código presentado.

## Pautas obligatorias para la entrega

Utilizaremos un sistema de 4 "checkpoints", a saber:

- **Checkpoint 1:** Push inicial. Clonar el repositorio remoto, modificar este archivo en la parte superior completando APELLIDO, NOMBRE y DNI con sus datos, y hacer un primer push.
- **Checkpoint 2:** Push a las 19hs.
- **Checkpoint 3:** Push a las 20hs.
- **Checkpoint 4:** Push final de entrega al terminar.

Este es el mínimo requerido, pero puede (y es recomendable) hacer más pushes para estar cubiert@ ante cualquier imprevisto. El último push es lo que se corrige.

## Estructura de archivos obligatoria

- Archivo `republica.wlk`
- Archivo `ciudadanos.wlk`
- Archivo `poderJudicial.wlk`
- Archivo `republicaTest.wtest`

---

# SimuNación

## Contexto

Un estudio independiente desarrolla *SimuNación*, un nuevo videojuego de simulación estratégica que recrea las dinámicas del sistema y las repúblicas del siglo XXI. 
Para un primer MVP jugable, se requiere modelar:

- Los distintos tipos de *ciudadanos*.
- *La justicia* y la *Brigada para la Unión y la Reorganización Regulada del Orden (B.U.R.R.O.)*, que conforman el poder judicial de la simulación.
- *La república*, entidad "coordinadora" que acciona sobre los demás personajes, y los *proyectos* de ley.

## Ciudadanos

Todo ciudadano tiene la capacidad de:

- *Denunciar a otro ciudadano*, lo que envía el caso directamente a la justicia.
- Indicar si *es inmune a la justicia*, lo que es falso.
- *Ser intervenido por las fuerzas* de seguridad (la BURRO), accionar que se define según de qué tipo de ciudadano se trate.

### Civiles

De cada civil se conocen las *horas diarias que dedica al estudio*, las *horas diarias de propaganda que consume y cree* y si *usa IA en exceso*. Su accionar sigue las siguientes reglas:

- Si *Prefiere pensar:* Esto sucede si las horas de estudio son más que el 150% de las horas de propaganda diaria creída.
- Si *es alérgico a la sinapsis*, o sea, si no prefiere pensar y además usa IA en exceso.
- La forma en que es *intervenido por las fuerzas* depende de si prefiere pensar:
  - Si no prefiere pensar, el ciudadano es detenido como cualquier otro.
  - Si prefiere pensar, es *incomunicado y trasladado*.

### Magnates

Arrancan siempre con un *patrimonio* de 100 millones de dólares.

- Siempre son inmunes a la justicia.
- Pueden *deslomarse*: al hacerlo, su patrimonio suma 10 millones por cada civil alérgico a la sinapsis que haya actualmente en la república.
- Si las fuerzas de seguridad llegaran a intervenirlos, no ocurre nada.

### Los legisladores

Son ciudadanos con bancas en el congreso, por lo que su accionar es algo particular. Cada uno:

- Sabe decir la *dieta que cobra*, que es de 3 millones de pesos.
- Indica si *puede votar positivo un proyecto* de ley, según reglas que cambian segun de qué partido sea el legislador de que se trate.
- Es capaz de *votar positivo* y *negativo* un proyecto, o bien *abstenerse*. 
- Puede *votar un proyecto* de ley:
  - Si puede votarlo positivo, emite un voto positivo, si no, uno negativo.
- Al ser intervenido por las fuerzas de seguridad, simplemente son *demorados*.

### Legisladores reaccionarios

Estos legisladores sienten gran empatía por la gente (acaudalada) y por el capital. Cuentan con una *dieta extra* que inicia en 5 millones de pesos. Además:

- La dieta que cobran es igual a su dieta base más la extra.
- Pueden votar positivo un proyecto únicamente si el mismo *beneficia a un magnate*.
- Votan positivo un proyecto como cualquier otro legislador, pero con la particularidad de que luego suman el *monto adicional* del proyecto a su dieta extra.
- Obtienen inmunidad judicial si la dieta que cobran es igual o mayor a 10 millones de pesos.

### Legisladores moderados

Suelen hablar mucho, pero siempre terminan comportándose igual que los reaccionarios.La diferencia es que tienen un *nivel de networking* mutable (un número que indica la cantidad de contactos y amigos "de peso" que tienen en el ambiente para ayudarlos cuando necesiten) y ciertas particularidades en su accionar:

- Son inmunes a la justicia solo si logran la inmunidad de un reaccionario y además si su networking es al menos 20.
- Son capaces de *deliberar* durante un tiempo dado en horas. Por cada hora deliberada su networking aumenta en 3 puntos, hasta el máximo de 20.
- Al votar cualquier proyecto, primero se reúnen y deliberan durante 2 horas. Luego votan tal cual un reaccionario.

### Legisladores vanguardistas

Son los legisladores que más piensan y se preocupan por la población... Y también los que más se pelean. Cada uno tiene un estado que indica si *esta peleadx con compañeres* que puede ir cambiando.
Su accionar singular es como sigue:

- Puede votar positivo un proyecto únicamente si el mismo no beneficia a un magnate.
- Puede *cambiar de humor*, lo que si está peleado lo reconcilia, y viceversa.
- Su forma de votar un proyecto depende de si está peleado:
  - Si lo está se abstiene, si no, vota igual que cualquier otro legislador. 
- Las fuerzas de seguridad no los quieren mucho, por lo que cuando son intervenidos, en vez de detenerlos o demorarlos, directamente los *incomunican y trasladan*.

## El poder judicial

Está compuesto por la justicia y la B.U.R.R.O., que suelen actuar en conjunto.

### La justicia

Mantiene un registro de ciudadanos *procesados*.

- Puede *recibir una denuncia* contra un ciudadano dado. Cuando eso sucede, procesa al denunciado (lo añade a su registro) y luego ordena a la BURRO que lo intervenga. Esto claro, siempre y cuando el ciudadano del que se trate no sea inmune a la justicia (si lo es, "se ve atada de manos" y no hace nada).

### La Brigada para la Unión y la Reorganización Regulada del Orden (B.U.R.R.O.)

La *Brigada para la Unión y la Reorganización Regulada del Orden* es la fuerza de seguridad que patrulla las calles de SimuNación. Existen para proteger y servir a la población, aunque muchos civiles que prefieren pensar lo ponen en duda.
Son capaces de:

- *Intervenir a un ciudadano* dado. Al hacerlo, cada ciudadano reacciona distinto según qué posición ocupa en la sociedad.
- *Detener* a un ciudadano: La BURRO lo encierra y lo suma a su *registro de detenidos*.
- *Demorar* a un ciudadano: Algo que suele irritar a quien le sucede, ya que es detenido por las fuerzas pero liberado y removido del registro unos momentos después.
- *Incomunicar y trasladar* a un ciudadano: 
  - Es la práctica de la BURRO más discutida entre los civiles. La brigada suele mencionar que estas personas entran en un "estado cuántico" porque "están y no están a la vez". Lo cierto es que no se vuelve a saber sobre sus paraderos, solo queda un registro de *rebeldes capturados* de difícil acceso al que las fuerzas los agregan cuando esto sucede.

## Proyectos de ley

Cada proyecto tiene registro de si *beneficia a un magnate* (algo que no puede cambiar), y de la cantidad de votos *positivos, negativos y abstenciones* que comienzan todas en 0.
También:

- Indica el *monto adicional* que otorgan, que es de 5 millones de pesos.
- Se sabe si *fue aprobado*, lo que sucede si la cantidad de votos positivos supera a los negativos.
- Puede *sumar votos* (de a uno), tanto positivos y negativos como abstenciones.

## La república

Para este MVP se requiere modelar una primera y única República. Ésta mantiene un registro de *civiles* y *legisladores* (que no tienen orden ni repetidos), y tiene un *partido gobernante*. 
La república sabe:

- El *gasto total en dietas*, o sea la suman de las dietas de los legisladores.
- Cuál es su *legislador más caro*.
- Encontrar un *legislador cualquiera que pueda votar positivo un proyecto dado*. Si no hubiese ninguno, debe producirse un error con el mensaje "No hay legislador que pueda votar positivo este proyecto.".
- Si *existe riesgo de rebelión*: ocurre si los civiles que prefieren pensar superan en número a los alérgicos a la sinapsis.
- La *cantidad de alérgicos* a la sinapsis entre los civiles actuales.
- Si *es autoritaria*: siempre que el partido gobernante *sea autoritario* la república también lo será.
- *Agregar legisladores* y *agregar civiles* a sus respectivos registros de a varios a la vez.
- *Poner orden*: si es autoritaria y existe riesgo de rebelión, puentea la justicia y manda a la BURRO a intervenir directamente a toda la población civil registrada.
- *Llevar un proyecto al congreso*: hace que todos los legisladores registrados a voten dicho proyecto.

> Tener en cuenta: Naturalmente, no existe un único partido político, y cada vez que se crea uno nuevo se debe indicar si *es autoritario*. El que gobierna la república actualmente, en efecto, lo es.

## Tests mínimos a realizar

Suponiendo un escenario inicial con:

- Un civil con 4 horas de estudio diarias, 2 de propaganda creída y que no usa IA en exceso
- Un civil con 1 hora de estudio diaria, 10 de propaganda creída y que usa IA en exceso
- Un legislador moderado con dieta extra de 7 y 15 de nivel de networking
- Un legislador vanguardista que no está peleado con sus compañeres
- Un proyecto que beneficia a un magnate

Comprobar que:

- El primer civil mencionado prefiere pensar.
- El segundo civil mencionado es alérgico a la sinapsis.
- La república sabe decir correctamente la cantidad de alérgicos a la sinapsis entre sus civiles. Usar un ejemplo donde tenga 3 alérgicos.
- La república indica que existe riesgo de rebelión si hay más civiles que prefieren pensar que alérgicos a la sinapsis en sus filas.
- El legislador moderado no es inmune a la justicia.
- El mismo legislador vota el proyecto (mencionado arriba) y se vuelve inmune a la justicia.
- Si la república con 1 legislador de cada uno (3 total) lleva al congreso este proyecto, el mismo resulta aprobado.
