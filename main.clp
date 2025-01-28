;; ============================================================================
;;                             FUNCIONES GENERICAS
;; ============================================================================

(defmodule FUNCIONES_GENERICAS
  (export ?ALL)
)


(deffunction ask-question (?question $?allowed-values)
  (printout t ?question)
  (bind ?answer (read))
  (if (lexemep ?answer)
    then (bind ?answer (lowcase ?answer)))
  (while (not (member$ ?answer ?allowed-values)) do
    (printout t crlf)
    (printout t ?question)
    (bind ?answer (read))
    (if (lexemep ?answer)
      then (bind ?answer (lowcase ?answer)))
    )
  ?answer)

(deffunction ask-open-question (?question)
  (printout t ?question)
  (bind ?answer (read))
  ?answer
)


(deffunction ask-number (?question)
  (printout t ?question)
  (bind ?answer (read))
  (while (not (integerp ?answer)) do
    (printout t crlf)
    (printout t "  [ERROR] Esto no es un numero valido" crlf)
    (printout t ?question)
    (bind ?answer (read)))
  ?answer)


(deffunction ask-pos-number (?question)
  (bind ?answer (ask-number ?question))
  (while (< ?answer 0) do
    (printout t crlf)
    (printout t "  [ERROR] El numero debe ser mayor o igual que cero" crlf)
    (bind ?answer (ask-number ?question)))
  ?answer)


(deffunction ask-bounded-number (?question ?lowest ?greatest)
  (bind ?answer (ask-number ?question))
  (while (or (< ?answer ?lowest) (> ?answer ?greatest)) do
    (printout t crlf)
    (printout t "  [ERROR] El numero debe estar entre " ?lowest " y " ?greatest crlf)
    (bind ?answer (ask-number ?question)))
  ?answer)


(deffunction ask-yes-no-question (?question)
  (bind ?response (ask-question ?question si no s n))
  (if (or (eq ?response si) (eq ?response s))
    then TRUE
    else FALSE))

;; ============================================================================
;;                                    MAIN
;; ============================================================================

(defmodule MAIN
  (export ?ALL)
)


(defrule main "Saca por pantalla el banner y corre el programa"
  =>
  (printout t crlf crlf crlf)
  (printout t "========================================================================" crlf)
  (printout t "=                                                                      =" crlf)
  (printout t "=        CREADOR DE DIETAS PARA PERSONAS DE LAS TERCERA EDAD           =" crlf)
  (printout t "=                                                                      =" crlf)
  (printout t "=   Sistema basado en conocimiento para recomendar dietas a personas   =" crlf)
  (printout t "=                       de la tercera edad                             =" crlf)
  (printout t "========================================================================" crlf)
  (printout t crlf crlf)

  (make-instance persona of Persona)
  (focus QUESTIONS)
)


;; ============================================================================
;;                                  QUESTIONS
;; ============================================================================

(defmodule QUESTIONS
  (import FUNCIONES_GENERICAS ?ALL)
  (import MAIN ?ALL)
  (export ?ALL)
)


(defrule read-age "Pregunta la edad al usuario"
  (declare (salience -1))
  ?p <- (object (is-a Persona))
  =>
  (printout t crlf)
  (bind ?edad (ask-bounded-number "Introduzca su edad (minimo 65 anyos): " 65 150))
  (send ?p put-edad ?edad)
)


(defrule read-gender "Pregunta el sexo al usuario"
  (declare (salience -2))
  ?p <- (object (is-a Persona))
  =>
  (printout t crlf)
  (bind ?sexo (ask-question "Introduzca su genero (hombre/mujer): " hombre mujer))
  (send ?p put-sexo ?sexo)
)

(defrule read-season "Pregunta la estacion del anyo al usuario"
  (declare (salience -2))
  ?p <- (object (is-a Persona))
  =>
  (printout t crlf)
  (bind ?temp (ask-question "Introduzca la estacion del anyo (primavera/verano/otonyo/invierno): " primavera verano otonyo invierno))
  (send ?p put-temporada_actual ?temp)
)


