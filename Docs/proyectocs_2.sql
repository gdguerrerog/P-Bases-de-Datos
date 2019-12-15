CREATE DATABASE IF NOT EXISTS proyectocs;
USE proyectocs;

DROP TABLE If EXISTS item;
DROP TABLE If EXISTS item_cliente;
DROP TABLE If EXISTS cliente;
DROP TABLE If EXISTS orden_compra;
DROP TABLE If EXISTS asesor;
DROP TABLE If EXISTS orden_compra_asesor;
DROP TABLE If EXISTS orden_compra_espec;
DROP TABLE If EXISTS laboratorista;
DROP TABLE IF EXISTS emitir;
DROP TABLE If EXISTS trazabilidad;
DROP TABLE IF EXISTS resumen_estadistico;
DROP TABLE If EXISTS certificado; 
DROP TABLE If EXISTS humedad;
DROP TABLE If EXISTS termhighum;
DROP TABLE If EXISTS camhum;
DROP TABLE If EXISTS temperatura;
DROP TABLE If EXISTS termhigtem;
DROP TABLE If EXISTS camtem;
DROP TABLE IF EXISTS estBa;
DROP TABLE IF EXISTS zonaBa;
DROP TABLE If EXISTS bloque;
DROP TABLE If EXISTS vidrio;
DROP TABLE If EXISTS analogo;
DROP TABLE If EXISTS digital;
-- Creando tablas 
CREATE TABLE item  
(
Itm_id	VARCHAR(50)		NOT NULL,
Itm_nom	VARCHAR(50)	NOT NULL,
Itm_mar	VARCHAR(50)	NOT NULL,
Itm_mod	VARCHAR(50)	NOT NULL,
Itm_ran	VARCHAR(50)	NOT NULL,
Itm_magn	VARCHAR(50)	NOT NULL,
Itm_almax	VARCHAR(50)	NOT NULL,
Itm_almin	VARCHAR(50)	NOT NULL,
Itm_res DOUBLE NOT NULL,
PRIMARY KEY(Itm_id)
) ENGINE=InnoDB;

CREATE TABLE item_cliente
(
ItmC_id 	VARCHAR(50)	NOT NULL,
ItmC_Cli_nit VARCHAR(50)	NOT NULL REFERENCES cliente(Cli_nit),
ItmC_Itm_id	VARCHAR(50)	NOT NULL REFERENCES item(Itm_id),
ItmC_uso	VARCHAR(50)	NOT NULL,
ItmC_ran	VARCHAR(50)	NOT NULL,
PRIMARY KEY(ItmC_id)
) ENGINE=InnoDB;

CREATE TABLE cliente
(
Cli_nit	VARCHAR(45)	NOT NULL,
Cli_emp	VARCHAR(100)	NOT NULL,
Cli_cont	VARCHAR(100),
Cli_cont_carg	VARCHAR(100),
Cli_tel	INT	NOT NULL,
Cli_fax	INT	NULL,
Cli_mail	VARCHAR(100),
Cli_ciu	VARCHAR(25)	NOT NULL,
Cli_dir	VARCHAR(100)	NOT NULL,
Cli_pwd VARCHAR(25) NOT NULL,
PRIMARY KEY(Cli_nit)
) ENGINE=InnoDB;

CREATE TABLE orden_compra
(
Ordc_id	 INT AUTO_INCREMENT NOT NULL,
Ordc_ItmC_id	VARCHAR(45)	NOT NULL,
Ordc_pcal	VARCHAR(100)	NOT NULL,
Ordc_serv	VARCHAR(25)	NOT NULL,
Ordc_numord	INT	NOT NULL,
Ordc_preciotol	INT	NOT NULL,
Ordc_fec	DATE	NOT NULL,
Ordc_obs	VARCHAR(100) NULL,
Ordc_met	VARCHAR(300)	NOT NULL,
PRIMARY KEY(Ordc_id, Ordc_ItmC_id)
) ENGINE=InnoDB;

CREATE TABLE asesor
(
Ases_id 	INT	NOT NULL,
Ases_nom	VARCHAR(40)	NOT NULL,
PRIMARY KEY(Ases_id)
) ENGINE=InnoDB;

CREATE TABLE orden_compra_asesor 
(
OrdAses_OrdC_id INT NOT NULL auto_increment REFERENCES orden_compra(Ordc_id),
OrdAses_Ordc_ItmC_id VARCHAR(45) NOT NULL REFERENCES orden_compra(Ordc_ItmC_id),
OrdAses_Ases_id INT NOT NULL REFERENCES asesor(Ases_id),
PRIMARY KEY(OrdAses_Ordc_id, OrdAses_Ases_id,OrdAses_Ordc_ItmC_id)
)ENGINE=InnoDB;

CREATE TABLE orden_compra_espec
(
OrdcEs_idmov	INT	NOT NULL AUTO_INCREMENT,
OrdcEs_idart	VARCHAR(20)	NOT NULL,
OrdcEs_Ordc_id	INT NOT NULL REFERENCES orden_compra(Ordc_id) ,
OrdcEs_OrdC_ItemC_id	VARCHAR(50)	NOT NULL REFERENCES orden_compra(Ordc_ItmC_id),
OrdcEs_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
OrdcEs_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
OrdcEs_Lab_id	INT	NOT NULL REFERENCES laboratorista(Lab_id),
OrdcEs_calp	VARCHAR(20) NOT NULL,
OrdcEs_preciopun	DOUBLE	NOT NULL,
OrdcEs_ranc	VARCHAR(100)	NOT NULL,

PRIMARY KEY(OrdcEs_idmov,OrdcEs_idart,OrdcEs_calp)
) ENGINE=InnoDB;


CREATE TABLE laboratorista
(
Lab_id	INT	NOT NULL,
Lab_nom	VARCHAR(40)	NOT NULL,
PRIMARY KEY(Lab_id)
) ENGINE=InnoDB;

CREATE TABLE emitir
(
E_Lab_id INT NOT NULL REFERENCES laboratorista(Lab_id),
E_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
E_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
PRIMARY KEY(E_Lab_id,E_Cert_num,E_Cert_let)
)ENGINE=InnoDB;

