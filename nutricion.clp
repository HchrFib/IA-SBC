;;; ---------------------------------------------------------
;;; nutricion.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology nutricion.ttl
;;; :Date 17/05/2023 15:47:04

(defclass Nutrientes
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot azucares
        (type SYMBOL)
        (create-accessor read-write))
    (multislot calcio
        (type SYMBOL)
        (create-accessor read-write))
    (multislot calorias
        (type SYMBOL)
        (create-accessor read-write))
    (multislot hierro
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Día
    (is-a Nutrientes)
    (role concrete)
    (pattern-match reactive)
    (multislot tiene
        (type INSTANCE)
        (create-accessor read-write))
    (slot num_dia
        (type SYMBOL)
        (create-accessor read-write))
    (multislot puntuacion
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Menu
    (is-a Nutrientes)
    (role concrete)
    (pattern-match reactive)
    (multislot formado_por
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Plato
    (is-a Nutrientes)
    (role concrete)
    (pattern-match reactive)
    (multislot alergenos
        (type INSTANCE)
        (create-accessor read-write))
    (multislot ingrediente_principal
        (type INSTANCE)
        (create-accessor read-write))
    (multislot descripcion
        (type STRING)
        (create-accessor read-write))
    (multislot saludable
        (type SYMBOL)
        (create-accessor read-write))
    (multislot temporada
        (type SYMBOL)
        (create-accessor read-write))
    (multislot tipo_plato
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Desayuno
    (is-a Plato)
    (role concrete)
    (pattern-match reactive)
)

(defclass Postre
    (is-a Plato)
    (role concrete)
    (pattern-match reactive)
)

(defclass Primero
    (is-a Plato)
    (role concrete)
    (pattern-match reactive)
)

(defclass Segundo
    (is-a Plato)
    (role concrete)
    (pattern-match reactive)
)

(defclass Comida
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot consiste_de
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass ComidaAlmuerzo
    (is-a Comida)
    (role concrete)
    (pattern-match reactive)
)

(defclass ComidaCena
    (is-a Comida)
    (role concrete)
    (pattern-match reactive)
)

(defclass ComidaDesayuno
    (is-a Comida)
    (role concrete)
    (pattern-match reactive)
)

(defclass Enfermedad
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot nombreEnf
        (type STRING)
        (create-accessor read-write))
)

(defclass Intolerancia
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass Persona
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot es_intolerante_a
        (type INSTANCE)
        (create-accessor read-write))
    (multislot padece_de
        (type INSTANCE)
        (create-accessor read-write))
    (multislot preferencia_negativa
        (type INSTANCE)
        (create-accessor read-write))
    (multislot preferencia_positiva
        (type INSTANCE)
        (create-accessor read-write))
    (multislot actividad_fisica
        (type INTEGER)
        (create-accessor read-write))
    (slot edad
        (type INTEGER)
        (create-accessor read-write))
    (slot sexo
        (type SYMBOL)
        (create-accessor read-write))
    (multislot temporada_actual
        (type STRING)
        (create-accessor read-write))
)

(defclass TipoComida
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot tipo_TipoComida
        (type STRING)
        (create-accessor read-write))
)