(defrule read-exercise "Pregunta el nivel de actividad fisica"
  (declare (salience -3))
  ?p <- (object (is-a Persona))
  =>
  (printout t crlf)
  (bind ?actividad (ask-bounded-number "Numero de veces por semana que hace ejercicio: " 0 7))
  (send ?p put-actividad_fisica ?actividad)
)


(defrule ask-illnes "Preguntar enfermedades"
  (declare (salience  -4))
  ?p <- (object (is-a Persona))
  ?e <- (object (is-a Enfermedad))
  =>
  (printout t crlf)
  (bind ?name (instance-name-to-symbol (instance-name ?e)))
  (bind ?question (str-cat "Padece de " ?name " (si,s/no,n): " ))
  (bind ?padece (ask-yes-no-question ?question))
  (if ?padece then (slot-insert$ ?p padece_de 1 ?e))
  (printout t crlf)
)


(deffunction ask-ingredient-list (?person ?questiontext ?prompttext ?attribute)
  (printout t crlf crlf)
  (printout t "De la anterior lista introduzca de uno en uno aquellos" crlf)
  (printout t ?questiontext " o next para continuar." crlf)
  (bind ?answer "")
  (while (not (eq ?answer next)) do
    (bind ?answer (ask-open-question ?prompttext))
    (if (not (eq ?answer next)) then
      (bind ?instance (symbol-to-instance-name ?answer))
      (if (instance-existp ?instance)
      then
        ; TODO checkear si la instancia es de tipo ingrediente
        (slot-insert$ ?person ?attribute 1 ?instance)
      else
        (printout t "  [ERROR] Elemento no reconocido (compruebe las mayusculas)" crlf)
      )
    )
  )
  (printout t crlf crlf)
)


(defrule print-intolerances "Mostrar lista de intolerancias disponibles"
  (declare (salience -5))
  ?i <- (object (is-a Intolerancia))
  =>
  (bind ?name (instance-name-to-symbol (instance-name ?i)))
  (printout t " * " ?name crlf)
)


(defrule ask-forbidden "Preguntar por alergias e intolerancias"
  (declare (salience -6))
  ?p <- (object (is-a Persona))
  =>
  (ask-ingredient-list ?p "elementos que no pueda consumir"
                       "Ingrediente no permitido: " es_intolerante_a)
)


(defrule print-ingredients "Mostrar lista de ingredientes disponibles"
  (declare (salience -7))
  ?i <- (object (is-a TipoComida))
  =>
  (bind ?name (instance-name-to-symbol (instance-name ?i)))
  (printout t " * " ?name crlf)
)

(defrule ask-dislike "Preguntar que ingredientes no le gustan"
  (declare (salience -8))
  ?p <- (object (is-a Persona))
  =>
  (ask-ingredient-list ?p "ingredientes que no le agraden"
                       "Ingrediente no deseado: " preferencia_negativa)
)


(defrule ask-like "Preguntar que ingredientes le gustan mas"
  (declare (salience -9))
  ?p <- (object (is-a Persona))
  =>
  (ask-ingredient-list ?p "ingredientes por los que tenga preferencia"
                       "Ingrediente deseado: " preferencia_positiva)
)


(defrule goto-abstraction
  (declare (salience -999))
  =>
  (focus ABSTRACTION)
)

;; ============================================================================
;;                                 ABSTRACTION
;; ============================================================================


(defmodule ABSTRACTION
  (import FUNCIONES_GENERICAS ?ALL)
  (import MAIN ?ALL)
  (export ?ALL)
)


