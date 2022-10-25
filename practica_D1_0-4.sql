
sqlplus SYSTEM --Estableciendo coneccion con el usuario


-- Para describir una tabla se utiliza «desc» o «describe».
DESC user_tables;

conn hr/hr --conectando

-- comenzando con ñla base de datos
@ G:\c_programacion\c__back_end\talleres_cursos_diseno_de_bases_de-datos\programacion_base_de_datos_relacionales\oracle\curso_de_oracle_sql\Curso_Oracle_SQL_PLUS-20H\Schema_HR

--podemos ver que hay un campo llamado table_name de la tabla user_tables;
SELECT table_name FROM user_tables;


-- Un campo que no tiene valor es NULL. Distinto es tener un carácter o varios caracteres en
-- blanco « », que puede parecer que no hay nada pero hay espacios.
-- La recomendación es insertar NULL cuando no se tenga valor y consultar como NULL.
DESC employees;




/*
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
SELECT * FROM employees;


/*
El texto y la operación no están en ninguna tabla, por lo que no las vamos a consultar de
ninguna tabla. Entonces, por sintaxis utilizamos DUAL para tener algo después de FROM. Tiene
que haber algo después de SELECT (campos, sub-consultas) y algo después de FROM (tablas,
sub-consultas).
*/
--  mostrar un texto y una operación matemática. Para estos casos se utiliza DUAL
select 'esto es un texto', 2+2 from dual;

/*
Ahora vamos a realizar operaciones aritméticas con los campos. Por ejemplo, listemos el
apellido, el salario, el porcentaje de comisión, y el salario total (salario incrementado la
comisión). El salario total es una columna más, lo que pasa es que el valor es obtenido por una
operación entre más de un campo.
*/
SELECT
last_name,
salary,
commission_pct,
salary * (1 + commission_pct) "Salario total"
FROM employees;

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
pg_43