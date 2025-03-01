DROP DATABASE IF EXISTS hospital;
CREATE DATABASE IF NOT EXISTS hospital;
---

-- Tabla paciente
DROP TABLE IF EXISTS paciente;
CREATE TABLE IF NOT EXISTS paciente (
  nss INT (8) NOT NULL,
  nombre VARCHAR (25) NOT NULL,
  apellido1 VARCHAR (25) NOT NULL,
  apellido2 VARCHAR (25),
  -- VISTA apellidos
  fecha_nacimiento DATE NOT NULL,
  sexo ENUM('H','M'),
  telefono VARCHAR (15),
  direccion VARCHAR (50),
  localidad VARCHAR (50),
  provincia VARCHAR(50),
  pais VARCHAR (50),
  seguro VARCHAR (50),
  numero_seguro VARCHAR (25)

  /*
  CONSTRAINT pk_paciente PRIMARY KEY (nss),
  CONSTRAINT chk_nombre CHECK (nombre REGEX '^[a-zA-Z\s]+$'),
  CONSTRAINT chk_apellidos CHECK (apellido1 REGEX '^[a-zA-Z\s]+$' AND apellido2 REGEX '^[a-zA-Z\s]+$'),
  CONSTRAINT chk_fecha_nacimiento CHECK (fecha_nacimiento <= NOW()),
  CONSTRAINT chk_sexo CHECK (sexo <> ''),
  */
);
  
-- Tabla historial
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