(defrule generate-nutrient-limits "Genera isntancias de las clases nutriente"
  ?p <- (object (is-a Persona))
  =>
  (bind ?azucar 0)
  (bind ?calcio 0)
  (bind ?calorias 0)
  (bind ?hierro 0)

  (foreach ?illness (send ?p get-padece_de)
    (if (eq (instance-name ?illness) [Diabetes]    ) then (bind ?azucar   -5))
    (if (eq (instance-name ?illness) [Osteoporosis]) then (bind ?calcio    5))
    (if (eq (instance-name ?illness) [Colesterol]  ) then (bind ?calorias -5))
    (if (eq (instance-name ?illness) [Anemia]      ) then (bind ?hierro    5))
  )

  (if (> (send ?p get-edad) 75) then
    (bind ?calcio (+ 2 ?calcio))
    (bind ?calorias (- ?calorias 2)))

  (if (eq (send ?p get-sexo) mujer) then
    (bind ?hierro (+ ?hierro 2)))

  (if (>= (nth$ 1 (send ?p get-actividad_fisica)) 3) then
    (bind ?calorias (+ 2 ?calorias)))

  (make-instance NutrientesRecomendados of Nutrientes
    (azucares  ?azucar)
    (calcio    ?calcio)
    (calorias  ?calorias)
    (hierro    ?hierro))
)


(deffunction check-plato-prohibido (?persona ?plato)
  (bind ?ingredientes (send ?plato get-alergenos))
  (bind ?prohibidos (send ?persona get-es_intolerante_a))
  (foreach ?prohibido $?prohibidos
    (foreach ?ingrediente $?ingredientes
      (if (eq ?ingrediente ?prohibido) then
        (return TRUE)
      )
    )
    (if (eq ?prohibido (nth$ 1 (send ?plato get-ingrediente_principal))) then
      (return TRUE)
    )
  )
  (return FALSE)
)


(defrule purge-dishes "Elimina los platos que contienen ingredientes prohibidos"
  ?persona <- (object (is-a Persona))
  ?plato <- (object (is-a Plato))
  =>
  (if (check-plato-prohibido ?persona ?plato) then
    (unmake-instance ?plato)
  )
)


(defrule abstract-season "Procesa el input de estacion para saber si es temporada caliente o fria"
  ?persona <- (object (is-a Persona))
  =>
  (bind ?temporada (send ?persona get-temporada_actual))
  (bind ?temperatura (create$ "frio"))
  (if (or (eq ?temporada (create$ verano)) (eq ?temporada (create$ primavera))) then
    (bind ?temperatura (create$ "calor"))
  )
  (assert (temperatura ?temperatura))
)


(defrule goto-asociation
  (declare (salience -999))
  =>
  (focus ASOCIATION)
)


;; ============================================================================
;;                                 ASOCIATION
;; ============================================================================

(defmodule ASOCIATION
  (import FUNCIONES_GENERICAS ?ALL)
  (import MAIN ?ALL)
  (import ABSTRACTION ?ALL)
  (export ?ALL)
)

(defrule init-general
  (declare (salience 1))
  =>
  (make-instance [allDesayuno] of Comida)
  (make-instance [allPrimero]  of Comida)
  (make-instance [allSegundo]  of Comida)
  (make-instance [allPostre]   of Comida)
)

(defrule init-desayuno
  (declare (salience -1))
  ?p <- (object (is-a Desayuno))
  =>
  (slot-insert$ [allDesayuno] consiste_de 1 ?p)
)

(defrule init-primero
  (declare (salience -1))
  ?p <- (object (is-a Primero))
  =>
  (slot-insert$ [allPrimero] consiste_de 1 ?p)
)

(defrule init-segundo
  (declare (salience -1))
  ?p <- (object (is-a Segundo))
  =>
  (slot-insert$ [allSegundo] consiste_de 1 ?p)
)

(defrule init-postre
  (declare (salience -1))
  ?p <- (object (is-a Postre))
  =>
  (slot-insert$ [allPostre] consiste_de 1 ?p)
)

