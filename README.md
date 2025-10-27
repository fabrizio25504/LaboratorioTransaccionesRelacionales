# LaboratorioTransaccionesRelacionales
## Pregunta 1
a. ¿Qué departamento mantuvo los cambios?

el 60

b. ¿Qué efecto tuvo el ROLLBACK parcial?

deshizo los cambios para el departamento 90

c. ¿Qué ocurriría si se ejecutara ROLLBACK sin especificar SAVEPOINT?

Se borrarian todos los cambios incluyendo los del departamento 90

## Pregunta 2
a. ¿Por qué la segunda sesión quedó bloqueada?

Porque habia una transaccion parcial

b. ¿Qué comando libera los bloqueos?

Rollback y Commit

c. ¿Qué vistas del diccionario permiten verificar sesiones bloqueadas?

Hay varias vistas del diccionario de datos que puedes usar para diagnosticar bloqueos. Las más comunes son:

- V$SESSION: Esta vista es clave. Tiene columnas como SID (el ID de la sesión), SERIAL#, y, lo más importante, BLOCKING_SESSION. Si una sesión está bloqueada, esta columna mostrará el SID de la sesión que la está bloqueando.

- V$LOCK: Muestra información detallada sobre los bloqueos que se mantienen en ese momento.

- V$SESSION_WAIT: Te permite ver en qué está "esperando" cada sesión. Una sesión bloqueada comúnmente mostrará un evento de espera como enq: TX - row lock contention.

- DBA_BLOCKERS y DBA_WAITERS: Estas vistas (si tienes los permisos de DBA) están diseñadas específicamente para mostrar de forma sencilla quién está bloqueando (blockers) y quién está siendo bloqueado (waiters).
## Pregunta 3
a. ¿Por qué se debe garantizar la atomicidad entre las dos operaciones?

Porque ambas operaciones (INSERT en historial y UPDATE en empleado) representan una única "transferencia" de negocio. Si una falla y la otra no, los datos quedan en un estado inconsistente (por ejemplo, el empleado está en el nuevo departamento pero no hay registro de su trabajo anterior).

b. ¿Qué pasaría si se produce un error antes del COMMIT?

Se ejecuta el bloque exception y se hace un Rollback

c. ¿Cómo se asegura la integridad entre EMPLOYEES y JOB_HISTORY?

Usando una transacción. Al envolver ambas operaciones DML (Insert y Update) dentro de un mismo bloque BEGIN...END y usando COMMIT solo al final (si todo es exitoso) o ROLLBACK si algo falla, nos aseguramos de que ambas operaciones se completen o ninguna se complete.

## Pregunta 4
a. ¿Qué cambios quedan persistentes?

Los update de los salarios

b. ¿Qué sucede con las filas eliminadas?

No se cuentan por el rollback

c. ¿Cómo puedes verificar los cambios antes y después del COMMIT?

Puedes hacer un SELECT antes de ejecutar el bloque y despues de. Tambien tener en cuenta que si haces un select durante la ejecucion no se verá los cambios reflejados.