CREATE TABLE trazabilidad
(
Traz_Cert_num DOUBLE NOT NULL REFERENCES certificado(Cert_num),
Traz_Cert_let VARCHAR(10) NOT NULL REFERENCES certificado(Cert_let),
Traz_p1	VARCHAR(100),
Traz_p2	VARCHAR(100),
Traz_med	VARCHAR(100),
Traz_s1	 VARCHAR(100)	,
Traz_s2 VARCHAR(100)	,
Traz_s3 VARCHAR(100)	,
Traz_s4 VARCHAR(100)	,
Traz_s5	VARCHAR(100)	,
Traz_s6	VARCHAR(100)	,
Traz_s7	VARCHAR(100)	,
Traz_s8	VARCHAR(100)	,
PRIMARY KEY(Traz_Cert_num,Traz_Cert_let )
) ENGINE=InnoDB;

CREATE TABLE resumen_estadistico(
Est_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Est_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
Est_prog DOUBLE NOT NULL,
Est_Hum_maxp1 DOUBLE ,
Est_Hum_minp1 DOUBLE ,
Est_Hum_maxp2 DOUBLE ,
Est_Hum_minp2 DOUBLE ,
Est_Hum_promp1 DOUBLE ,
Est_Hum_promp2 DOUBLE ,
Est_Hum_desvp1 DOUBLE ,
Est_Hum_desvp2 DOUBLE ,
Est_Tem_maxp1 DOUBLE ,
Est_Tem_minp1 DOUBLE ,
Est_Tem_maxp2 DOUBLE ,
Est_Tem_minp2 DOUBLE ,
Est_Tem_promp1 DOUBLE,
Est_Tem_promp2 DOUBLE,
Est_Tem_desvp1 DOUBLE,
Est_Tem_desvp2 DOUBLE,
PRIMARY KEY (Est_Cert_num,Est_Cert_let,Est_prog)
)ENGINE=InnoDB;

CREATE TABLE certificado
(
Cert_num	INT	AUTO_INCREMENT NOT NULL,
Cert_let	VARCHAR(5)	NOT NULL,
Cert_temax	DOUBLE	NOT NULL, 
Cert_temin	DOUBLE	NOT NULL,
Cert_humax	DOUBLE	NOT NULL,
Cert_humin	DOUBLE	NOT NULL,
PRIMARY KEY(Cert_num,Cert_let)
) ENGINE=InnoDB;

CREATE TABLE humedad
(
Hum_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Hum_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
Hum_prog	DOUBLE	NOT NULL,
Hum_promIBC	DOUBLE	NOT NULL,
Hum_maxIBC	VARCHAR(50)	NOT NULL,
Hum_minIBC	VARCHAR(50)	NOT NULL,
Hum_desvIBC	VARCHAR(50)	NOT NULL,
Hum_incert	VARCHAR(50)	NOT NULL,
Hum_corr	DOUBLE	NOT NULL,
PRIMARY KEY (Hum_Cert_num,Hum_Cert_let,Hum_prog)
) ENGINE=InnoDB;

CREATE TABLE termhighum
(
TermhigHum_Hum_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
TermhigHum_Hum_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
TermhigHum_Hum_prog DOUBLE NOT NULL REFERENCES humedad(Hum_prog),
TermhigHum_estp1	DOUBLE	NOT NULL,
TermhigHum_estp2	DOUBLE	NOT NULL,
TermhigHum_unifex	DOUBLE	NOT NULL,
PRIMARY KEY (TermhigHum_Hum_Cert_num,TermhigHum_Hum_Cert_let,TermhigHum_Hum_prog)
) ENGINE=InnoDB;

CREATE TABLE camhum 
(
Camhum_Hum_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Camhum_Hum_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
CamHum_Hum_prog DOUBLE NOT NULL REFERENCES humedad(Hum_prog),
Camhum_efcar	DOUBLE	NOT NULL,
Camhum_inest	DOUBLE	NOT NULL,
Camhum_inohom	DOUBLE	NOT NULL,
PRIMARY KEY (Camhum_Hum_Cert_num,Camhum_Hum_Cert_let,CamHum_Hum_prog)
) ENGINE=InnoDB;

CREATE TABLE temperatura
(
Tem_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Tem_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
Temp_prog	DOUBLE	NOT NULL,
Temp_promIBC	DOUBLE	NOT NULL,
Temp_maxIBC	DOUBLE	NOT NULL,
Temp_minIBC	DOUBLE	NOT NULL,
Temp_desvIBC	DOUBLE	NOT NULL,
Temp_incert	DOUBLE	NOT NULL,
Temp_corr	DOUBLE	NOT NULL,
PRIMARY KEY(Tem_Cert_num,Tem_Cert_let,Temp_prog)
) ENGINE=InnoDB;

CREATE TABLE termhigtem
(
Termhigtem_Tem_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Termhigtem_Tem_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
Termhigtem_Temp_prog	DOUBLE	NOT NULL REFERENCES temperatura(Temp_prog),
TermhigTem_estp1	VARCHAR(7)	NOT NULL,
TermhigTem_estp2	VARCHAR(7)	NOT NULL,
TermhigTem_unifex	VARCHAR(7)	NOT NULL,
PRIMARY KEY(Termhigtem_Tem_Cert_num,Termhigtem_Tem_Cert_let,Termhigtem_Temp_prog)
) ENGINE=InnoDB;

CREATE TABLE camtem
(
Camtem_Tem_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Camtem_Tem_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
Camtem_Temp_prog	DOUBLE	NOT NULL REFERENCES temperatura(Temp_prog),
Camtem_efcar	DOUBLE	NOT NULL,
Camtem_inest	DOUBLE	NOT NULL,
Camtem_efrad	DOUBLE	NOT NULL,
Camtem_inohom	DOUBLE	NOT NULL,
PRIMARY KEY (Camtem_Tem_Cert_num,Camtem_Tem_Cert_let,Camtem_Temp_prog)
) ENGINE=InnoDB;


CREATE TABLE estBa(
EstBaTem_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
EstBaTem_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
EstBaTem_Temp_prog	DOUBLE	NOT NULL REFERENCES temperatura(Temp_prog),
EstBa_estp	DOUBLE	NOT NULL,
EstBa_incest	DOUBLE	NOT NULL,
Estab_facor	DOUBLE	NOT NULL,
PRIMARY KEY(EstBaTem_Cert_num,EstBaTem_Cert_let,EstBaTem_Temp_prog)
)ENGINE=InnoDB;

CREATE TABLE zonaBa(
ZonBa_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
ZonBa_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
ZonaBa_Temp_prog	DOUBLE	NOT NULL REFERENCES temperatura(Temp_prog),
ZonBa_nom VARCHAR(3) NOT NULL,
ZonBa_facor	DOUBLE	NOT NULL,
ZonBa_inc	DOUBLE	NOT NULL,
ZonBa_grad	 DOUBLE	NOT NULL,

PRIMARY KEY(ZonBa_Cert_num,ZonBa_Cert_let,ZonaBa_Temp_prog,ZonBa_nom)
)ENGINE=InnoDB;

