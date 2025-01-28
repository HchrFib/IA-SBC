# IA-FIB_SBC
Practica SBC (Sistema Basado en el Conocimiento)

## Descripción del problema

El objetivo de la práctica es desarrollar un sistema basado en el conocimiento para hacer un generador de menús semanales específico para gente de edad avanzada, adecuándolo a las características propias de la persona en término tanto de edad y sexo como de enfermedades e intolerancias.

## Objetivos del problema
Los objetivos que deseamos alcanzar y que ya se han ido comentando a lo largo de la explicación són los siguientes:

- Obtener la información del usuario a través de un input para así usarla en nuestro modelo.
- Con los datos del usuario, generar restricciones y preferencias que debemos tener en cuenta.
- Con dicha información, generar un menú semanal adecuado a la persona y que consiste de 7 menús diaros, cada uno compuesto por un desayuno, un almuerzo (primero, segundo y     postre) y una cena.
- Informar al usuario de la propuesta obtenida.

  ## Ejecución del "Sistema Basado en el Conocimiento"

1. Para ejecutar la práctica en linux simplemente usar el script 
  ```
     run.sh
```
### Funcionalidades del programa:

1. Pedir información al usuario sobre su estado de salud y preferencias.
2. Es capaz de generar una dieta personalizada teniendo en cuenta todos estos factores.
3. Si no es posible generar una dieta (esto puede ocurrir si las restricciones son demasiado estrictas) se avisará al usuario.
4. Las dietas se generarán intentando seguir tanto la época del año como las preferencias introducidas por el usuario.
5. En ningún caso se incluirá un alimento que contenga un ingrediente al que el usuario sea intolerante.
6. El output se muestra en un formato fácilmente legible para el usuario junto con la información nutricional del menú y los límites para una persona en su condición.