; dado un plato y un vector de platos, dice si el vector contiene un plato con
; un ingrediente principal que el plato del argumento
(deffunction check-different (?nuevoplato $?platos)
  (bind ?i 1)
  (foreach ?plato $?platos
    (foreach ?ingrnuevopl (send ?nuevoplato get-ingrediente_principal)
      (foreach ?ingrpl (send ?plato get-ingrediente_principal)
        (if (eq ?ingrpl ?ingrnuevopl) then (return FALSE))
      )
    )
  )
  (return TRUE)
)


(deffunction nutriente-to-int (?nutriente ?plato)
  (bind ?nivel (nth$ 1 (send ?plato (sym-cat get- ?nutriente))))
  (if (eq ?nivel "bajo")  then (return -1))
  (if (eq ?nivel "medio") then (return  0))
  (if (eq ?nivel "alto")  then (return  1))
  (printout t "NO RECONOCIDO:" ?nutriente " en " ?plato " -> "
    ?nivel " (esto es un mensaje de debug) "
  "<--------------------------" crlf)
)


(deffunction asignar-nutrientes-dia (?dia)
  (bind ?azucar 0)
  (bind ?calcio 0)
  (bind ?hierro 0)
  (bind ?calorias 0)

  (foreach ?comida  (send ?dia get-tiene)
    (foreach ?plato   (send ?comida get-consiste_de)
      (bind ?azucar   (+ ?azucar   (nutriente-to-int azucares ?plato)))
      (bind ?calcio   (+ ?calcio   (nutriente-to-int calcio   ?plato)))
      (bind ?hierro   (+ ?hierro   (nutriente-to-int hierro   ?plato)))
      (bind ?calorias (+ ?calorias (nutriente-to-int calorias ?plato)))
    )
  )

  (slot-insert$ ?dia azucares 1 ?azucar)
  (slot-insert$ ?dia calcio   1 ?calcio)
  (slot-insert$ ?dia hierro   1 ?hierro)
  (slot-insert$ ?dia calorias 1 ?calorias)
)


(deffunction asignar-nutrientes-menu (?menu)
  (bind ?azucar 0)
  (bind ?calcio 0)
  (bind ?hierro 0)
  (bind ?calorias 0)

  (foreach ?dia (send ?menu get-formado_por)
    (bind ?azucar   (+ ?azucar   (nth$ 1 (send ?dia get-azucares))))
    (bind ?calcio   (+ ?calcio   (nth$ 1 (send ?dia get-calcio))))
    (bind ?hierro   (+ ?hierro   (nth$ 1 (send ?dia get-hierro))))
    (bind ?calorias (+ ?calorias (nth$ 1 (send ?dia get-calorias))))
  )

  (slot-insert$ ?menu azucares 1 ?azucar)
  (slot-insert$ ?menu calcio   1 ?calcio)
  (slot-insert$ ?menu hierro   1 ?hierro)
  (slot-insert$ ?menu calorias 1 ?calorias)
)


(deffunction max-nutriente-deviation (?dias)
  (bind ?azucar 0)
  (bind ?calcio 0)
  (bind ?hierro 0)
  (bind ?calorias 0)

  (foreach ?dia ?dias
    (bind ?azucar   (+ ?azucar   (nth$ 1 (send ?dia get-azucares))))
    (bind ?calcio   (+ ?calcio   (nth$ 1 (send ?dia get-calcio))))
    (bind ?hierro   (+ ?hierro   (nth$ 1 (send ?dia get-hierro))))
    (bind ?calorias (+ ?calorias (nth$ 1 (send ?dia get-calorias))))
  )

  (max (- ?azucar (nth$ 1 (send [NutrientesRecomendados] get-azucares)))
       (- (nth$ 1 (send [NutrientesRecomendados] get-calcio  )) ?calcio)
       (- (nth$ 1 (send [NutrientesRecomendados] get-hierro  )) ?hierro)
       (- ?calorias (nth$ 1 (send [NutrientesRecomendados] get-calorias))))
)