-- Tabla linea_historial
DROP TABLE IF EXISTS linea_historial;
CREATE TABLE IF NOT EXISTS linea_historial (
  historial INT (8) NOT NULL,
  linea INT (6) NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  firma NOT NULL
  CONSTRAINT pk_lin_his PRIMARY KEY (historial,linea),
  CONSTRAINT fk_lin_his_his_his_id FOREIGN KEY (historial)
    REFERENCES historial (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Tabla trabajador
DROP TABLE IF EXISTS linea_historial;
CREATE TABLE IF NOT EXISTS linea_historial (

  

  
  

DROP TABLE IF EXISTS sala;
CREATE TABLE IF NOT EXISTS sala (
  id INT,
  nombre VARCHAR (25) DEFAULT=NULL,
  coste DECIMAL (7.2) DEFAULT=0,
  trabajador ENUM ('M','E') NOT NULL,
  descripcion VARCHAR (255) NOT NULL,
);

INSERT INTO sala (id, nombre, trabajador) VALUES
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
  (13, 'Farmacia', 500, 'E', 'En la farmacia, una enfermera administra medicinas para curar a los pacientes'),
  (14, 'Inflatoterapia', 500, 'M', ''),
  (15, 'Laringología', 500, 'M', ''),
  (16, 'Traumatología', 500, 'M', ''),
  (17, 'Peloterapia', 500, 'M', 'El médico usa el pelorresturador para curar la calvicie'),
  (18, 'Electrólisis', 500, 'M', 'El médico usa la consulta de electrólisis para curar el peludismo'),
  (19, 'Genética', 500, 'M', 'El médico usa el restaurador de ADN para curar a los pacientes con ADN alienígena'),
  (20, 'Baño gelatinoso', 500, 'M', 'El médico usa el baño gelatinoso para curar la gelatinitis'),
  (21, 'Descontaminación', 500, 'M', 'El médico usa la ducha descontaminante para curar la radiactividad'),
  (22, 'Sala de personal', 500, 'T', 'Los médicos y enfermeras pueden descansar en esta sala'),
  (23, 'Investigación', 500, 'M', 'En la sala de investigación, los médicos investigadores investigan nuevas medicinas y máquinas'),
  (24, 'Aseos', 500, 'E', NULL),
  (25, 'Formación', 500, 'E', 'La sala de formación se emplea para que un especialista forme a otros trabajadores'),


  
CREATE TABLE sala_tipo (
  id INT,
  tipo ENUM ('Diagnosis','Tratamiento','Consulta','Instalación'),
  CONSTRAINT pk_sala_tipo PRIMARY KEY (id, tipo),
  CONSTRAINT fk_sal_id_sal
  
  
  
  DROP TABLE IF EXISTS enfermedad;
CREATE TABLE IF NOT EXISTS enfermedad (
  id INT AUTO_NUMBER,
  nombre VARCHAR (25) DEFAULT=NULL,
  causa VARCHAR (100) DEFAULT=NULL,
  sintoma VARCHAR (100) DEFAULT=NULL,
  cura VARCHAR (100) DEFAULT=NULL,
  sexo ENUM ('H','M','T') NOT NULL DEFAULT='T',
  sala INT NOT NULL,
)

INSERT INTO enfermedad (id, nombre,causa,sintoma,cura, sexo, sala) VALUES
  (1, 'Paciente cabezudo', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (2, 'Peludismo', 'Exposición prolongada a la luna', 'Los pacientes experimentan un aumento del olfato', 'Una máquina de electrólisis elimina el vello y cierra los poros', 'T', ), 
  (3, 'Síndrome de rey', 'El espíritu del rey se introduce en la mente del paciente y se apodera de ella', 'Calzar unos zapatos de ante teñidos y comer hamburguesas', 'Un psiquiatra le dice al paciente lo ridículo o ridícula que está', 'T', ), 
  (4, 'Invisibilitis', 'El picotazo de una hormiga radiactiva (e invisible)', 'Los pacientes no sufren. Incluso, muchos se valen de su enfermedad para gastar bromas a sus familiares', 'Beber un líquido coloreado en la farmacia, pronto hace completamente visible al paciente', 'T', 14), 
  (5, 'Radiacción grave', 'Confundir is¢topos de plutonio con chicle', 'Los pacientes que padecen esta enfermedad se sienten muy, pero que muy mal', 'Se debe dar al paciente una ducha descontaminadora y limpiarlo bien', 'T', ), 
  (6, 'Lengua caida', 'Hablar sin parar sobre culebrones', 'La lengua crece hasta cinco veces su tamaño original', 'Se coloca la lengua en el acortalenguas y se elimina de forma rápida, eficaz y dolorosa', 'T', ), 
  (7, 'ADN alienigena', 'Enfrentarse a gigantes provistos de sangre alienígena inteligente.', 'metamorfosis gradual en alienígena y desear destruir nuestras ciudades', 'El ADN se extrae con una máquina, se purifica de elementos alienígenas y se vuelve a colocar rápidamente', 'T', ), 
  (8, 'Fracturas óseas', 'La caída de cosas voluminosas sobre el cemento', 'Un gran crujido y la imposibilidad de usar los miembros afectados', 'Se pone una escayola, que después se quita con un láser quitaescayolas', 'T', ), 
  (9, 'Calvicie', 'Contar mentiras e inventar historias para ser famoso', 'Tener la cabeza brillante y pasar vergüenza', 'El pelo se cose a la cabeza del paciente con una dolorosa máquina', 'T',), 
  (10, 'Picor leve', 'Insectos diminutos con los dientes afilados', 'Rascarse, lo que conduce a una inflamación de la parte afectada', 'El paciente bebe un jarabe pegajoso que evita que la piel pique', 'T', ), 
  (11, 'Gelatinitis', 'Una dieta rica en gelatina y demasiado ejercicio', 'Un temblor excesivo y caerse al suelo muchas veces', 'Se sumerge al paciente durante un rato en el ba¤o gelatinoso en una consulta especial', 'T', ), 
  (12, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (13, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (14, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (15, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (16, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (17, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (18, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (19, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (20, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (21, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (22, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (23, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (24, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (25, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (26, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (27, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (28, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (29, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (30, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (31, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (32, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
  (33, ' ', 'Oler queso y beber agua de lluvia no purificada', 'Muy incómodos para el que la padece', 'Se pincha la cabeza hinchada y luego se vuelve a inflar hasta el tama¤o correcto con una máquina inteligente', 'T', 14), 
