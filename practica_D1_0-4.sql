-- ???????????????????????????????????????
@g

: \ c_programacion \ c__back_end \ talleres_cursos_diseno_de_bases_de - datos \ programacion_base_de_datos_relacionales \ oracle
\ curso_de_oracle_sql \ curso_oracle_sql_plus - 20H \ schema_hr qlplus system --Iniciando sqlplus
conn hr / hr                                                                                                                         --conectando
--podemos ver que hay un campo llamado table_name de la tabla user_tables;

SELECT
 table_name
FROM
 user_tables;

-- Un campo que no tiene valor es NULL. Distinto es tener un carácter o varios caracteres en
-- blanco « », que puede parecer que no hay nada pero hay espacios.
-- La recomendación es insertar NULL cuando no se tenga valor y consultar como NULL.

DESC employees;


/*
--  SELECT 
-- //
-- SUBSTR(prametro1, parametro2, parametro3)

SELECT [ALL|DISTINCT]
{ * | {columna | expresión} [[AS] alias], ... }
FROM
{[esquema.]{tabla|vista} | (sub-consulta)}[alias][, …]
[WHERE lista_de_condiciones]
[GROUP BY lista_de_columnas]
[HAVING
condiciones_de_grupo]
[ORDER BY
columna [ASC|DESC][, …]]
;

Expicación:

Primero, expliquemos la nomenclatura utilizada anteriormente. Puede que se encuentren
con ella. Las palabras en mayúscula son palabras reservadas, es decir, parte del lenguaje. Los
corchetes «[ ]» indican algo opcional. Mientras que las llaves «{ }» indican algo obligatorio. El
pipe «|» indica una opción o la otra. Los paréntesis son eso: paréntesis, necesarios por sintaxis.
El asterisco, la coma y el punto son elementos del lenguaje; el asterisco se utiliza para indicar
todas las columnas, la coma para separar elementos en SELECT, FROM y ORDER BY, el punto
para separar elementos que pertenecen o están dentro de otro elemento, como es el caso de una
tabla que pertenece a otro usuario si indica: nombre_usuario.nombre_tabla. Los puntos
suspensivos indican que se puede repetir elementos. Y no olviden el punto y coma que termina la
sentencia.
¿Qué tablas tenemos? Una forma de consultar las tablas que tiene nuestro usuario es
realizando una consulta a USERS_TABLES. Y vemos que hay una tabla llamada: employees.
*/
-- consult tabla de empleados mostrando todos los datos FROM. El asterisco indica que son todos los campos.

SELECT
 *
FROM
 hr.employees;

/*
El texto y la operación no están en ninguna tabla, por lo que no las vamos a consultar de
ninguna tabla. Entonces, por sintaxis utilizamos DUAL para tener algo después de FROM. Tiene
que haber algo después de SELECT (campos, sub-consultas) y algo después de FROM (tablas,
sub-consultas).
*/
--  mostrar un texto y una operación matemática. Para estos casos se utiliza DUAL

SELECT
 'esto es un texto',
 2 + 2
FROM
 dual;

/*
Ahora vamos a realizar operaciones aritméticas con los campos. Por ejemplo, listemos el
apellido, el salario, el porcentaje de comisión, y el salario total (salario incrementado la
comisión). El salario total es una columna más, lo que pasa es que el valor es obtenido por una
operación entre más de un campo.
*/
-- Metodo 1 (sin AS)

SELECT
 last_name        "Nombre",
 salary           "Salario",
 commission_pct   "Comicion",
 salary * ( 1 + commission_pct ) "Salario total" -- alias("Salario total"==> entre comillas por tener espacios entre palabras)
FROM
 hr.employees;

-- Metodo 2 (con AS)

SELECT
 last_name   AS nombre,
 salary      AS salario,
 ( 1 + commission_pct ) AS comicion,
 salary * ( 1 + commission_pct ) AS "Salario total" -- alias("Salario total"==> entre comillas por tener espacios entre palabras)
FROM
 hr.employees;

/*
En la sentencia anterior vemos que podemos operar con los campos. Se utiliza paréntesis
para realizar primero la suma y posteriormente la multiplicación. Y se añade un alias al campo.
El alias del campo se escribe dejando al menos un espacio. La palabra «AS» que pueden ver en
la sintaxis al inicio del apartado, está entre corchetes, es opcional. En este caso utilizo un alias
que tiene dos palabras y hay un espacio entre palabras, entonces, para evitar un error de sintaxis
se utiliza las dobles comillas para indicar que el alias son las dos palabras «Salario total». El
alias nos sirve para nombrar a un campo. En este caso por cuestión de estética en vez de que
salga toda la operación como nombre de la columna se muestra el alias. Más adelante lo
usaremos para hacer referencia por funcionalidad. Y tomará mayor importancia la utilización de
un alias.
Para los nombres de los alias —y en general— es recomendado utilizar letras del alfabeto
inglés, números, guión bajo. Y empezar con una letra.
*/