(deffunction dia-no-repeat (?desayuno ?primero ?segundo ?postre ?cena)
  (if (not (and (check-different ?primero  (create$ ?segundo))
                (check-different ?cena     (create$ ?primero ?segundo))
                (check-different ?desayuno (create$ ?postre)))) then
    (return FALSE)
  )
  (return TRUE)
)


(deffunction calc-score (?temperatura $?platos)
  (bind ?score 0)
  (foreach ?p ?platos
    (if (> (length (send ?p get-temporada)) 0) then
      (if (eq (send ?p get-temporada) ?temperatura)
        then (bind ?score (+ ?score 1))
        else (bind ?score (- ?score 1))
      )
    )
    (foreach ?i (send ?p get-ingrediente_principal)
      (foreach ?dislike (send [persona] get-preferencia_negativa)
        (if (eq ?i ?dislike) then (bind ?score (- ?score 1)))
      )
      (foreach ?like (send [persona] get-preferencia_positiva)
        (if (eq ?i ?like) then (bind ?score (+ ?score 1)))
      )
    )
  )
  ?score
)


(deffunction generate-dia (?temperatura ?tolerancia)
  (bind ?diaok FALSE)
  (bind ?i 0)
  (while (not ?diaok) do
    (bind ?list (send [allDesayuno] get-consiste_de))
    (bind ?desayuno (nth$ (+ 1 (mod (random) (length ?list))) ?list))

    (bind ?list (send [allPrimero] get-consiste_de))
    (bind ?primero (nth$ (+ 1 (mod (random) (length ?list))) ?list))

    (bind ?list (send [allSegundo] get-consiste_de))
    (bind ?segundo (nth$ (+ 1 (mod (random) (length ?list))) ?list))

    (bind ?list (send [allPostre] get-consiste_de))
    (bind ?postre (nth$ (+ 1 (mod (random) (length ?list))) ?list))

    (bind ?list (send [allPrimero] get-consiste_de))
    (bind ?cena (nth$ (+ 1 (mod (random) (length ?list))) ?list))

    (if (dia-no-repeat ?desayuno ?primero ?segundo ?postre ?cena) then
      (bind ?puntuacion (calc-score ?temperatura (create$ ?desayuno ?primero
                                                          ?segundo ?postre ?cena)))
      (if (>= ?puntuacion ?tolerancia)
        then (bind ?diaok TRUE)
        else (bind ?i (+ ?i 1))
      )
      (if (> ?i 100) then (bind ?i 0) (bind ?tolerancia (- ?tolerancia 1)))
    )
  )
  (bind ?dia
  (make-instance (sym-cat dia (gensym*)) of Día (tiene
    (make-instance (sym-cat desayuno (gensym*)) of ComidaDesayuno (consiste_de ?desayuno))
    (make-instance (sym-cat almuerzo (gensym*)) of ComidaAlmuerzo (consiste_de ?primero
                                                                              ?segundo
                                                                              ?postre))
    (make-instance (sym-cat cena (gensym*)) of ComidaCena (consiste_de ?cena)))
    (puntuacion ?puntuacion)))
  (asignar-nutrientes-dia ?dia)
  ?dia
)


(deffunction compatible (?dia1 ?dia2)
  (foreach ?comida1 (send ?dia1 get-tiene)
    (foreach ?plato1 (send ?comida1 get-consiste_de)
      (foreach ?comida2 (send ?dia2 get-tiene)
        (foreach ?plato2 (send ?comida2 get-consiste_de)
          (if (eq ?plato1 ?plato2) then
            (return FALSE)
          )
        )
      )
    )
  )
  (return TRUE)
)


(deffunction check-possible ()
    (bind ?list (send [allDesayuno] get-consiste_de))
    (if (< (length ?list) 2) then (return FALSE))
    (bind ?list (send [allPrimero] get-consiste_de))
    (if (< (length ?list) 2) then (return FALSE))
    (bind ?list (send [allSegundo] get-consiste_de))
    (if (< (length ?list) 2) then (return FALSE))
    (bind ?list (send [allPostre] get-consiste_de))
    (if (< (length ?list) 2) then (return FALSE))
    (return TRUE)
)