CREATE TABLE bloque
(
Bloq_Tem_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Bloq_Tem_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
Bloq_Temp_prog	DOUBLE	NOT NULL REFERENCES temperatura(Temp_prog),
Bloq_uniax	DOUBLE	NOT NULL,
Bloq_unirad	DOUBLE	NOT NULL,
Bloq_est	DOUBLE	NOT NULL,
PRIMARY KEY (Bloq_Tem_Cert_num,Bloq_Tem_Cert_let,Bloq_Temp_prog)
) ENGINE=InnoDB;

CREATE TABLE vidrio
(
Tvid_Tem_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Tvid_Tem_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
Tvid_Temp_prog	DOUBLE	NOT NULL REFERENCES temperatura(Temp_prog),
Tvid_Tem_estp1	VARCHAR(7)	NOT NULL,
Tvid_Tem_estp2	VARCHAR(7)	NOT NULL,
Tvid_Tem__unifex	VARCHAR(7)	NOT NULL,
PRIMARY KEY (Tvid_Tem_Cert_num,Tvid_Tem_Cert_let,Tvid_Temp_prog)
) ENGINE=InnoDB;

CREATE TABLE analogo
(
Tana_Tem_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Tana_Tem_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
Tana_Temp_prog	DOUBLE	NOT NULL REFERENCES temperatura(Temp_prog),
Tana_Tem_estp1	VARCHAR(7)	NOT NULL,
Tana_Tem_unifex	VARCHAR(7)	NOT NULL,
PRIMARY KEY(Tana_Tem_Cert_num,Tana_Tem_Cert_let,Tana_Temp_prog)
)ENGINE=InnoDB;

CREATE TABLE digital
(
Td_Tem_Cert_num INT NOT NULL REFERENCES certificado(Cert_num),
Td_Tem_Cert_let VARCHAR(5) NOT NULL REFERENCES certificado(Cert_let),
Td_Temp_prog	DOUBLE	NOT NULL REFERENCES temperatura(Temp_prog),
Td_estp1	VARCHAR(7)	NOT NULL,
Td_estp2	VARCHAR(7)	NOT NULL,
Td_unifex	VARCHAR(7)	NOT NULL,
PRIMARY KEY(Td_Tem_Cert_num,Td_Tem_Cert_let,Td_Temp_prog)
)ENGINE=InnoDB;

-- INSERTAR DATOS 

INSERT INTO item VALUES('1D1310572', 'BAnnO TERMOSTATICO', 'POLYSCIENCE', '9502A11C','-30 °C < T < 200 °C', 'TEMPERATURA', '200 °C','-30 °C','0.1');
INSERT INTO item VALUES('104-IR', 	'TERMOMETRO DIGITAL-IR', 	'TESTO',	'104-IR',	'-50 °C < T < 250 °C', 	'TEMPERATURA', '250 °C','-50 °C',	'0.1');
INSERT INTO item VALUES('2519', 	'TERMOMETRO DE VIDRIO', 	'PG ERTCB', 	'ASTM 8F',	'30 °F < T < 760 °F', 	'TEMPERATURA', '760 °F','30 °F',	'2');
INSERT INTO item VALUES('VC230A','TERMOHIGRÓMETRO DIGITAL','VICTOR','VC230A','30%HR A 90%HR','HUMEDAD','90%HR','30%HR','0.1');
INSERT INTO item VALUES ('A28194','BLOQUE SECO', 'HART SCIENTIFIC', '9140','35 °C < T < 350 °C', 'TEMPERATURA', '350°C','35°C','0.2');
INSERT INTO item VALUES('TBM30040C3','TERMÓMETRO ANALOGO','WINTERS','TBM30040C3','0 °C < T < 250 °C','TEMPERATURA','250 ','0 ','2');
INSERT INTO item VALUES ('260188','TERMÓMETRO ANÁLOGO', 'FISHER/BRAND', '15076B',' 0°C < T < 180°C', 'TEMPERATURA', '180°C','0°C','0.2');
INSERT INTO item VALUES ('910-9','TERMÓMETRO DIGITAL', 'LABSCIENT', 'PARA NEVERA',' -50°C < T < 70°C', 'TEMPERATURA', '70°C','-50°C','0.1');
INSERT INTO item VALUES ('BOE311','TERMÓMETRO DIGITAL', 'ACCURATE', 'BOE311',' -50°C < T < 300°C', 'TEMPERATURA', '300°C','-50°C','0.1');


INSERT INTO item_cliente VALUES('Ref-1D1310572','0101','1D1310572','Calibrar','-30 °C < T < 200 °C');
INSERT INTO item_cliente VALUES('EMC-000317',	'800194600-3',	'104-IR',	'Calibrar',	'-50 °C < T < 250 °C');
INSERT INTO item_cliente VALUES('0006756','800.194.600-3','VC230A','Equipo laboratorio','30%HR A 90%HR');
INSERT INTO item_cliente VALUES ('9140-BS','900073613-2','A28194','Equipo de laboratorio','35°C < T < 350°C');
INSERT INTO item_cliente VALUES('TDA-1','0101','TBM30040C3','Equipo de laboratorio','0 °C < T < 250 °C');
INSERT INTO item_cliente VALUES ('7-3-80021','1030586792','260188','Medir temperatura de las comidas','0°C < T < 180°C');
INSERT INTO item_cliente VALUES ('TS-1','1030586792','910-9','Medir temperatura de la nevera','-50°C < T < 70°C');
INSERT INTO item_cliente VALUES ('BOE311-TD','1030586792','BOE311','Tratamiento de alimentos','-50°C < T < 300°C');