--  concatenar existe una funciona llamada CONCAT pero vamos a concatenar de otra forma que se permite en Oracle, con dos pipes «||»,
-- funcion INITCAP(str) returna strin con la primera letra em mayscula;
-- funcion UPPER(parametro) retorna parametro en mayuscula
 -- funcion lower(parametro) -- retorna  parametro in miniscula
 -- alias con la palabra AS (nombre_completo  ==>SIN comillas  no tener espacios entre las palabras)

SELECT
 lower(email) AS correo,
 upper(last_name) AS apellido,
 initcap(first_name || ' '
                       || last_name) AS nombre_completo
FROM
 hr.employees;

/*
Supongamos que queremos crear cuentas de correo y decidimos hacerlo a partir de un
listado. Y lo que tenemos es solo una lista de nombres y apellidos. El formato que queremos es
la primera letra del nombre seguido de un punto y el apellido, de tal forma que el resultado sea:
«n.apellido@empresa.com». Utilizamos las columnas firts_name y last_name de la tabla de
employees.
Si ya sabemos concatenar, lo que nos falta es algo para extraer el primer carácter del
nombre. Así que buscamos una función que haga eso. Encontraremos la función SUBSTR(prametro1, parametro2, parametro3) que
recibe tres parámetros: la cadena de texto, la posición de inicio y el número de caracteres a
extraer.
*/
-- Sin la funcion SUBSTR() pero con el primer nombre completo

SELECT
 first_name AS nombre,
 last_name || '@'
              || 'empresa.com' AS correo
FROM
 hr.employees;