(deffunction delete-dia (?dia)
  (foreach ?comida (send ?dia get-tiene) (unmake-instance ?comida))
  (unmake-instance ?dia)
)


(deffunction removeN (?n ?dias)
  (bind ?i 1)
  (while (<= ?i ?n) do (delete-dia (nth$ ?i ?dias)) (bind ?i (+ 1 ?i)))
  (bind ?nuevo (create$))
  (bind ?i (length$ ?dias))
  (while (> ?i ?n) do
    (bind ?nuevo (create$ (nth$ ?i ?dias) ?nuevo))
    (bind ?i (- ?i 1))
  )
  ?nuevo
)


(defrule genMenu
  (declare (salience -2))
  (temperatura ?temperatura)
  ?p <- (object (is-a Persona))
  =>
  (printout t "Generando dieta..." crlf crlf)
  (if (check-possible) then
    (bind ?tolerancia (- (length$ (send ?p get-preferencia_positiva))
                         (length$ (send ?p get-preferencia_negativa))))
    (bind ?i 0)
    (bind ?menuok FALSE)
    (bind ?prev (generate-dia ?temperatura ?tolerancia))
    (bind ?dias (create$ ?prev))
    (while (not ?menuok) do
      (while (< (length ?dias) 7) do
        (bind ?dia (generate-dia ?temperatura ?tolerancia))
        (while (not (compatible ?prev ?dia)) do
          (delete-dia ?dia)
          (bind ?dia (generate-dia ?temperatura ?tolerancia))
        )
        (bind ?prev ?dia)
        (bind ?dias (create$ ?dias ?dia))
      )
      (if (> (max-nutriente-deviation ?dias) 2) then
        (bind ?dias (removeN 3 ?dias))
      else
        (bind ?menuok TRUE)
      )
      (if (> ?i 50)
        then (bind ?tolerancia (- ?tolerancia 1)) (bind ?i 0)
        else (bind ?i (+ 1 ?i))
      )
    )
    (make-instance menu of Menu (formado_por ?dias))
    (asignar-nutrientes-menu [menu])
  )
)


(defrule goto-refinement
  (declare (salience -10000))
  =>
  (focus REFINEMENT)
)


;; ============================================================================
;;                                 REFINEMENT
;; ============================================================================


(defmodule REFINEMENT
  (import FUNCIONES_GENERICAS ?ALL)
  (import MAIN ?ALL)
  (import ABSTRACTION ?ALL)
  (export ?ALL)
)


(deffunction print-menu (?menu)
  (bind ?dias (send ?menu get-formado_por))
  (bind ?nombres (create$ "Lunes" "Martes" "Miércoles" "Jueves" "Viernes" "Sábado" "Domingo"))
  (printout t  "Este es su menú semanal personalizado" crlf crlf)
  (bind ?i 1)
  (while (< ?i 8) do
    (bind ?dia (send (nth$ ?i ?dias) get-tiene))
    (bind ?desayuno (send (nth$ 1 ?dia) get-consiste_de))
    (bind ?almuerzo (send (nth$ 2 ?dia) get-consiste_de))
    (bind ?cena     (send (nth$ 3 ?dia) get-consiste_de))
    (bind ?puntos (send (nth$ ?i ?dias) get-puntuacion))
    (bind ?azucares (implode$ (send (nth$ ?i ?dias) get-azucares)))
    (bind ?calcio   (implode$ (send (nth$ ?i ?dias) get-calcio)))
    (bind ?calorias (implode$ (send (nth$ ?i ?dias) get-calorias)))
    (bind ?hierro   (implode$ (send (nth$ ?i ?dias) get-hierro)))
    (printout t
      "  [" (nth$ ?i ?nombres) "]"
          " preferencias: " (implode$ ?puntos) ", azucares: " ?azucares
          ", calcio: " ?calcio ", calorias: " ?calorias ", hierro: " ?hierro crlf

      "    * Desayuno: " (sym-cat (nth$ 1 (send (nth$ 1 ?desayuno) get-descripcion))) crlf
      "    * Almuerzo" crlf
      "       - Primero: " (sym-cat (nth$ 1 (send (nth$ 1 ?almuerzo) get-descripcion))) crlf
      "       - Segundo: " (sym-cat (nth$ 1 (send (nth$ 2 ?almuerzo) get-descripcion))) crlf
      "       - Postre:  " (sym-cat (nth$ 1 (send (nth$ 3 ?almuerzo) get-descripcion))) crlf
      "    * Cena: " (sym-cat (nth$ 1 (send (nth$ 1 ?cena) get-descripcion))) crlf
      crlf
    )
    (bind ?i (+ 1 ?i))
  )
)