INSERT INTO orden_compra VALUES (default,'9140-BS','50°C, 75°C, 100°C, 150°C, 200°C', 'Caracterización','5', '725000','2019-06-18', 'ninguna', 'EURAMENT-13');
INSERT INTO orden_compra VALUES(default,'Ref-1D1310572','90 °C, 150 °C, 200 °C', 'Calibración','1', '300000','2019-09-11', 'ninguna', 'Guía Técnica de Trazabilidad Metrológica e Incertidumbre de Medida en Caracterización Termica de Bannos y Hornos de Temperatura Controlada');
INSERT INTO orden_compra VALUES(default,'EMC-000317','2 °C,20°C, 40°C, 60°C, 70°C, 100°C,  150 °C,-20°C, -10 °C', 'Calibración','1', '400000','2019-08-22', 'ninguna', 'Procedimiento para la calibración de Termómetros digitales  CEM-Edición digital');
INSERT INTO orden_compra VALUES(default,'2519_TV','90°C,   150 °C,200 °C', 'Calibración','1', '350000','2019-08-22', 'ninguna', 'TH-004');
INSERT INTO orden_compra VALUES(default,'0006756','38%HR, 65%HR, 90%HR','Calibración','2','350000','2019-08-13','Ninguna','"Procedimiento para la calibración de medidores de conciones ambientales de Temperatura y Humedad en aire"');
INSERT INTO orden_compra VALUES(default,'TDA-1','90 °C, 150 °C, 180 °C', 'Calibración','1','400000','2019-09-11','Ninguna','NTVVS 103');
INSERT INTO orden_compra VALUES (default,'7-3-80021','0°C, 5°C, 10°C, 20°C, 50°C, 70°C', 'Calibración','6', '1060000','2019-07-02', '', 'NT VVS 103');
INSERT INTO orden_compra VALUES (default,'TS-1','-10°C, 5°C, 10°C', 'Calibración','3', '420000','2019-07-02', '', 'TH 001');
INSERT INTO orden_compra VALUES (default,'BOE311-TD','-30°C, -20°C, -10°C', 'Calibración','3', '420000','2019-07-02', '', 'TH 001');


INSERT INTO asesor VALUES('111','Alejandra Lozano');

INSERT INTO orden_compra_asesor VALUES (default,'Ref-1D1310572','111');
INSERT INTO orden_compra_asesor VALUES (default,'EMC-000317','111');
INSERT INTO orden_compra_asesor VALUES (default,'2519_TV','111');
INSERT INTO orden_compra_asesor VALUES (default,'9140-BS','111');
INSERT INTO orden_compra_asesor VALUES (4,'TDA-1','111');
INSERT INTO orden_compra_asesor VALUES (default,'7-3-80021','111');
INSERT INTO orden_compra_asesor VALUES (default,'TS-1','111');
INSERT INTO orden_compra_asesor VALUES (default,'BOE311-TD','111');

INSERT INTO laboratorista VALUES ('242','Jhon Fredy Montoya');
INSERT INTO laboratorista VALUES ('233','Claudia Montoya');


INSERT INTO emitir VALUES('242','027','CMI');
INSERT INTO emitir VALUES('233','0271','CMI');
INSERT INTO emitir VALUES('233','027','CTD');
INSERT INTO emitir VALUES('242','006','CTV');
INSERT INTO emitir VALUES('242','010','CH');
INSERT INTO emitir VALUES('242','001','CMI');
INSERT INTO emitir VALUES('242','005','CMI');
INSERT INTO emitir VALUES('242','001','CTA');
INSERT INTO emitir VALUES('242','007','CTD');
INSERT INTO emitir VALUES('242','005','CTD');


