/* Base de datos */

-- Base de datos hospital ------------------------------------------------------
DROP DATABASE IF EXISTS hospital;
CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;
--------------------------------------------------------------------------------

/* Tablas */

-- Tabla trabajador ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS trabajador (
  numero_colegiado INT (9) NOT NULL,
  dni CHAR (9) NOT NULL,
  nombre VARCHAR (25) NOT NULL,
  apellido1 VARCHAR (25) NOT NULL,
  apellido2 VARCHAR (25),
  sexo ENUM('H','M') NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  -- Tipo 'M'edico / 'E'nfermera
  tipo ENUM ('M','E') NOT NULL,
  -- Categoría médicos: Médico en Prácticas, Doctor, Jefe de Medicina
  -- Categoría enfermera: Enfermera en Prácticas, Enfermera, Jefa de Enfermería
  categoria ENUM ('MP','D','JF','EP','E','JE') NOT NULL,
  -- De 0 a 999
  experiencia INT(3) NOT NULL,
  telefono VARCHAR (15) NOT NULL,
  direccion VARCHAR (50)  NOT NULL,
  localidad VARCHAR (50) NOT NULL,
  provincia VARCHAR (50) NOT NULL,
  nacionalidad VARCHAR (50) NOT NULL,
  foto BLOB,
  passwd VARCHAR (128),
  activo ENUM ('S','N') NOT NULL,
  CONSTRAINT pk_trabajador PRIMARY KEY (numero_colegiado),
  CONSTRAINT un_tra_dni UNIQUE (dni),
  CONSTRAINT chk_tra_sexo CHECK (sexo <> ''),
  -- CONSTRAINT chk_tra_edad CHECK ((NOW()-fecha_nacimiento >= 22) AND (NOW()-fecha_nacimiento <= 67)),
  CONSTRAINT chk_tra_tipo CHECK (tipo <> ''),
  CONSTRAINT chk_tra_categoria CHECK (categoria <> ''),
  CONSTRAINT chk_tra_experiencia CHECK (experiencia >= 0),
  CONSTRAINT chk_tra_activo CHECK (activo <> '')
);
--------------------------------------------------------------------------------

-- Tabla médico ----------------------------------------------------------------
DROP TABLE IF EXISTS medico;
CREATE TABLE IF NOT EXISTS medico (
  numero_colegiado_medico INT (9) NOT NULL,
  -- Cualificación 'P'siquiatría / 'C'irugía
  especialidad ENUM ('P','C'),
  CONSTRAINT pk_medico PRIMARY KEY (numero_colegiado_medico),
  CONSTRAINT fk_med_num_col_tra_num_col FOREIGN KEY (numero_colegiado_medico)
    REFERENCES trabajador (numero_colegiado)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT chk_med_es CHECK (
    (SELECT tipo FROM trabajador WHERE numero_colegiado_medico = numero_colegiado) = 'M'),
  CONSTRAINT chk_med_especialidad CHECK (especialidad <> '')
  );
--------------------------------------------------------------------------------

-- Tabla enfermera -------------------------------------------------------------
DROP TABLE IF EXISTS enfermera;
CREATE TABLE IF NOT EXISTS enfermera (
  numero_colegiado_enfermera INT (9) NOT NULL,
  CONSTRAINT pk_enfermera PRIMARY KEY (numero_colegiado),
  CONSTRAINT fk_enf_num_col_tra_num_col FOREIGN KEY (numero_colegiado)
    REFERENCES trabajador (numero_colegiado)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT chk_enfermera CHECK (
    (SELECT tipo FROM trabajador WHERE numero_colegiado_enfermera = numero_colegiado) = 'E'
  )
);
--------------------------------------------------------------------------------

-- Tabla paciente --------------------------------------------------------------
DROP TABLE IF EXISTS paciente;
CREATE TABLE IF NOT EXISTS paciente (
  nss INT (8) NOT NULL,
  nombre VARCHAR (25) NOT NULL,
  apellido1 VARCHAR (25) NOT NULL,
  apellido2 VARCHAR (25),
  fecha_nacimiento DATE NOT NULL,
  sexo ENUM('H','M') NOT NULL,
  telefono VARCHAR (15),
  direccion VARCHAR (50),
  localidad VARCHAR (50),
  provincia VARCHAR(50),
  pais VARCHAR (50),
  seguro VARCHAR (50),
  numero_seguro VARCHAR (25),
  CONSTRAINT pk_paciente PRIMARY KEY (nss),
  -- CONSTRAINT chk_nombre CHECK (nombre REGEX '^[a-zA-Z\s]+$'),
  -- CONSTRAINT chk_apellidos CHECK (apellido1 REGEX '^[a-zA-Z\s]+$' AND apellido2 REGEX '^[a-zA-Z\s]+$'),
  CONSTRAINT chk_sexo CHECK (sexo <> '')
);
--------------------------------------------------------------------------------