(deffunction print-persona (?persona)
  (printout t crlf)
  (printout t "Se han tenido en cuenta los siguientes datos que ha introducido:" crlf
              "   * Edad: " (sym-cat (send ?persona get-edad)) crlf
              "   * Sexo: " (sym-cat (send ?persona get-sexo)) crlf
              "   * Estacion: " (implode$ (send ?persona get-temporada_actual)) crlf
              "   * Deporte semanal: " (implode$ (send ?persona get-actividad_fisica)) crlf
              "   * Padece las siguientes enfermedades:")
  (foreach ?x (send ?persona get-padece_de)
    (printout t " " (sym-cat (instance-name ?x)))
  )
  (printout t crlf
              "   * Intolerancias:")
  (foreach ?x (send ?persona get-es_intolerante_a)
    (printout t " " (sym-cat ?x))
  )
  (printout t crlf
              "   * Ingredientes que le gustan:")
  (foreach ?x (send ?persona get-preferencia_positiva)
    (printout t " " (sym-cat ?x))
  )
  (printout t crlf
              "   * Ingredientes que le desagradan:")
  (foreach ?x (send ?persona get-preferencia_negativa)
    (printout t " " (sym-cat ?x))
  )
  (printout t crlf crlf crlf)
)


(deffunction print-nutricion (?menu)
  (printout t "Aspectos nutricionales de la dieta:" crlf
     "    * Azucares: " (nth$ 1 (send ?menu get-azucares)) " (máximo "
                        (nth$ 1 (send [NutrientesRecomendados] get-azucares)) ")" crlf
     "    * Calcio:   " (nth$ 1 (send ?menu get-calcio))   " (mínimo "
                        (nth$ 1 (send [NutrientesRecomendados] get-calcio)) ")"  crlf
     "    * Calorias: " (nth$ 1 (send ?menu get-calorias)) " (máximo "
                        (nth$ 1 (send [NutrientesRecomendados] get-calorias)) ")" crlf
     "    * Hierro:   " (nth$ 1 (send ?menu get-hierro))   " (mínimo "
                        (nth$ 1 (send [NutrientesRecomendados] get-hierro)) ")"  crlf
  )
  (printout t crlf crlf)
)


(defrule output-menu "Print menu"
  ?m <- (object (is-a Menu))
  ?p <- (object (is-a Persona))
  =>
  (print-menu ?m)
  (print-persona ?p)
  (print-nutricion ?m)
  (printout t "   ¡Que aproveche!" crlf crlf)

  ;(printout t "RECUERDA VOLVER A SACAR POR PANTALLA EL OUTPUT" crlf)
)


(defrule output-failure "Print failure text"
  (declare (salience -10000))
  (not (object (is-a Menu)))
  =>
  (printout t "No ha sido posible generar un menu con las restricciones dadas, "
              "consulte una posible dieta con su médico." crlf crlf)
)