INSERT INTO orden_compra_espec VALUES (default,'CRS',1,'Ref-1D1310572','027','CMI','242','90','150000','90 °C < T < 200 °C');
INSERT INTO orden_compra_espec VALUES (default,'CRS',1,'Ref-1D1310572','0271','CMI','233',150,'150000','90 °C < T < 200 °C');
INSERT INTO orden_compra_espec VALUES ('69','CRS',4, 'TBM30040C3','005','CMI','242',90,'180000','0 °C < T < 250 °C');
INSERT INTO orden_compra_espec VALUES ('70','CRS',4, 'TBM30040C3','005','CMI','242',150,'180000','0 °C < T < 250 °C');
INSERT INTO orden_compra_espec VALUES ('71','CRS',4, 'TBM30040C3','005','CMI','242',180,'180000','0 °C < T < 250 °C');
INSERT INTO orden_compra_espec VALUES (default,'AGR',2,'0006756','010','CH','242',38,'180000','30%HR A 90%HR');
INSERT INTO orden_compra_espec VALUES (default,'AGR',2,'0006756','010','CH','242',65,'180000','30%HR A 90%HR');
INSERT INTO orden_compra_espec VALUES (default,'AGR',2,'0006756','010','CH','242',90,'180000','30%HR A 90%HR');
INSERT INTO orden_compra_espec VALUES (default,'CALS', 3,'9140-BS','001','CMI','242','50°C','100000','35°C < T < 350°C');
INSERT INTO orden_compra_espec VALUES (default,'CALS', 3,'9140-BS','001','CMI','242','75°C','100000','35°C < T < 350°C');
INSERT INTO orden_compra_espec VALUES (default,'CALS', 3,'9140-BS','001','CMI','242','100°C','150000','35°C < T < 350°C');
INSERT INTO orden_compra_espec VALUES (default,'CALS', 3,'9140-BS','001','CMI','242','150°C','175000','35°C < T < 350°C');
INSERT INTO orden_compra_espec VALUES (default,'CALS', 3,'9140-BS','001','CMI','242','200°C','200000','35°C < T < 350°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '5','7-3-80021','001','CTA','242','0°C','100000',' 0°C < T <  180°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '5','7-3-80021','001','CTA','242','5°C','150000',' 0°C < T <  180°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '5','7-3-80021','001','CTA','242','10°C','160000',' 0°C < T <  180°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '5','7-3-80021','001','CTA','242','20°C','200000',' 0°C < T <  180°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '5','7-3-80021','001','CTA','242','50°C','200000',' 0°C < T <  180°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '5','7-3-80021','001','CTA','242','70°C','250000',' 0°C < T <  180°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '6','TS-1','007','CTD','242','-10°C','100000',' -50°C < T < 70°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '6','TS-1','007','CTD','242','5°C','150000',' -50°C < T < 70°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '6','TS-1','007','CTD','242','10°C','170000',' -50°C < T < 70°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '7','BOE311-TD','005','CTD','242','-30°C','100000',' -50°C < T < 300°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '7','BOE311-TD','005','CTD','242','-205°C','150000',' -50°C < T < 300°C');
INSERT INTO orden_compra_espec VALUES (default,'KAR', '7','BOE311-TD','005','CTD','242','-10°C','170000','-50°C < T < 300°C');


INSERT INTO trazabilidad VALUES ('0271','CMI','34316-5+1498J-19','935-14-116','','','','','','','','','');
INSERT INTO trazabilidad VALUES ('027','CMI','34316-5+1498J-19','935-14-116','','','','','','','','','');
INSERT INTO trazabilidad VALUES ('027','CTD',	'T-027',		'T-028',	'1D1310572',	'','','','','','','','');
INSERT INTO trazabilidad VALUES ('006','CTV',	'34316-5+1498J-19',	'935-14-116',	'1D1310572',	'','','','','','','','');
INSERT INTO trazabilidad VALUES ('010','CH','TH-102097275','TH-102097277','HCP108','','','','','','','','');
INSERT INTO trazabilidad VALUES (001,'CMI','TERMOMETRO DIGITAL CON SONDA Pt-100','TERMOMETRO DIGITAL CON SONDA Pt-100','','','','','','','','','');
INSERT INTO trazabilidad VALUES ('005','CMI','34316-5+1498J-19','1D1310572','','','','','','','','','');
INSERT INTO trazabilidad VALUES ('001','CTA','UBS-Pt-100',null,null,null,null,null,null,null,null,null,null);
INSERT INTO trazabilidad VALUES ('007','CTD','UBS-Pt-100','UBS-Pt-100','BAÑO TEMPERATURA CONTROLADA',null,null,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO trazabilidad VALUES ('005','CTD','UBS-Pt-100','UBS-Pt-100','BAÑO TEMPERATURA CONTROLADA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);


INSERT INTO certificado VALUES ('0101','CH','21','20.5','85.3','47.4');
INSERT INTO certificado VALUES ('0271','CMI','24.2','20.8','67.6','45.5');
INSERT INTO certificado VALUES ('027','CMI','24.2','20.8','67.6','46.5');
INSERT INTO certificado VALUES ('001','CMI','23.6','22.0','74.0','55.0');
INSERT INTO certificado VALUES ('005','CMI','22.3','21.1','48.2','46.5');
INSERT INTO certificado VALUES ('001','CTA','24.6','20.3','61.3','48.4');
INSERT INTO certificado VALUES ('007','CTD','24.3','23.4','67.3','54.8');
INSERT INTO certificado VALUES ('005','CTD','22.8','21.6','56.8','48.5');


INSERT INTO temperatura VALUES('0271','CMI','90','90','90','90','0','1.65','0.24' );
INSERT INTO temperatura VALUES('0271','CMI','150','150','150','150','0','0.79','0.53');
INSERT INTO temperatura VALUES('0271','CMI','200','200','200','200','0','1.15','0.51');
INSERT INTO temperatura VALUES('027','CMI','90','90','90','90','0','1.65','0.24' );
INSERT INTO temperatura VALUES('027','CMI','150','150','150','150','0','0.79','0.53');
INSERT INTO temperatura VALUES('027','CMI','200','200','200','200','0','1.15','0.51');
INSERT INTO temperatura VALUES ('029','CMI','50','50','50','50','0.00','0.13','-0.26' );
INSERT INTO temperatura VALUES ('029','CMI','75','75','75','75','0.00','0.13','-0.36' );
INSERT INTO temperatura VALUES ('029','CMI','100','100','100','100','0.00','0.21','-0.46' );
INSERT INTO temperatura VALUES ('029','CMI','150','150','150','150','0.00','0.19','-0.55' );
INSERT INTO temperatura VALUES ('029','CMI','200','200','200','200','0.00','0.19','-0.84' );
INSERT INTO temperatura VALUES('001','CTA','0','-0.20','0.00','-0.55','0.27','0.24','0.17');
INSERT INTO temperatura VALUES('001','CTA','5','4.40','4.40','4.40','0.00','0.26','0.69');
INSERT INTO temperatura VALUES('001','CTA','10','10.00','10.00','10.00','0.00','0.25','0.06');
INSERT INTO temperatura VALUES('001','CTA','20','20.00','20.00','20.00','0.00','0.28','0.10');
INSERT INTO temperatura VALUES('001','CTA','50','49.40','49.40','49.40','0.00','0.28','0.56');
INSERT INTO temperatura VALUES('001','CTA','70','70.00','70.00','70.00','0.00','0.27','0.00');
INSERT INTO temperatura VALUES('007','CTD','-10','-10.62','-10.60','-10.70','-10.62','0.47','0.56');
INSERT INTO temperatura VALUES('007','CTD','5','4.50','4.50','4.50','4.50','0.12','0.53');
INSERT INTO temperatura VALUES('007','CTD','10','9.60','9.60','9.60','9.60','0.12','0.41');
INSERT INTO temperatura VALUES('005','CTD','-30','-29.00','-29.00','-29.00','0.00','0.23','-0.81');
INSERT INTO temperatura VALUES('005','CTD','-20','-19.70','-19.7','-19.70','0.00',0.29,-0.35);
INSERT INTO temperatura VALUES('005','CTD','-10','-9.16','-9.10','-9.20','0.05','0.47','-0.81');


INSERT INTO estBa VALUES('0271','CMI','90','0.08','0.17',2);
INSERT INTO estBa VALUES('0271','CMI','150','0.03','0.06',2);
INSERT INTO estBa VALUES('0271','CMI','200','0.02','0.05',2);
INSERT INTO estBa VALUES('027','CMI','90','0.08','0.17',2);
INSERT INTO estBa VALUES('027','CMI','150','0.03','0.06',2);


INSERT INTO zonaBa VALUES ('0271','CMI','90','P1',2,0.10, 0.11);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P2',2,0.19,0.21);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P3','2',0.20,0.23);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P4','2',0.04,0.04);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P5','2',0.021,0.24);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P6','2',0.09,0.10);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P7','2',0.03,0.03);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P8','2',0.26,0.30);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P9','2',2.28,2.63);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P10','2',0.49,0.57);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P11','2',0.91,1.05);
INSERT INTO zonaBa VALUES ('0271','CMI','90','P12','2',1.31,1.51);

INSERT INTO zonaBa VALUES ('0271','CMI','150','P1',2,0.03, 0.04);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P2',2,0.08,0.09);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P3',2,0.11,0.13);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P4',2,0.12,0.14);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P5',2,-0.06,0.07);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P6',2,-0.13,0.14);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P7',2,0.02,0.03);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P8',2,0.00,0.00);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P9',2,-0.85,0.99);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P10',2,-0.72,0.83);
INSERT INTO zonaBa VALUES ('0271','CRS','150','P11',2,-0.60,0.69);
INSERT INTO zonaBa VALUES ('0271','CMI','150','P12',2,-0.43,0.50);

INSERT INTO zonaBa VALUES ('0271','CMI','200','P1','2',-0.01, 0.01);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P2','2',0.05,0.06);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P3','2',0.11,0.12);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P4','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P5','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P6','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P7','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P8','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P9','2',-1.12,1.30);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P10','2',-0.80,0.93);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P11','2',-1.03,1.19);
INSERT INTO zonaBa VALUES ('0271','CMI','200','P12','2',-0.96,1.11);