(definstances instances
    ([Lechuga/Cogollos] of TipoComida
    )

    ([Albaricoques] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Albaricoques")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Anemia] of Enfermedad
    )

    ([Arroz] of TipoComida
    )

    ([ArrozMilanesa] of Primero
         (ingrediente_principal  [Arroz])
         (descripcion  "Arroz a la milanesa")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Bizcocho] of Desayuno
         (alergenos  [Celiaco] [Huevo] [Lactosa])
         (ingrediente_principal  [Bolleria])
         (descripcion  "Bizcocho casero")
         (saludable  "false")
         (azucares  "alto")
         (calcio  "medio")
         (calorias  "alto")
         (hierro  "medio")
    )

    ([Bolleria] of TipoComida
    )

    ([BrochetasCarneChampis] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Brochetas de carne y champiñones")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([Canelones] of Segundo
         (alergenos  [Celiaco])
         (ingrediente_principal  [Carne] [Pasta])
         (descripcion  "Canelones de la abuela")
         (saludable  "false")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "medio")
    )

    ([Carne] of TipoComida
    )

    ([Celiaco] of Intolerancia
    )

    ([Cereales] of TipoComida
    )

    ([Cerezas] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Cerezas")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([CogollosAnchoas] of Primero
         (alergenos  [Pescado])
         (ingrediente_principal  [Lechuga/Cogollos])
         (descripcion  "Cogollos con anchoas")
         (saludable  "true")
         (tipo_plato  "Primero")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Colesterol] of Enfermedad
    )

    ([ConejoSalsa] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Conejo en salsa")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([CorderoTomate] of Segundo
         (ingrediente_principal  [Carne] "Carne")
         (descripcion  "Cordero a la plancha con tomate")
         (saludable  "true")
         (tipo_plato  "Segundo")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([CremaCalabacin] of Primero
         (ingrediente_principal  [Verduras] "Calabacín")
         (descripcion  "Crema fría de calabacín")
         (saludable  "true")
         (temporada  "calor")
         (tipo_plato  "Primero")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([CremaVerduras] of Primero
         (ingrediente_principal  [Verduras])
         (descripcion  "Crema de verduras")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "alto")
    )

    ([CremaZanahoria] of Primero
         (ingrediente_principal  [Verduras])
         (descripcion  "Crema de zanahoria")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([CroquetasJamon] of Segundo
         (alergenos  [Lactosa])
         (ingrediente_principal  [Celiaco] [Lacteo])
         (descripcion  "Croquetas de jamón con ensalada")
         (saludable  "false")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([Cuajada] of Desayuno
         (alergenos  [Lactosa])
         (ingrediente_principal  [Lacteo])
         (descripcion  "Cuajada con azúcar o miel")
         (saludable  "false")
         (azucares  "alto")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "medio")
    )

    ([CuajadaGalletas] of Desayuno
         (alergenos  [Celiaco] [Lactosa])
         (ingrediente_principal  [Cereales] [Lacteo])
         (descripcion  "Cuajada con miel y galletas integrales")
         (saludable  "false")
         (azucares  "alto")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "medio")
    )

    ([Diabetes] of Enfermedad
    )

    ([Embutido] of TipoComida
    )

    ([EnsaladaGarbanzos] of Primero
         (alergenos  [Huevo])
         (ingrediente_principal  [Legumbres])
         (descripcion  "Ensalada con garbanzos y huevo duro")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([EnsaladaLentejas] of Primero
         (ingrediente_principal  [Legumbres])
         (descripcion  "Ensalada de lentejas")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([EnsaladaPatata] of Primero
         (ingrediente_principal  [Patata] "Patata")
         (descripcion  "Ensalada de Patatas")
         (saludable  "true")
         (temporada  "calor")
         (tipo_plato  "Primero")
         (azucares  "alto")
         (calcio  "medio")
         (calorias  "alto")
         (hierro  "medio")
    )

    ([EnsaladaTomateQueso] of Primero
         (alergenos  [Lactosa])
         (descripcion  "Ensalada de tomate y queso fresco")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([Entremeses] of Primero
         (ingrediente_principal  [Embutido])
         (descripcion  "Entremeses variados")
         (saludable  "false")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([EscalopeTernera] of Segundo
         (alergenos  [Celiaco] [Huevo])
         (ingrediente_principal  [Carne])
         (descripcion  "Escalope de ternera con ensalada de lechuga")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([EspaguetisNapolitana] of Primero
         (alergenos  [Celiaco])
         (ingrediente_principal  [Pasta] "Pasta")
         (descripcion  "Espaguetis napolitana")
         (saludable  "false")
         (tipo_plato  "Primero")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "alto")
         (hierro  "medio")
    )

    ([EsparragosVinagreta] of Primero
         (ingrediente_principal  [Verduras])
         (descripcion  "Espárragos a la vinagreta")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([FideosCazuela] of Primero
         (alergenos  [Celiaco])
         (ingrediente_principal  [Carne] [Pasta])
         (descripcion  "Fideos a la cazuela")
         (saludable  "false")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([FileteMero] of Segundo
         (alergenos  [Pescado])
         (ingrediente_principal  [Pescado])
         (descripcion  "Filete de mero con patatas al vapor")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([FiletePollo] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Filete de pollo a la plancha con tomate y aceitunas")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "alto")
    )

    ([Flan] of Postre
         (alergenos  [Huevo] [Lactosa])
         (ingrediente_principal  [Huevo] [Lacteo])
         (descripcion  "Flan")
         (saludable  "false")
         (azucares  "alto")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([Fruta] of TipoComida
    )

    ([FrutosSecos] of Intolerancia
    )

    ([GalletasIntegrales] of Desayuno
         (alergenos  [Celiaco])
         (ingrediente_principal  [Cereales])
         (descripcion  "Galletas integrales")
         (saludable  "true")
         (tipo_plato  "Desayuno")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([Gazpacho] of Primero
         (ingrediente_principal  [Verduras])
         (descripcion  "Gazpacho")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([HamburguesaPisto] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Hamburguesa de ternera con pisto")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([Huevo] of TipoComida
    )

    ([JudiasPatatas] of Primero
         (ingrediente_principal  [Patata] [Verduras])
         (descripcion  "Judías y patatas salteadas con jamón")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([KiwiMandarina] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Combinado de kiwi con mandarina")
         (saludable  "true")
         (temporada  "frio")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Lacteo] of TipoComida
    )

    ([Lactosa] of Intolerancia
    )

    ([LasañaVerano] of Primero
         (alergenos  [Celiaco] [Huevo])
         (ingrediente_principal  [Pasta])
         (descripcion  "Lasaña de verano")
         (saludable  "false")
         (temporada  "calor")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Legumbres] of TipoComida
    )

    ([LentejasEstofadas] of Primero
         (ingrediente_principal  [Legumbres])
         (descripcion  "Lentejas estofadas con verduras")
         (saludable  "false")
         (temporada  "frio")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([LomoSal] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Lomo a la sal con puré de manzana")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([Macedonia] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Macedonia")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Mandarinas] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Mandarinas")
         (saludable  "true")
         (temporada  "frio")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([ManzanaHorno] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Manzana al horno")
         (saludable  "true")
         (temporada  "frio")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Melocoton] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Melocotón")
         (saludable  "true")
         (temporada  "calor")
         (tipo_plato  "postre")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Melon] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Melón")
         (saludable  "true")
         (temporada  "calor")
         (tipo_plato  "Postre")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Membrillo] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Membrillo")
         (saludable  "false")
         (azucares  "alto")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([Menestra] of Primero
         (ingrediente_principal  [Verduras])
         (descripcion  "Menestra tricolor")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([MerluzaPlancha] of Segundo
         (alergenos  [Pescado])
         (ingrediente_principal  [Pescado] "Pescado")
         (descripcion  "Merluza a la plancha y ensalada de lechuga con maíz")
         (saludable  "true")
         (tipo_plato  "Segundo")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "bajo")
         (hierro  "alto")
    )

    ([MouseYogur] of Postre
         (alergenos  [Lactosa])
         (ingrediente_principal  [Lacteo])
         (descripcion  "Mouse de yogur")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Muesli] of Desayuno
         (alergenos  [Celiaco] [Lactosa])
         (ingrediente_principal  [Cereales] [Lacteo])
         (descripcion  "Leche con muesli")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([MuslitosPollo] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Muslitos de pollo asados")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([NaranjasMiel] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Rodajas de naranja con miel")
         (saludable  "true")
         (temporada  "frio")
         (azucares  "alto")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([Nectarina] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Nectarina")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Nisperos] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Nísperos")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Osteoporosis] of Enfermedad
    )

    ([PaellaPescado] of Segundo
         (alergenos  [Pescado])
         (ingrediente_principal  [Arroz] [Pescado])
         (descripcion  "Paella de pescado")
         (saludable  "false")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([Pan] of TipoComida
    )

    ([PanMermelada] of Desayuno
         (alergenos  [Celiaco])
         (ingrediente_principal  [Pan])
         (descripcion  "Pan de molde tostado con mermelada")
         (saludable  "false")
         (azucares  "alto")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([PapilloteSalmon] of Segundo
         (alergenos  [Celiaco] [Pescado])
         (ingrediente_principal  [Pescado])
         (descripcion  "Papillote de salmón y merluza")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "bajo")
         (hierro  "alto")
    )

    ([Pasta] of TipoComida
    )

    ([PastaZanahoria] of Primero
         (alergenos  [Celiaco])
         (ingrediente_principal  [Pasta])
         (descripcion  "Pasta fresca con zanahoria y remolacha rallada")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([Patata] of TipoComida
         (tipo_TipoComida  "Fibra")
    )

    ([PatatasProvenzal] of Primero
         (ingrediente_principal  [Patata])
         (descripcion  "Tomates con patatas a la provenzal")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([Pera] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Pera")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([PeraMiel] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Dados de pera con miel")
         (saludable  "true")
         (temporada  "frio")
         (azucares  "alto")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([PescaditoFrito] of Segundo
         (alergenos  [Celiaco] [Pescado])
         (ingrediente_principal  [Pescado])
         (descripcion  "Pescadito frito con lechuga")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([Pescado] of TipoComida
    )

    ([Pizza4Estaciones] of Segundo
         (alergenos  [Celiaco] [Lactosa])
         (ingrediente_principal  [Pasta])
         (descripcion  "Pizza 4 estaciones")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "medio")
    )

    ([PizzaJamonQueso] of Segundo
         (alergenos  [Celiaco] [Lactosa])
         (ingrediente_principal  [Pasta])
         (descripcion  "Pizza de jamón y queso")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "medio")
    )

    ([Piña] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Piña natural")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([Platano] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Plátano")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([PlatanoFresas] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Macedonia de plátano y fresas")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([PolloCerveza] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Pollo a la cerveza")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([PolloHorno] of Segundo
         (ingrediente_principal  [Carne] "Pollo")
         (descripcion  "Pollo al horno con berenjenas asadas")
         (saludable  "true")
         (tipo_plato  "Segundo")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "alto")
    )

    ([Potaje] of Primero
         (ingrediente_principal  [Legumbres])
         (descripcion  "Potaje")
         (saludable  "false")
         (temporada  "frio")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([PurePatataZanahoria] of Primero
         (alergenos  [Lactosa])
         (ingrediente_principal  [Patata])
         (descripcion  "Puré de patata y zanahoria gratinado")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([SalchichasPlancha] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Salchichas a la plancha con espinacas salteadas")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([Sandia] of Postre
         (ingrediente_principal  [Fruta])
         (descripcion  "Sandía")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([SepiaPlancha] of Segundo
         (ingrediente_principal  [Pescado])
         (descripcion  "Sepia a la plancha con chips de calabacín")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([SolomilloCerdo] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Solomillo de cerdo con alcachofas")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([SopaArroz] of Primero
         (ingrediente_principal  [Arroz])
         (descripcion  "Sopa de arroz")
         (saludable  "true")
         (temporada  "frio")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([SopaCebolla] of Primero
         (ingrediente_principal  [Verduras])
         (descripcion  "Sopa de cebolla")
         (saludable  "true")
         (temporada  "frio")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([SopaMelon] of Primero
         (ingrediente_principal  [Fruta])
         (descripcion  "Sopa fría de melón")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "medio")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([SopaPescado] of Primero
         (alergenos  [Pescado])
         (ingrediente_principal  [Celiaco] [Pescado])
         (descripcion  "Sopa de pescado con fideos")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([SorbeteLimon] of Postre
         (alergenos  [Huevo])
         (ingrediente_principal  [Fruta])
         (descripcion  "Sorbete de limón")
         (saludable  "false")
         (temporada  "calor")
         (azucares  "alto")
         (calcio  "medio")
         (calorias  "alto")
         (hierro  "medio")
    )

    ([TerneraPlancha] of Segundo
         (ingrediente_principal  [Carne])
         (descripcion  "Ternera a la plancha con patatas fritas")
         (saludable  "true")
         (azucares  "bajo")
         (calcio  "medio")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([Tortellini] of Primero
         (alergenos  [Celiaco])
         (ingrediente_principal  [Pasta])
         (descripcion  "Tortellini a la Italiana")
         (saludable  "false")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([TortillaPaisana] of Segundo
         (alergenos  [Huevo])
         (ingrediente_principal  [Huevo])
         (descripcion  "Tortilla paisana")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([TortillaPatata] of Segundo
         (alergenos  [Huevo])
         (ingrediente_principal  [Huevo] "Huevo")
         (descripcion  "Tortilla de patata y cebolla y pan con tomate")
         (saludable  "false")
         (tipo_plato  "Segundo")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([TortillaPatataCalabacin] of Segundo
         (ingrediente_principal  [Huevo])
         (descripcion  "Tortilla de patata, cebolla y calabacín")
         (saludable  "false")
         (azucares  "bajo")
         (calcio  "alto")
         (calorias  "alto")
         (hierro  "alto")
    )

    ([TostadaMantequilla] of Desayuno
         (alergenos  [Celiaco] [Lactosa])
         (ingrediente_principal  [Pan])
         (descripcion  "Tostadas con mantequilla y mermelada")
         (saludable  "false")
         (azucares  "alto")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([TostadaQueso] of Desayuno
         (alergenos  [Celiaco] [Lactosa])
         (ingrediente_principal  [Pan])
         (descripcion  "Tostadas con queso fresco")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([Verduras] of TipoComida
    )

    ([YogurCereales] of Desayuno
         (alergenos  [Celiaco] [FrutosSecos] [Lactosa])
         (ingrediente_principal  [Lacteo])
         (descripcion  "Yogur con cereales y frutos secos")
         (saludable  "true")
         (azucares  "alto")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "alto")
    )

    ([YogurCerealesFruta] of Desayuno
         (alergenos  [Celiaco] [Lactosa])
         (ingrediente_principal  [Lacteo])
         (descripcion  "Yogur con cereales y fruta troceada")
         (saludable  "true")
         (azucares  "alto")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([YogurFrutas] of Desayuno
         (alergenos  [Lactosa])
         (ingrediente_principal  [Lacteo])
         (descripcion  "Yogur con trozos de fruta")
         (saludable  "true")
         (tipo_plato  "Desayuno")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "medio")
    )

    ([YogurMelocoton] of Postre
         (alergenos  [Lactosa])
         (ingrediente_principal  [Fruta] [Lacteo])
         (descripcion  "Yogur con melocotón")
         (saludable  "true")
         (temporada  "calor")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "bajo")
         (hierro  "medio")
    )

    ([YogurTostadas] of Desayuno
         (alergenos  [Celiaco] [Lactosa])
         (ingrediente_principal  [Lacteo] [Pan])
         (descripcion  "Yogur con tostadas y mermelada")
         (saludable  "true")
         (azucares  "medio")
         (calcio  "alto")
         (calorias  "medio")
         (hierro  "medio")
    )

)