-- Tabla historial -------------------------------------------------------------
DROP TABLE IF EXISTS historial;
CREATE TABLE IF NOT EXISTS historial (
  id INT (8) NOT NULL AUTO_INCREMENT,
  grupo_sanguineo CHAR (2) NOT NULL,
  rh CHAR (1) NOT NULL,
  -- Vista tipo_sanguíneo
  observaciones VARCHAR (255),
  vacunas VARCHAR (255),
  alergias VARCHAR (255),
  nss INT (8),
  CONSTRAINT pk_historial PRIMARY KEY (id),
  CONSTRAINT fk_his_nss_pac_nss FOREIGN KEY (nss)
    REFERENCES paciente (nss)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);
--------------------------------------------------------------------------------

-- Tabla linea_historial -------------------------------------------------------
DROP TABLE IF EXISTS linea_historial;
CREATE TABLE IF NOT EXISTS linea_historial (
  historial INT (8) NOT NULL,
  linea INT (6) NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  firma INT (9) NOT NULL,
  CONSTRAINT pk_lin_his PRIMARY KEY (linea),
  CONSTRAINT fk_lin_his_his_his_id FOREIGN KEY (historial)
    REFERENCES historial (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_lin_his_fir_med_num_col FOREIGN KEY (firma)
    REFERENCES medico (numero_colegiado)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);
--------------------------------------------------------------------------------

-- Tabla sala ------------------------------------------------------------------
DROP TABLE IF EXISTS sala;
CREATE TABLE IF NOT EXISTS sala (
  id INT (3),
  nombre VARCHAR (25) DEFAULT NULL,
  coste DECIMAL (7,2) DEFAULT 0,
  -- 'M'edico, 'E'nfermera, 'T'odos
  trabajador ENUM ('M','E','T') NOT NULL,
  descripcion VARCHAR (255) NOT NULL,
  CONSTRAINT pk_sala PRIMARY KEY (id)
);
--------------------------------------------------------------------------------

-- Tabla tipo_sala -------------------------------------------------------------
CREATE TABLE tipo_sala (
  id INT (2),
  tipo ENUM ('Diagnosis','Tratamiento','Consulta','Instalación') NOT NULL,
  CONSTRAINT pk_sala_tipo PRIMARY KEY (id),
  CONSTRAINT chk_tip_sal_tip CHECK (tipo <> '')
);
--------------------------------------------------------------------------------

-- Tabla sala_tipo -------------------------------------------------------------
CREATE TABLE sala_tipo (
  id_sala INT (3),
  id_tipo INT (2),
  CONSTRAINT pk_sala_tipo PRIMARY KEY (id_sala,id_tipo),
  CONSTRAINT fk_sal_tip_id_sal_sal_id FOREIGN KEY (id_sala)
    REFERENCES sala (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_sal_tip_id_tip_tip_sal FOREIGN KEY (id_tipo)
    REFERENCES tipo_sala (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
--------------------------------------------------------------------------------

-- Tabla enfermedad ------------------------------------------------------------
DROP TABLE IF EXISTS enfermedad;
CREATE TABLE IF NOT EXISTS enfermedad (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR (25) DEFAULT NULL,
  causa VARCHAR (100) DEFAULT NULL,
  sintoma VARCHAR (150) DEFAULT NULL,
  cura VARCHAR (150) DEFAULT NULL,
  sexo ENUM ('H','M','T') NOT NULL DEFAULT 'T',
  sala INT NOT NULL,
  CONSTRAINT pk_enfermedad PRIMARY KEY (id)
);
--------------------------------------------------------------------------------

/* Datos */

-- Datos pacientes -------------------------------------------------------------
--------------------------------------------------------------------------------

-- Datos historial -------------------------------------------------------------
--------------------------------------------------------------------------------

-- Datos trabajadores ----------------------------------------------------------
--------------------------------------------------------------------------------

-- Datos médicos ---------------------------------------------------------------
--------------------------------------------------------------------------------

-- Datos enfermeras ------------------------------------------------------------
--------------------------------------------------------------------------------

-- Datos linea -----------------------------------------------------------------
--------------------------------------------------------------------------------
  
-- Datos sala ------------------------------------------------------------------
INSERT INTO sala (id, nombre, coste, trabajador, descripcion) VALUES
  (1, 'Consulta', 50, 'M', 'Los pacientes tienen aquí su primera consulta'),
  (2, 'Diagnóstico', 100, 'E', 'La enfermera utiliza la consulta de medicina general para hacer un diagnóstico básico'),
  (3, 'Cardiología', 100, 'E', 'El enfermera utiliza el cardiómetro para diagnosticar a los pacientes'),
  (4, 'Escáner', 200, 'E', 'La enfermera usa el escáner para diagnosticar a los pacientes'),
  (5, 'Ultra escáner', 3000, 'M', ''),
  (6, 'Transfusiones', 1000, 'E', 'La enfermera utiliza el transfusiómetro para diagnosticar a los pacientes'),
  (7, 'Rayos X', 2000, 'M', 'El médico usa Rayos X para diagnosticar a los pacientes'),
  (8, 'Psiquiatría', 100, 'M', 'La consulta de psiquiatría cura a los pacientes locos y ayuda a diagnosticar a otros pacientes, pero requiere un médico cualificado en psiquiatría'),
  (9, 'Enfermería', 100, 'E', 'Los pacientes son enviados a la enfermeria para su observación y para recuperarse de una operación bajo el cuidado el cuidado de una enfermera'),
  (10, 'Quirófano', 10000, 'M', 'Dos médicos con cualificación de cirujano operan al paciente'),
  (11, 'Farmacia', 500, 'E', 'En la farmacia, una enfermera administra medicinas para curar a los pacientes'),
  (12, 'Inflatoterapia', 500, 'M', ''),
  (13, 'Laringología', 500, 'M', ''),
  (14, 'Traumatología', 500, 'M', ''),
  (15, 'Peloterapia', 500, 'M', 'El médico usa el pelorresturador para curar la calvicie'),
  (16, 'Electrólisis', 500, 'M', 'El médico usa la consulta de electrólisis para curar el peludismo'),
  (17, 'Genética', 500, 'M', 'El médico usa el restaurador de ADN para curar a los pacientes con ADN alienígena'),
  (18, 'Baño gelatinoso', 500, 'M', 'El médico usa el baño gelatinoso para curar la gelatinitis'),
  (19, 'Descontaminación', 500, 'M', 'El médico usa la ducha descontaminante para curar la radiactividad'),
  (20, 'Sala de personal', -100, 'T', 'Los médicos y enfermeras pueden descansar en esta sala'),
  (21, 'Investigación', -100, 'M', 'En la sala de investigación, los médicos investigadores investigan nuevas medicinas y máquinas'),
  (22, 'Aseos', -100, 'T', NULL),
  (23, 'Formación', -100, 'T', 'La sala de formación se emplea para que un especialista forme a otros trabajadores')
;
--------------------------------------------------------------------------------

-- Datos tipo_sala -------------------------------------------------------------
INSERT INTO tipo_sala (id, tipo) VALUES
  (1, 'Consulta'),
  (2, 'Diagnosis'),
  (3, 'Tratamiento'),
  (4, 'Instalación')
;
--------------------------------------------------------------------------------

-- Datos sala_tipo -------------------------------------------------------------
INSERT INTO sala_tipo (id_sala, id_tipo) VALUES
  -- Consulta
  (1,1),
  -- Diagnóstico
  (2,2),
  -- Cardiología
  (3,2),
  -- Escáner
  (4,2),
  -- Ultra escáner
  (5,2),
  -- Transfusiones
  (6,2),
  -- Rayos X
  (7,2),
  -- Psiquiatría
  (8,2), (8,3),
  -- Enfermería
  (9,2), (9,3),
  -- Quirófano
  (10,3),
  -- Farmacia
  (11,3),
  -- Inflatoterapia
  (12,3),
  -- Laringología
  (13,3),
  -- Traumatología
  (14,3),
  -- Peloterapia
  (15,3),
  -- Electrólisis
  (16,3),
  -- Genética
  (17,3),
  -- Baño gelatinoso
  (18,3),
  -- Descontaminación
  (19,3),
  -- Sala de personal
  (20,4),
  -- Investigación
  (21,4),
  -- Aseos
  (22,4),
  -- Formación
  (23,4)
;
--------------------------------------------------------------------------------

-- Datos enfermedades ----------------------------------------------------------
INSERT INTO enfermedad (id, nombre, causa, sintoma, cura, sexo, sala) VALUES
  (1, 'Paciente cabezudo', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tamaño correcto con una máquina inteligente', 'T', 14), 
  (2, 'Peludismo', 'Exposición prolongada a la luna', 'Los pacientes experimentan un aumento del olfato', 'Una máquina de electrólisis elimina el vello y cierra los poros', 'T', 18), 
  (3, 'Síndrome de rey', 'El espíritu del rey se introduce en la mente del paciente y se apodera de ella', 'Calzar unos zapatos de ante teñidos y comer hamburguesas', 'Un psiquiatra le dice al paciente lo ridículo o ridícula que está', 'T', 8), 
  (4, 'Invisibilitis', 'El picotazo de una hormiga radiactiva (e invisible)', 'Los pacientes no sufren. Incluso, muchos se valen de su enfermedad para gastar bromas a sus familiares', 'Beber un líquido coloreado en la farmacia, pronto hace completamente visible al paciente', 'T', 13), 
  (5, 'Radiacción grave', 'Confundir isótopos de plutonio con chicle', 'Los pacientes que padecen esta enfermedad se sienten muy, pero que muy mal', 'Se debe dar al paciente una ducha descontaminadora y limpiarlo bien', 'T', 21), 
  (6, 'Lengua caida', 'Hablar sin parar sobre culebrones', 'La lengua crece hasta cinco veces su tamaño original', 'Se coloca la lengua en el acortalenguas y se elimina de forma rápida, eficaz y dolorosa', 'T', 15), 
  (7, 'ADN alienigena', 'Enfrentarse a gigantes provistos de sangre alienígena inteligente.', 'metamorfosis gradual en alienígena y desear destruir nuestras ciudades', 'El ADN se extrae con una máquina, se purifica de elementos alienígenas y se vuelve a colocar rápidamente', 'T', 19), 
  (8, 'Fracturas óseas', 'La caída de cosas voluminosas sobre el cemento', 'Un gran crujido y la imposibilidad de usar los miembros afectados', 'Se pone una escayola, que después se quita con un láser quitaescayolas', 'T', 16), 
  (9, 'Calvicie', 'Contar mentiras e inventar historias para ser famoso', 'Tener la cabeza brillante y pasar vergüenza', 'El pelo se cose a la cabeza del paciente con una dolorosa máquina', 'H', 17) ,
  (10, 'Picor leve', 'Insectos diminutos con los dientes afilados', 'Rascarse, lo que conduce a una inflamación de la parte afectada', 'El paciente bebe un jarabe pegajoso que evita que la piel pique', 'T', 13), 
  (11, 'Gelatinitis', 'Una dieta rica en gelatina y demasiado ejercicio', 'Un temblor excesivo y caerse al suelo muchas veces', 'Se sumerge al paciente durante un rato en el baño gelatinoso en una consulta especial', 'T', 20), 
  (12, 'Somnolencia', 'Una glándula del sueño hiperactiva en el paladar', 'Un deseo imperioso de tirarse en cualquier parte', 'Una enfermera administra una elevada dosis de un poderoso estimulante', 'T', 13), 
  (13, 'Embarazo', 'Cortes de electricidad en zonas urbanas', 'Comer de capricho con el consecuente malestar de estómago', 'Se extrae al bebé en el quirófano, se limpia y se entrega al paciente', 'M', 10), 
  (14, 'Transparentitis', 'Lamer el yogurt que queda en las tapas de los tarros abiertos', 'la carne se transparenta y se ve horrible', 'Tomar una preparación farmacéutica de agua enfriada y coloreada de modo especial', 'T', 13), 
  (15, 'Catarro atípico', 'Pequeñas partículas de moco en el aire', 'Mucosidad, estornudos y pulmones descoloridos', 'Beber un gran trago de una medicina para la tos anormal que se fabrica en la farmacia con ingredientes especiales', 'T', 13), 
  (16, 'Aerofagia', 'Usar un aparato gimnástico después de las comidas', 'Molestar a la gente que está justo detrás del paciente', 'En la farmacia se bebe rápidamente una fuerte mezcla de átomos acuosos', 'T', 13), 
  (17, 'Costillas de más', 'Sentarse sobre suelos muy fríos', 'Un malestar en el pecho', 'Un cirujano extrae las costillas y se las da al paciente en una bolsita', 'T', 10), 
  (18, 'Incontinencia', 'Masticar los cubitos de hielo de las bebidas', 'Dolor e ir con frecuencia al baño', 'El cirujano extrae los cálculos sin rozar los bordes del riñón', 'T', 10), 
  (19, 'Infelicidad', 'Alguien más rico, más joven y más delgado que el paciente', 'Llorar y reír después de pasarse horas rompiendo fotos de las vacaciones', 'Un cirujano abre el pecho y arregla con delicadeza el corazón mientras contienen la respiración', 'T', 10), 
  (20, 'Boluditis', 'Tirarse de cabeza al agua fría', 'Imposibilidad de sentarse cómodamente', 'Un cirujano cualificado coloca ciertas partes con manos firmes', 'T', 10), 
  (21, 'Arguiñanitis', 'Ver la televisión durante el día', 'Tener la ilusión de presentar en la tele un programa de cocina', 'Un psiquiatra experto debe convencer al paciente de que venda su televisor y se compre una radio', 'T', 8), 
  (22, 'Risa contagiosa', 'Comedia clásica de situación', 'No poder parar de reír y repetir frases hechas nada divertidas', 'Un psiquiatra cualificado debe recordar al paciente que su enfermedad es grave', 'T', 8), 
  (23, 'Tobillo torcido', 'Atropellar señales de tráfico en la carretera', 'Los pies no caben bien en los zapatos', 'Los tobillos se enderezan bebiendo una infusión ligeramente tóxica de hierbas y plantas', 'T', 13), 
  (24, 'Nariz peluda', 'Oler con desprecio a aquellos que están peor que el paciente', 'Tener tanto pelo en la nariz como para hacer una peluca', 'Se toma por vía oral un jarabe quitapelo que la enfermera ha preparado en la farmacia', 'T', 13), 
  (25, 'Horteritis', 'Anhelar con ansia los años 70', 'Pelo largo, ropa ancha, plataformas y mucho maquillaje', 'El personal psiquiátrico debe, empleando técnicas actualizadas, convencer al paciente de que esta moda es horrible', 'T', 8), 
  (26, 'Sangre corrupta', 'El paciente suele ser el blanco de las bromas', 'Fluido rojo en las venas que se evapora al contacto con la ropa', 'Este problema sólo se resuelve con tratamiento psiquiátrico', 'T', 8), 
  (27, 'Vomitona', 'Comida mejicana o india muy condimentada', 'El paciente vomita la comida a medio digerir en cualquier momento', 'Beber un preparado astringente especial para detener los vómitos', 'T', 13), 
  (28, 'Descomposición', 'Comer pizza que se ha encontrado debajo de la cocina', '¡Agh! Seguro que te los puedes imaginar', 'Una mezcla pegajosa de sustancias viscosas preparada en la farmacia solidifica las tripas del paciente', 'T', 13), 
  (29, 'Pulmón de acero', 'La contaminación urbana mezclada con restos de Kebab', 'Capacidad para aspirar fuego y gritar debajo del agua', 'Un cirujano realiza una operación para eliminar las partes duras del pulmón en el quirófano', 'T', 10), 
  (30, 'Manos sudorosas', 'Temer las entrevistas de trabajo', 'Dar la mano al paciente es como coger una esponja empapada', 'Un psiquiatra debe discutir a fondo con el paciente sobre esta enfermedad inventada', 'T', 8), 
  (31, 'Hemorroides', 'Permanecer de pie junto a refrigeradores de agua', 'El paciente se siente como si estuviera sentado sobre una bolsa de canicas', 'Una bebida agradable, aunque muy ácida, disuelve las hemorroides internas', 'T', 13), 
  (32, 'Úlcera gastrica', 'El Jarabe para la tos, a base de whisky, de la Sra. McGuiver', 'El paciente no tose, pero tampoco tiene paredes en el estómago', 'Una enfermera administra una variada disolución de sustancias químicas para revestir el estómago', 'T', 13), 
  (33, 'Cálculos de golf', 'Inhalar el gas venenoso que contienen las pelotas de golf', 'Delirar y sentir mucha vergüenza', 'Un cirujano opera para extraer los cálculos', 'T', 10), 
  (34, 'Gaseocontención', 'Cualquier cosa imprevista', 'Inflamación', 'Sólo puede reducirse la inflamación con una lanceta durante una operación que requiere dos cirujanos', 'T', 10)
;
--------------------------------------------------------------------------------