INSERT INTO zonaBa VALUES ('027','CMI','90','P1','2',0.10, 0.11);
INSERT INTO zonaBa VALUES ('027','CMI','90','P2','2',0.19,0.21);
INSERT INTO zonaBa VALUES ('027','CMI','90','P3','2',0.20,0.23);
INSERT INTO zonaBa VALUES ('027','CMI','90','P4','2',0.04,0.04);
INSERT INTO zonaBa VALUES ('027','CMI','90','P5','2',0.021,0.24);
INSERT INTO zonaBa VALUES ('027','CMI','90','P6','2',0.09,0.10);
INSERT INTO zonaBa VALUES ('027','CMI','90','P7',2,0.03,0.03);
INSERT INTO zonaBa VALUES ('027','CMI','90','P8','2',0.26,0.30);
INSERT INTO zonaBa VALUES ('027','CMI','90','P9','2',2.28,2.63);
INSERT INTO zonaBa VALUES ('027','CMI','90','P10','2',0.49,0.57);
INSERT INTO zonaBa VALUES ('027','CMI','90','P11','2',0.91,1.05);
INSERT INTO zonaBa VALUES ('027','CMI','90','P12','2',1.31,1.51);

INSERT INTO zonaBa VALUES ('027','CMI','150','P1','2',0.03, 0.04);
INSERT INTO zonaBa VALUES ('027','CMI','150','P2','2',0.08,0.09);
INSERT INTO zonaBa VALUES ('027','CMI','150','P3','2',0.11,0.13);
INSERT INTO zonaBa VALUES ('027','CMI','150','P4','2',0.12,0.14);
INSERT INTO zonaBa VALUES ('027','CMI','150','P5','2',-0.06,0.07);
INSERT INTO zonaBa VALUES ('027','CMI','150','P6',2,-0.13,0.14);
INSERT INTO zonaBa VALUES ('027','CMI','150','P7','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('027','CMI','150','P8','2',0.00,0.00);
INSERT INTO zonaBa VALUES ('027','CMI','150','P9','2',-0.85,0.99);
INSERT INTO zonaBa VALUES ('027','CMI','150','P10','2',-0.72,0.83);
INSERT INTO zonaBa VALUES ('027','CMI','150','P11','2',-0.60,0.69);
INSERT INTO zonaBa VALUES ('027','CMI','150','P12','2',-0.43,0.50);

INSERT INTO zonaBa VALUES ('027','CMI','200','P1','2',-0.01, 0.01);
INSERT INTO zonaBa VALUES ('027','CMI','200','P2','2',0.05,0.06);
INSERT INTO zonaBa VALUES ('027','CMI','200','P3','2',0.11,0.12);
INSERT INTO zonaBa VALUES ('027','CMI','200','P4','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('027','CMI','200','P5','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('027','CMI','200','P6','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('027','CMI','200','P7','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('027','CMI','200','P8','2',0.02,0.03);
INSERT INTO zonaBa VALUES ('027','CMI','200','P9','2',-1.12,1.30);
INSERT INTO zonaBa VALUES ('027','CMI','200','P10','2',-0.80,0.93);
INSERT INTO zonaBa VALUES ('027','CMI','200','P11','2',-1.03,1.19);
INSERT INTO zonaBa VALUES ('027','CMI','200','P12','2',-0.96,1.11);


INSERT INTO bloque VALUES ('001','CMI','50','0.01','0.07','0.07');
INSERT INTO bloque VALUES ('001','CMI','75','0.02','0.04','0.06');
INSERT INTO bloque VALUES ('001','CMI','100','0.02','0.22','0.08');
INSERT INTO bloque VALUES ('001','CMI','150','0.02','0.18','0.09');
INSERT INTO bloque VALUES ('001','CMI','200','0.03','0.32','0.10');

INSERT INTO analogo VALUES ('001','CTA','0','0.01','0.00');
INSERT INTO analogo VALUES ('001','CTA','5','0.04','0.01');
INSERT INTO analogo VALUES ('001','CTA','10','0.02','0.01');
INSERT INTO analogo VALUES ('001','CTA','20','0.02','0.00');
INSERT INTO analogo VALUES ('001','CTA','50','0.01','0.00');
INSERT INTO analogo VALUES ('001','CTA','70','0.02','0.01');

INSERT INTO digital VALUES ('007','CTD','-10','0.12','0.14','0.01');
INSERT INTO digital VALUES ('007','CTD','5','0.03','0.02','-0.02');
INSERT INTO digital VALUES ('007','CTD','10','0.02','0.04','0.00');

INSERT INTO digital VALUES ('005','CTD','-30','0.03','0.06','-0.28');
INSERT INTO digital VALUES ('005','CTD','-20','0.06','0.08','-0.41');
INSERT INTO digital VALUES ('005','CTD','-10','0.02','0.05','-0.10');
--


INSERT INTO humedad VALUES('010','CH','38','36.74','','','','1.52','3');
INSERT INTO humedad VALUES('010','CH','65','64','','','','1.60','0.70');
INSERT INTO humedad VALUES('010','CH','90','87.06','','','','1.73','-1.96');
INSERT INTO humedad VALUES('005','CMI','90','90','90','90','0','0.61','0.21');
INSERT INTO humedad VALUES('005','CMI',150,'150','150','150','0','0.60','0.53');
INSERT INTO humedad VALUES('005','CMI','180','180','180','180','0','0.61','0.60');

INSERT INTO termhighum VALUES('005','CMI',90,0,0,0);
INSERT INTO termhighum VALUES('005','CMI',150,0,0,0);
INSERT INTO termhighum VALUES('005','CMI',180,0,0,0);
INSERT INTO termhighum VALUES('010','CH','38','1','1.3','0.7');
INSERT INTO termhighum VALUES('010','CH','65','1','1.3','0.7');
INSERT INTO termhighum VALUES('010','CH','90','1','1.3','0.7');


INSERT INTO resumen_estadistico VALUES ('001','CMI','50',null,null,null,null,null,null,null,null,'49.91','49.67','49.58','49.41','49.81','49.52','0.10','0.07');
INSERT INTO resumen_estadistico VALUES ('001','CMI','75',null,null,null,null,null,null,null,null,'74.83','74.40','74.62','74.42','74.67','74.51','0.10','0.07');
INSERT INTO resumen_estadistico VALUES ('001','CMI','100',null,null,null,null,null,null,null,null,'99.64','99.21','99.96','99.73','99.48','99.86','0.10','0.07');
INSERT INTO resumen_estadistico VALUES ('001','CMI','150',null,null,null,null,null,null,null,null,'149.60','149.02','149.91','149.67','149.35','149.77','0.10','0.07');
INSERT INTO resumen_estadistico VALUES ('001','CMI','200',null,null,null,null,null,null,null,null,'199.07','198.42','199.81','199.54','198.81','199.66','0.10','0.07');

INSERT INTO resumen_estadistico VALUES ('001','CTA','0',null,null,null,null,null,null,null,null,'-0.03','-0.4',null,null,'-0.03',null,'0.00',null);
INSERT INTO resumen_estadistico VALUES ('001','CTA','5',null,null,null,null,null,null,null,null,'5.11','5.07',null,null,'5.09',null,'0.01',null);
INSERT INTO resumen_estadistico VALUES ('001','CTA','10',null,null,null,null,null,null,null,null,'10.07','10.05',null,null,'10.06',null,'0.01',null);
INSERT INTO resumen_estadistico VALUES ('001','CTA','20',null,null,null,null,null,null,null,null,'20.11','20.09',null,null,'20.09',null,'0.00',null);
INSERT INTO resumen_estadistico VALUES ('001','CTA','50',null,null,null,null,null,null,null,null,'49.97','49.96',null,null,'49.96',null,'0.00',null);
INSERT INTO resumen_estadistico VALUES ('001','CTA','70',null,null,null,null,null,null,null,null,'70.01','69.99',null,null,'70.00',null,'0.01',null);

INSERT INTO resumen_estadistico VALUES ('007','CTD','-10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-10.00','-10.12','-9.98','-10.12','-10.05','-10.6','0.03','0.03');
INSERT INTO resumen_estadistico VALUES ('007','CTD','5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'5.04','5.01','5.04','5.02','5.02','5.03','0.01','0.01');
INSERT INTO resumen_estadistico VALUES ('007','CTD','10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10.02','10.00','10.03','9.99','10.01','10.01','0.01','0.01');

INSERT INTO resumen_estadistico VALUES ('005','CTD','-30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-29.94','-29.97','-29.64','-29.70','-29.95','-29.67','0.01','0.02');
INSERT INTO resumen_estadistico VALUES ('005','CTD','-20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-20.23','-20.29','-19.81','-19.89','-20.25','-19.84','0.01','0.02');
INSERT INTO resumen_estadistico VALUES ('005','CTD','-10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-10.00','-10.02','-9.89','-9.94','-10.01','-9.92','0.01','0.01');


## CS-RTL-FT-021-KAR-008-BOE311-TD-ETANOL-CTD -005
















-- CREACIÓN USUARIOS
-- Creación de usuarios 

DROP USER if exists 'app'@'localhost';
CREATE USER 'app'@'localhost' IDENTIFIED BY 'appPassword';
GRANT ALL PRIVILEGES ON proyectocs.* TO 'app'@'localhost';

INSERT INTO cliente VALUES
('800.194.600-3','AGROSAVIA','Luisa Gómez','Auxiliar de venta',2462544,2462544,'AGROSAVIA@gmail.com','Bogotá','Km 14 vía Mosquera - Bogotá', 'cli211'),  
('0101','Creaciones y suministros','Alejandra Lozano', 'Directora comercial',9017160,9017160,'creacionesysuministrossas@gmail.com','Bogotá','Carrera 67 No. 10-10', 'cli212'),
('900073613-2','CALIBRATION SERVICE SAS','','',2047699,2047699,'calibrationservice@gmail.co', 'Bogotá','CARRERA 69 A No. 55- 16 SUR', 'cli213'),
('1030586792','4 KARNES','Fabian Avila','',5028751,5028751,'karnes@gmail.co', 'Bogotá','Carrera 70b #3-45', 'cli214'),
-- ADMINISTRATIVOS:
('0','','AlejandraL','Asesor',0, 0,'', '','', 'dcomercial111'),
('0','','ClaudiaM','Laboratorista',0, 0,'', '','', 'lab112'),
('0','','JhonFredyM','Laboratorista',0, 0,'', '','', 'lab113'),
('0','','gerente','Gerente',0, 0,'','','', 'gerent114');

/*PROCEDIMIENTOS*/ 
DROP VIEW IF EXISTS vt2;
DROP VIEW IF EXISTS vt3;
DROP VIEW IF EXISTS vt4;
DROP VIEW IF EXISTS vt5;
/* Vistas: vt2 similar a una factura resumen del cliente 
 vt3 promedio de dinero pagado,número de servicios realizados, cliente, teléfono */

CREATE VIEW vt2 AS SELECT Cli_emp,Cli_mail,Cli_tel,Ordc_preciotol,Ordc_fec FROM cliente JOIN item_cliente ON ItmC_Cli_nit=Cli_nit
JOIN orden_compra ON ItmC_id=Ordc_ItmC_id;

CREATE VIEW vt3 AS SELECT Cli_emp,Cli_mail,Cli_tel,AVG(Ordc_preciotol) AS prom,SUM(Ordc_preciotol) AS total, COUNT(Cli_emp) AS serv FROM vt2 GROUP BY Cli_emp,Cli_mail,Cli_tel;

/* Procedimiento de descuentos: Otorga un bono de descuento por cierto valor pagado en total de servicios */

DROP TABLE IF EXISTS bono;
CREATE TABLE bono
(
bon_Cli_emp VARCHAR(40) NOT NULL,
bon_desc INT NOT NULL,
PRIMARY KEY(bon_Cli_emp)
) ENGINE=InnoDB;

DROP PROCEDURE IF EXISTS dest;
DELIMITER $$
CREATE PROCEDURE dest(empresa VARCHAR(50))
BEGIN
DECLARE des DOUBLE DEFAULT 0;

IF empresa='AGROSAVIA' OR empresa='Creaciones y suministros' THEN 

SET @val =(SELECT total FROM vt3 WHERE Cli_emp=empresa);
IF @val <= 1000 THEN
SET des=0.10;
INSERT INTO bono VALUES(empresa,des*@val); 
SELECT 'Se otorga un descuento por'; 
SELECT bon_desc FROM bono WHERE bon_Cli_emp=empresa;

ELSEIF @val > 1000 THEN
SET des=0.20;
INSERT INTO bono VALUES(empresa,des*@val); 
SELECT 'Se otorga un descuento por'; 
SELECT bon_desc FROM bono WHERE bon_Cli_emp=empresa;

END IF;

ELSEIF empresa <> 'AGROSAVIA' OR empresa<>'Creaciones y suministros' THEN
SELECT 'Empresa no existe';

END IF;
END $$
DELIMITER ; 

/* CALL dest('Creaciones y suministros'); 
CALL dest('AGROSAVIA');
CALL dest('Otra'); */


/* Procedimiento de actualización datos de CONTACTO*/ 
DROP PROCEDURE IF EXISTS act;
DELIMITER $$
CREATE PROCEDURE act(empresa VARCHAR(50),contacto VARCHAR(50),carg VARCHAR(50),tel INT, fax INT)
BEGIN

IF empresa='AGROSAVIA' OR empresa='Creaciones y suministros' THEN 

IF empresa='AGROSAVIA' THEN
UPDATE cliente
SET Cli_cont=contacto WHERE Cli_emp=empresa;
UPDATE cliente
SET Cli_cont_carg=carg WHERE Cli_emp=empresa; 
UPDATE cliente
SET Cli_tel=tel WHERE Cli_emp=empresa;
UPDATE cliente
SET Cli_fax=fax WHERE Cli_emp=empresa;
SELECT * FROM cliente;
ELSEIF empresa='Creaciones y suministros' THEN
UPDATE cliente
SET Cli_cont=contacto WHERE Cli_emp=empresa; 
UPDATE cliente
SET Cli_cont_carg=carg WHERE Cli_emp=empresa;
UPDATE cliente
SET Cli_tel=tel WHERE Cli_emp=empresa;
UPDATE cliente
SET Cli_fax=fax WHERE Cli_emp=empresa;
SELECT * FROM cliente;
END IF;

ELSEIF empresa<>'AGROSAVIA' OR empresa<>'Creaciones y suministros' THEN
SELECT 'Empresa no existe, actualización no permitida';

END IF;
END $$
DELIMITER ; 

/* CALL act('Creaciones y suministros','Marcela Hernandez','Subgerencia de mercadeo',2854001,2854001);
CALL act('AGROSAVIA','Luisa Andrade','Marketing',8950012,8950012);
CALL act('Creaciones y suministr','Marcela Hernandez','Subgerencia de mercadeo',2854001,2854001);
*/

/* Vistas 
ASESOR vt4 información del cliente ítem y valor pagado
LABORATORISTA vt5 características del ítem, valor a pagar, uso de ítem, rango, puntos a calibrar
*/
DROP VIEW IF EXISTS vt4;
DROP VIEW IF EXISTS vt5;

CREATE VIEW vt4 AS SELECT DISTINCT Cli_nit, OrdcEs_OrdC_ItemC_id AS idi, OrdcEs_Ordc_id AS idc, OrdcEs_preciopun AS valor, OrdcEs_ranc AS ran, OrdcEs_calp AS punt 
FROM cliente JOIN item_cliente ON Cli_nit=ItmC_Cli_nit RIGHT JOIN orden_compra_espec ON ItmC_id=OrdcEs_OrdC_ItemC_id;

CREATE VIEW vt5 AS SELECT DISTINCT OrdcEs_OrdC_ItemC_id AS idi, OrdcEs_Ordc_id AS idc,ItmC_uso, OrdcEs_preciopun AS valor, OrdcEs_ranc AS ran, OrdcEs_calp AS punt 
FROM item_cliente JOIN orden_compra_espec ON ItmC_id=OrdcEs_OrdC_ItemC_id;

/* 
SELECT * FROM vt4;
SELECT * FROM vt5; */ 

/* Procedimiento de actualización datos orden de compra específica */ 
/* Se emplea si se quieren cambiar los atributos del laboratorista, valor del punto a calibrar y punto a calibrar*/
DROP PROCEDURE IF EXISTS act2;
DELIMITER $$
CREATE PROCEDURE act2(idmov INT,lab INT,valp INT, calp INT)
BEGIN

UPDATE orden_compra_espec
SET OrdcEs_Lab_id=lab WHERE OrdcEs_idmov=idmov;
UPDATE orden_compra_espec
SET OrdcEs_valpun1=valp WHERE OrdcEs_idmov=idmov;
UPDATE orden_compra_espec
SET OrdcEs_calp1=calp WHERE OrdcEs_idmov=idmov;

END $$
DELIMITER ; 

/*
CALL act2(1,458,387000,75);
CALL act2(5,735,695000,125);
SELECT * FROM orden_compra_espec;
*/

/* TRIGGER1 */ 
DROP TABLE IF EXISTS aux;
CREATE TABLE aux
(
Cli_emp VARCHAR(100) NOT NULL,
Cli_tel INT NOT NULL
) ENGINE=InnoDB;

 /* Trigger que conserva información de clientes eliminados de la tabla */
 /* Puede ser asignado por gerencia o por quien pueda eliminar registros de cliente */ 
DROP TRIGGER IF EXISTS TRABC1;
DELIMITER ||
CREATE TRIGGER TRABC1 BEFORE DELETE ON cliente
FOR EACH ROW BEGIN
INSERT INTO aux (Cli_emp, Cli_tel)
values ( OLD.Cli_emp, OLD.Cli_tel );

END ||
DELIMITER ;

/*TRIGGER2*/
DROP TABLES IF EXISTS ValMax;
CREATE TABLE ValMax(
fecha DATE,
Cert_num	INT	AUTO_INCREMENT NOT NULL,
Cert_let	VARCHAR(5)	NOT NULL,
Cert_temax	DOUBLE	NOT NULL, 
Cert_humax	DOUBLE	NOT NULL,
PRIMARY KEY (Cert_num)
) ENGINE=InnoDB;
DROP TRIGGER IF EXISTS maxv;
DELIMITER ||
CREATE TRIGGER maxv BEFORE INSERT on certificado
FOR EACH ROW BEGIN
SET @aa = NEW.Cert_num;
SET @ab = NEW.Cert_let;
SET @ac = NEW.Cert_temax;
SET @ad = NEW.Cert_humax;

INSERT INTO ValMax(fecha,Cert_num, Cert_let, Cert_temax,Cert_humax)
values ( CURDATE(), NEW.Cert_num,NEW.Cert_let,NEW.Cert_temax, NEW.Cert_humax);
END ||
DELIMITER ;

INSERT INTO certificado VALUES ('0115','CU','29','38.5','92.3','45.4');
INSERT INTO certificado VALUES ('0188','CRY','69','24.5','85.3','67.4');
INSERT INTO certificado VALUES ('0198','CPO','54','66.5','54.3','47.4');


SELECT * FROM digital;
SELECT * FROM temperatura;
SELECT * FROM cliente;

