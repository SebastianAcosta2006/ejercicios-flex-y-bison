# ejercicios-flex-y-bison
1️¿La calculadora acepta una línea que solo tenga un comentario?

No, no la acepta correctamente. Cuando se escribe solo un comentario, el scanner elimina el texto del comentario, pero el salto de línea sigue existiendo y se envía como EOL. El parser espera siempre una expresión antes del EOL, así que cuando recibe solo el salto de línea produce un error de sintaxis.seria lo más sencillo es modificar la gramática para que también permita líneas vacías, en lugar de cambiar el scanner.

2️¿Qué pasa si usamos | tanto para valor absoluto como para OR binario?

Si se usa el mismo símbolo para las dos cosas, el parser se confunde. No puede saber si ese | es el inicio de un valor absoluto o si está uniendo dos expresiones con un OR. Esto genera ambigüedad en la gramática y normalmente aparecen conflictos en Bison (como shift/reduce). En pocas palabras, reutilizar el mismo operador para funciones distintas hace que el análisis sintáctico no sea claro y provoque errores.

3️ Convertir la calculadora en hexadecimal y decimal
Para que la calculadora acepte números hexadecimales, se agregó una regla en el scanner que reconoce patrones como 0x1A o 0XFF. Cuando encuentra uno, usa strtol en base 16 para convertirlo a entero y lo guarda en yylval, devolviendo después el token NUMBER. Los números decimales siguen funcionando igual que antes. Además, se cambió el printf del parser para que muestre el resultado tanto en decimal como en hexadecimal. Así ahora se pueden mezclar ambos tipos de números en una misma operación.

4️¿El scanner hecho a mano reconoce exactamente los mismos tokens que el de flex?

No exactamente. Aunque ambos están pensados para reconocer lo mismo, pueden comportarse diferente en algunos casos. Flex usa expresiones regulares y aplica automáticamente la coincidencia más larga, mientras que en un scanner hecho en C todo debe programarse manualmente. Si hay pequeños errores en la lógica o en cómo se manejan los caracteres especiales, el resultado puede variar. Por eso no siempre van a reconocer exactamente lo mismo.

5️  ¿Hay lenguajes para los que flex no sea buena opción?

Sí, especialmente lenguajes donde el significado depende mucho del contexto. Por ejemplo, en lenguajes donde la indentación define bloques de código, el análisis no es tan simple como aplicar expresiones regulares. Flex funciona mejor cuando los tokens se pueden describir con patrones claros y regulares. Si el lenguaje necesita mucha información del contexto para decidir qué es cada cosa, puede que flex no sea la mejor herramienta.

6️ Comparación entre el word count en C y en flex

La versión hecha directamente en C puede ser un poco más rápida, sobre todo con archivos grandes, porque no tiene la capa extra que genera flex. Sin embargo, la diferencia no es enorme. En cuanto a dificultad, el programa en C es más trabajoso de escribir y revisar, ya que hay que controlar manualmente cuándo empieza y termina una palabra. En cambio, con flex es más sencillo porque las expresiones regulares hacen gran parte del trabajo y el código queda más corto y claro.
