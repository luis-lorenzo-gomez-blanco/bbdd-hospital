DROP DATABASE IF EXISTS hospital;
CREATE DATABASE IF NOT EXISTS hospital;
---
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
  sala INT NOT NULL,
  sexo ENUM ('H','M','T') NOT NULL DEFAULT='T',
)

INSERT INTO enfermedad (id,nombre,causa,sintoma,cura