-- La funcion SUBSTR (recibe tres parámetros:  SUBSTR(la cadena de texto, la posición de inicio, número de caracteres a extraer)

SELECT
 substr(first_name, 1, 1)
 || '.'
    || last_name
       || '@'
          || 'empresa.com'
FROM
 hr.employees;

SELECT
 department_id,
 last_name,
 commission_pct,
 salary * ( 1 + commission_pct ) AS "Salario total"
FROM
 hr.employees;


/*
Bien, ¿quiénes tienen salario total? Solo los que tienen comisión. Entonces, ¿esto tiene que
ver con los valores nulos? ¡Exacto! Al momento de operar con valores nulos el resultado es nulo.
En nuestro caso al sumar NULL con uno el resultado es NULL; y al multiplicar NULL con el
salario el resultado es NULL. Si no tiene comisión lo que queremos que salga es el valor del
salario como salario total. Necesitamos algo que nos convierta ese valor nulo en un cero.
Entonces la operación es correcta matemáticamente. Y ese algo es una función. La función que
vamos a utilizar es NVL. Las funciones f(x) reciben uno o varios valores como parámetros y nos
devuelven un valor. Se escribe el nombre de la función y entre paréntesis se escribe separados
por comas los parámetros. En el caso de NVL, recibe dos parámetros: el primero es el valor a
comparar si es nulo o no, el segundo parámetro es el valor que queremos devuelva si el primer
parámetro es nulo. Como he dicho, si es nulo lo que nos interesa es un cero

*/
 
  
-- **** FUNCION NVL(parametro1,parametr2) ==> retorna parametro1 si parametr2 es nulo
-- convierte valores nulos en ceros  

SELECT
 department_id,
 last_name,
 commission_pct,
 salary * ( 1 + nvl(commission_pct, 0) ) AS "Salario total"
FROM
 hr.employees;

DESC hr.employees;




-- ** ORDER BY {expresion | posición | alias} [ASC | DESC] [NULLS FIRST|NULLS LAST][, ...] 
-- funcion nvl(expr1,expr2) retorna expre1 si expre2 es null de lo contrario  retorna expr1
-- Si queremos asegurar el orden se especifica la cláusula ORDER BY.

--lo que se coloca después de ORDER BY es la lista de campos separados por coma  

/*
Si queremos asegurar el orden se especifica la cláusula ORDER BY. Como se ve en la
imagen anterior, lo que se coloca después de ORDER BY es la lista de campos separados por
coma; así como en la SELECT ya hemos puesto nombre de campos, expresiones y alias, eso
mismo es a lo que hacemos referencia en la parte de ORDER BY, es decir, lo que tenemos en la
parte de la SELECT. El orden por defecto es ascendente ASC, pero aunque sea por defecto lo
mejor es ser explícitos y dejar claro lo que queremos: si ascendente ASC, o descendente DESC.
Los valores nulos por defecto van al final cuando el orden es ASC, y al inicio cuando el orden es
DESC. Y si se quiere cambiar la ubicación de los nulos se especifica: NULLS FIRST o NULLS
LAST, según se quiere.

*/

SELECT
 department_id,
 last_name,
 salary * ( 1 + nvl(commission_pct, 0) ) "Salario total"
FROM
 hr.employees
ORDER BY
 department_id ASC,
 "Salario total" DESC,
 3 ASC;
  
  /*
  
  En la SELECT anterior hay una referencia al nombre del campo: department_id, un alias:
"Salario Total", y una posición: 3. Cuando tenemos un caso como el salario total, no podemos
hacer referencia a ese campo o columna colocando toda la expresión tal y como está en la parte
de selección, así que nos vemos en la obligación de utilizar un alias o por la posición que ocupa
en la lista de campos de la SELECT haciendo referencia simplemente con un número. Ordenar
por el salario no es lo mismo que ordenar por el salario total. Dicho esto último, se puede
ordenar por campos que no se muestran.
En la muestra de datos se puede ver cómo los departamentos van de forma ascendente: 60,
70, 80; todos los 60 se ve que el salario va de forma descendente: 9000, 6000, 4800, 4800, 4200;
y cuando coincide el salario: 4800, el apellido está en forma ascendente: Austin, Pataballa.
  
  
  */
  
  

  
  
  /*
   -- WHERE
   
    Sabemos ya seleccionar campos y manipularlos un poco con funciones o concatenando, y
además ordenarlos pero siempre han sido todas las filas de la tabla. Para filtrar según
determinadas condiciones se utiliza la cláusula WHERE, de esta forma escogemos qué filas
seleccionar.  
  
  */

SELECT
 department_id,
 last_name
FROM
 hr.employees
WHERE
 department_id = 10;
 
 /*
 En el caso anterior tenemos una condición. Y las condiciones son del estilo:
 
campo operador valor  ==> department_id <> 10;

Donde el operador puede ser: =, >=, >=, <, >, !=, <>, ~=. Los tres últimos son distintas
formas de escribir: distinto o que no es igual. 

Cuando tenemos que poner varias condiciones se colocan una tras otra unidas por: AND u OR según se quiera se cumplan ambas o una de ellas.

 
 */
 
--nos piden  los empleados de los departamentos 10, 20, 40 y 110.


--a no va a dar ninguna fila, ni error. por usar el operador AND El empleado solo está en un departamento no en varios. 

SELECT
 department_id,
 last_name
FROM
 hr.employees
WHERE
 department_id = 10
 AND department_id = 20
     AND department_id = 40
         AND department_id = 110;


/*

Lo que realmente entendemos se quiere es los empleados que sean
del 10, pero también los que son del 20, más los del 40 y los del 110, es decir, que están en uno
de esos, no en todos*/

-- Este si funciona por usar el oprardor OR

SELECT
 department_id,
 last_name
FROM
 hr.employees
WHERE
 department_id = 10
 OR department_id = 20
    OR department_id = 40
       OR department_id = 110;



-- ******* IN  {campo | expresión} {FROM TABLE } [NOT] IN    lista_de_valores pag.51 ************ 


-- Otra forma de escribir la anterior consulta es con el operador IN.

SELECT
 department_id,
 last_name
FROM
 hr.employees
WHERE
 department_id IN (
  10,
  20,
  40,
  110
 );



-- IN

SELECT
 department_id,
 last_name,
 first_name
FROM
 hr.employees
WHERE
 last_name IN (
  'King',
  'Smith',
  'Grant'
 );

-- NOT IN 

SELECT
 department_id,
 last_name,
 first_name
FROM
 employees
WHERE
 last_name NOT IN (
  'King',
  'Smith',
  'Grant'
 );



-- operador LIKE {campo | expresión} [NOT] LIKE {campo | expresión} [ESCAPE expresión]


--Si queremos listar a los empleados cuyo apellido empieza por la letra «S» la consulta puede
-- ser con la función SUBSTR que ya utilizamos antes

SELECT
 department_id,
 last_name,
 first_name
FROM
 hr.employees
WHERE
 substr(last_name, 1, 1) = 'S';

SELECT
 department_id,
 last_name,
 first_name
FROM
 hr.employees
WHERE
 substr(last_name, 1, 1) = 'S';

SELECT
 department_id,
 last_name,
 first_name
FROM
 hr.employees
WHERE
 last_name LIKE 'S%';

SELECT
 department_id,
 last_name,
 first_name
FROM
 hr.employees
WHERE
 last_name LIKE '%i';

SELECT
 employee_id,
 last_name,
 first_name
FROM
 hr.employees
WHERE
 last_name LIKE '%i%';

-- empiece por una �S� y tengan una �i� en cualquier parte

SELECT
 employee_id,
 last_name,
 first_name
FROM
 hr.employees
WHERE
 last_name LIKE 'S%i%';

-- la tercera letra sea una �t� y la �ltima una �s�

SELECT
 employee_id,
 last_name,
 first_name
FROM
 hr.employees
WHERE
 last_name LIKE '%__t%s';

-- NOT LIKE
-- la tercera letra no sea una �t� y la �ltima  no sea una �s�

SELECT
 employee_id,
 last_name,
 first_name
FROM
 hr.employees
WHERE
 last_name NOT LIKE '%__t%s';


-- *** ESCAPE  escapar un caracter *** Pag.54

-- listar los nombres de las columnas de la tabla de empleados que tienen un gui�n bajo.

DESCRIBE hr.user_tab_columns;

DESCRIBE hr.employees;











