-- -----------------------------------------------------
-- Table `sysfrye_conta`.`con_centros_costos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sysfrye_conta`.`con_centros_costos` (
  `PF_EMP_CEN_EMPRESA` INT(11) NOT NULL,
  `PK_CEN_CENTRO_COSTO` VARCHAR(10) NOT NULL,
  `PK_CEN_SUB_CENTRO_COSTO` VARCHAR(10) NOT NULL COMMENT 'LOS VALORES 0 SON LA DESCRIPCION DEL CC. ',
  `DESCRIPCION` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`PF_EMP_CEN_EMPRESA`, `PK_CEN_CENTRO_COSTO`, `PK_CEN_SUB_CENTRO_COSTO`),
  CONSTRAINT `FK_EMPRESA_CC`
    FOREIGN KEY (`PF_EMP_CEN_EMPRESA`)
    REFERENCES `sysfrye_global`.`glb_empresas` (`PK_EMP_CODEMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sysfrye_conta`.`con_conceptos_adicionales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sysfrye_conta`.`con_conceptos_adicionales` (
  `PF_EMP_COA_EMPRESA` INT(11) NOT NULL,
  `PK_COA_TIPO_DCTO` VARCHAR(3) NOT NULL,
  `PK_COA_NUMERO_DCTO` INT(11) NOT NULL,
  `COA_DESCRIPCION` VARCHAR(1000) NULL DEFAULT NULL,
  `COA_URL` VARCHAR(500) NULL DEFAULT NULL,
  `COA_CANTIDAD_IMPRE` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`PF_EMP_COA_EMPRESA`, `PK_COA_TIPO_DCTO`, `PK_COA_NUMERO_DCTO`),
  CONSTRAINT `FK_EMPRESA_COADICIONALES`
    FOREIGN KEY (`PF_EMP_COA_EMPRESA`)
    REFERENCES `sysfrye_global`.`glb_empresas` (`PK_EMP_CODEMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sysfrye_conta`.`con_cuentas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sysfrye_conta`.`con_cuentas` (
  `FK_CUEN_EMPRESA` INT(11) NOT NULL,
  `PK_CUEN_ANIO` VARCHAR(4) NOT NULL COMMENT 'AÑO GRAVABLE',
  `PK_CUEN_GRUPO` VARCHAR(1) NOT NULL COMMENT 'PRIMER NIVEL',
  `PK_CUEN_SUB_GRUPO` VARCHAR(1) NOT NULL COMMENT 'SEGUNDO NIVEL',
  `PK_CUEN_MAYOR` VARCHAR(2) NOT NULL COMMENT 'TERCER NIVEL',
  `PK_CUEN_SUB_MAYOR` VARCHAR(2) NOT NULL COMMENT 'CUARTO NIVEL',
  `PK_CUEN_AUXILIAR` VARCHAR(4) NOT NULL COMMENT 'QUINTO NIVEL',
  `CUEN_PK_CONCATENADA` VARCHAR(16) NULL DEFAULT NULL,
  `CUEN_NIVEL` VARCHAR(2) NULL DEFAULT NULL COMMENT '01 - NO ACEPTA MVTOS  \n10 - CEPTA MVTOS.',
  `CUEN_NOMBRE_CUENTA` VARCHAR(200) NULL DEFAULT NULL,
  `CUEN_IND_NIT` VARCHAR(1) NULL DEFAULT NULL COMMENT 'INDICA SI SE LLEVAN SALDOS POR NIT',
  `CUEN_IND_CENTRO_COSTO` VARCHAR(1) NULL DEFAULT NULL COMMENT 'INDICA SI LA CUENTA SE MANEJA POR CENTRO DE COSTO',
  `CUEN_IND_CHEQUE` VARCHAR(1) NULL DEFAULT NULL COMMENT 'INDICA SI LA CUENTA MANEJA CHEQUE',
  `CUEN_IND_BASE_RETENCION` VARCHAR(1) NULL DEFAULT NULL COMMENT 'INDICA SI LA CUENTA MANEJA BASE RETENCION',
  `CUEN_IND_NOMINA` VARCHAR(1) NULL DEFAULT NULL COMMENT 'INDICA SI LA CUENTA ES DE NOMINA',
  `CUEN_IND_CTA_COBRAR` VARCHAR(1) NULL DEFAULT NULL COMMENT 'INDICA SI LA CUENTA ES DE CXC',
  `CUEN_IND_CTA_PAGAR` VARCHAR(1) NULL DEFAULT NULL COMMENT 'INDICA SI LA CUENTA ES DE CXP',
  `CUEN_PORCENTAJE` DECIMAL(6,4) NULL DEFAULT NULL COMMENT 'VALOR DEL PORCENTAJE A LA BASE GRAVABLE',
  `CUEN_IND_NIT_MVTO` VARCHAR(1) NULL DEFAULT NULL COMMENT 'INDICA QUE GUARDA EL NIT EN EL MOVIMIENTO PERO NO LLEVA SALDOS POR NIT',
  `CUEN_TIPO_MVTO` VARCHAR(1) NULL DEFAULT NULL COMMENT 'DEBITO O CREDITO [D - C]',
  `CUEN_FECHA_CREACION` DATETIME NULL DEFAULT NULL,
  `CUEN_PERIODO_PRIMER_MVTO` VARCHAR(6) NULL DEFAULT NULL,
  `CUEN_USUARIO` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`PK_CUEN_ANIO`, `PK_CUEN_GRUPO`, `PK_CUEN_SUB_GRUPO`, `PK_CUEN_MAYOR`, `PK_CUEN_SUB_MAYOR`, `PK_CUEN_AUXILIAR`, `FK_CUEN_EMPRESA`),
  INDEX `FK_EMPRESA_CUENTAS` (`FK_CUEN_EMPRESA` ASC),
  CONSTRAINT `FK_EMPRESA_CUENTAS`
    FOREIGN KEY (`FK_CUEN_EMPRESA`)
    REFERENCES `sysfrye_global`.`glb_empresas` (`PK_EMP_CODEMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sysfrye_conta`.`con_nits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sysfrye_conta`.`con_nits` (
  `PK_NIT_NIT` VARCHAR(15) NOT NULL,
  `NIT_TIPO` INT(11) NULL DEFAULT NULL,
  `NIT_DIGITO` VARCHAR(1) NULL DEFAULT NULL,
  `NIT_RAZONSOCIAL` VARCHAR(200) NULL DEFAULT NULL,
  `NIT_NOMBRE1` VARCHAR(50) NULL DEFAULT NULL,
  `NIT_NOMBRE2` VARCHAR(50) NULL DEFAULT NULL,
  `NIT_APELLIDO1` VARCHAR(50) NULL DEFAULT NULL,
  `NIT_APELLIDO2` VARCHAR(50) NULL DEFAULT NULL,
  `NIT_DIRECCION` VARCHAR(200) NULL DEFAULT NULL,
  `NIT_TELEFONO` VARCHAR(50) NULL DEFAULT NULL,
  `NIT_CIUDAD_DIAN` VARCHAR(6) NULL DEFAULT NULL,
  `NIT_EMAIL` VARCHAR(100) NULL DEFAULT NULL,
  `NIT_RESPONSABLE` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`PK_NIT_NIT`),
  INDEX `fk_CON_NITS_MULTITABLA` (`NIT_TIPO` ASC),
  CONSTRAINT `fk_CON_NITS_MULTITABLA`
    FOREIGN KEY (`NIT_TIPO`)
    REFERENCES `sysfrye_global`.`glb_multitabla` (`PK_MUL_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sysfrye_conta`.`con_tipos_doc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sysfrye_conta`.`con_tipos_doc` (
  `PF_EMP_TIP_EMPRESA` INT(11) NOT NULL,
  `PK_TIP_CODIGO` VARCHAR(3) NOT NULL,
  `TIP_DESCRIPCION` VARCHAR(50) NULL DEFAULT NULL,
  `TIP_COMPROBANTE_DIARIO` VARCHAR(6) NULL DEFAULT NULL,
  `TIP_ES_INTERFACE` VARCHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`PF_EMP_TIP_EMPRESA`, `PK_TIP_CODIGO`),
  CONSTRAINT `FK_TIPOSDOC_EMPRESA`
    FOREIGN KEY (`PF_EMP_TIP_EMPRESA`)
    REFERENCES `sysfrye_global`.`glb_empresas` (`PK_EMP_CODEMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sysfrye_conta`.`con_movimientos_contables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sysfrye_conta`.`con_movimientos_contables` (
  `PF_EMP_MOV_EMPRESA` INT(11) NOT NULL,
  `PF_TIP_MOV_TIPO_DCTO` VARCHAR(3) NOT NULL,
  `PK_MOV_NUMERO_DCTO` INT(11) NOT NULL,
  `PK_MOV_ENTRADA` INT(11) NOT NULL,
  `FK_CUEN_MOV_ANIO` VARCHAR(4) NOT NULL,
  `FK_CUEN_MOV_GRUPO` VARCHAR(1) NOT NULL,
  `FK_CUEN_MOV_SUB_GRUPO` VARCHAR(1) NOT NULL,
  `FK_CUEN_MOV_MAYOR` VARCHAR(2) NOT NULL,
  `FK_CUEN_MOV_SUB_MAYOR` VARCHAR(2) NOT NULL,
  `FK_CUEN_MOV_AUXILIAR` VARCHAR(4) NOT NULL,
  `FK_NIT_MOV_NIT` VARCHAR(15) NULL DEFAULT NULL,
  `FK_CEN_MOV_CENTRO_COSTO` VARCHAR(10) NULL DEFAULT NULL,
  `FK_CEN_MOV_SUBCENTRO_COSTO` VARCHAR(10) NULL DEFAULT NULL,
  `MOV_PERIODO` VARCHAR(6) NULL DEFAULT NULL,
  `MOV_COMPROBANTE_DIARIO` VARCHAR(6) NULL DEFAULT NULL,
  `MOV_REFERENCIA` VARCHAR(10) NULL DEFAULT NULL,
  `MOV_VALOR` DECIMAL(14,4) NULL DEFAULT NULL COMMENT 'TIPO DE DATO DECIMAL. (4 POS DECIMALES)',
  `MOV_TIPO_DC` VARCHAR(1) NULL DEFAULT NULL COMMENT 'DEBITO - CREDITO',
  `MOV_DESCRIPCION` VARCHAR(200) NULL DEFAULT NULL,
  `MOV_VALOR_BASE` DECIMAL(14,4) NULL DEFAULT NULL,
  `MOV_CODIGO_ORDENADOR` VARCHAR(2) NULL DEFAULT NULL,
  `MOV_FECHA_VTO` DATETIME NULL DEFAULT NULL,
  `MOV_VALOR_BASECOMPRA` DECIMAL(14,4) NULL DEFAULT NULL,
  `MOV_PORCENTAJE` DECIMAL(6,4) NULL DEFAULT NULL,
  `MOV_FECHA_CREACION` DATETIME NULL DEFAULT NULL,
  `MOV_USUARIO_CREACION` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`PF_EMP_MOV_EMPRESA`, `PF_TIP_MOV_TIPO_DCTO`, `PK_MOV_NUMERO_DCTO`, `PK_MOV_ENTRADA`),
  INDEX `fk_CON_MOVIMIENTO_CONTABLE_CON_CUENTAS_idx` (`FK_CUEN_MOV_ANIO` ASC, `FK_CUEN_MOV_GRUPO` ASC, `FK_CUEN_MOV_SUB_GRUPO` ASC, `FK_CUEN_MOV_MAYOR` ASC, `FK_CUEN_MOV_SUB_MAYOR` ASC, `FK_CUEN_MOV_AUXILIAR` ASC),
  INDEX `fk_CON_MOVIMIENTO_CONTABLE_CON_TIPOS_DOC1_idx` (`PF_EMP_MOV_EMPRESA` ASC, `PF_TIP_MOV_TIPO_DCTO` ASC),
  INDEX `fk_CON_MOVIMIENTO_CONTABLE_CENTROS` (`PF_EMP_MOV_EMPRESA` ASC, `FK_CEN_MOV_CENTRO_COSTO` ASC, `FK_CEN_MOV_SUBCENTRO_COSTO` ASC),
  INDEX `fk_CON_MOVIMIENTO_CONTABLE_NITS` (`FK_NIT_MOV_NIT` ASC),
  CONSTRAINT `fk_CON_MOVIMIENTO_CONTABLE_CENTROS`
    FOREIGN KEY (`PF_EMP_MOV_EMPRESA` , `FK_CEN_MOV_CENTRO_COSTO` , `FK_CEN_MOV_SUBCENTRO_COSTO`)
    REFERENCES `sysfrye_conta`.`con_centros_costos` (`PF_EMP_CEN_EMPRESA` , `PK_CEN_CENTRO_COSTO` , `PK_CEN_SUB_CENTRO_COSTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CON_MOVIMIENTO_CONTABLE_COADICIONALES`
    FOREIGN KEY (`PF_EMP_MOV_EMPRESA` , `PF_TIP_MOV_TIPO_DCTO` , `PK_MOV_NUMERO_DCTO`)
    REFERENCES `sysfrye_conta`.`con_conceptos_adicionales` (`PF_EMP_COA_EMPRESA` , `PK_COA_TIPO_DCTO` , `PK_COA_NUMERO_DCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CON_MOVIMIENTO_CONTABLE_CON_CUENTAS`
    FOREIGN KEY (`FK_CUEN_MOV_ANIO` , `FK_CUEN_MOV_GRUPO` , `FK_CUEN_MOV_SUB_GRUPO` , `FK_CUEN_MOV_MAYOR` , `FK_CUEN_MOV_SUB_MAYOR` , `FK_CUEN_MOV_AUXILIAR`)
    REFERENCES `sysfrye_conta`.`con_cuentas` (`PK_CUEN_ANIO` , `PK_CUEN_GRUPO` , `PK_CUEN_SUB_GRUPO` , `PK_CUEN_MAYOR` , `PK_CUEN_SUB_MAYOR` , `PK_CUEN_AUXILIAR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CON_MOVIMIENTO_CONTABLE_EMPRESA`
    FOREIGN KEY (`PF_EMP_MOV_EMPRESA`)
    REFERENCES `sysfrye_global`.`glb_empresas` (`PK_EMP_CODEMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CON_MOVIMIENTO_CONTABLE_NITS`
    FOREIGN KEY (`FK_NIT_MOV_NIT`)
    REFERENCES `sysfrye_conta`.`con_nits` (`PK_NIT_NIT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CON_MOVIMIENTO_CONTABLE_TIPOS`
    FOREIGN KEY (`PF_EMP_MOV_EMPRESA` , `PF_TIP_MOV_TIPO_DCTO`)
    REFERENCES `sysfrye_conta`.`con_tipos_doc` (`PF_EMP_TIP_EMPRESA` , `PK_TIP_CODIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sysfrye_conta`.`con_saldos_cuentas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sysfrye_conta`.`con_saldos_cuentas` (
  `PF_EMP_SAL_EMPRESA` INT(11) NOT NULL,
  `PF_CUEN_SAL_ANIO` VARCHAR(4) NOT NULL,
  `PK_SAL_MES` VARCHAR(2) NOT NULL,
  `PF_CUEN_SAL_GRUPO` VARCHAR(1) NOT NULL,
  `PF_CUEN_SAL_SUB_GRUPO` VARCHAR(1) NOT NULL,
  `PF_CUEN_SAL_MAYOR` VARCHAR(2) NOT NULL,
  `PF_CUEN_SAL_SUB_MAYOR` VARCHAR(2) NOT NULL,
  `PF_CUEN_SAL_AUXILIAR` VARCHAR(4) NOT NULL,
  `PK_SAL_NIT` VARCHAR(15) NOT NULL,
  `PK_SAL_CENTRO_COSTO` VARCHAR(10) NOT NULL,
  `PK_SAL_SUB_CENTRO_COSTO` VARCHAR(10) NOT NULL,
  `SAL_SALDO_ANTERIOR` FLOAT NULL DEFAULT NULL,
  `SAL_TOTAL_DEBITOS` FLOAT NULL DEFAULT NULL,
  `SAL_TOTAL_CREDITOS` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`PF_EMP_SAL_EMPRESA`, `PF_CUEN_SAL_ANIO`, `PK_SAL_MES`, `PF_CUEN_SAL_GRUPO`, `PF_CUEN_SAL_SUB_GRUPO`, `PF_CUEN_SAL_MAYOR`, `PF_CUEN_SAL_SUB_MAYOR`, `PF_CUEN_SAL_AUXILIAR`, `PK_SAL_NIT`, `PK_SAL_CENTRO_COSTO`, `PK_SAL_SUB_CENTRO_COSTO`),
  INDEX `fk_CON_SALDOS_CUENTAS_CON_CUENTAS1_idx` (`PF_CUEN_SAL_ANIO` ASC, `PF_CUEN_SAL_GRUPO` ASC, `PF_CUEN_SAL_SUB_GRUPO` ASC, `PF_CUEN_SAL_MAYOR` ASC, `PF_CUEN_SAL_SUB_MAYOR` ASC, `PF_CUEN_SAL_AUXILIAR` ASC),
  CONSTRAINT `FK_SALDOSCUENTAS_EMPRESA`
    FOREIGN KEY (`PF_EMP_SAL_EMPRESA`)
    REFERENCES `sysfrye_global`.`glb_empresas` (`PK_EMP_CODEMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CON_SALDOS_CUENTAS_CON_CUENTAS1`
    FOREIGN KEY (`PF_CUEN_SAL_ANIO` , `PF_CUEN_SAL_GRUPO` , `PF_CUEN_SAL_SUB_GRUPO` , `PF_CUEN_SAL_MAYOR` , `PF_CUEN_SAL_SUB_MAYOR` , `PF_CUEN_SAL_AUXILIAR`)
    REFERENCES `sysfrye_conta`.`con_cuentas` (`PK_CUEN_ANIO` , `PK_CUEN_GRUPO` , `PK_CUEN_SUB_GRUPO` , `PK_CUEN_MAYOR` , `PK_CUEN_SUB_MAYOR` , `PK_CUEN_AUXILIAR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sysfrye_conta`.`con_saldos_cuentas_dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sysfrye_conta`.`con_saldos_cuentas_dia` (
  `PF_EMP_SAD_EMPRESA` INT(11) NOT NULL,
  `PF_CUEN_SAD_ANIO` VARCHAR(4) NOT NULL,
  `PK_SAD_FECHA` VARCHAR(8) NOT NULL,
  `PF_CUEN_SAD_GRUPO` VARCHAR(1) NOT NULL,
  `PF_CUEN_SAD_SUB_GRUPO` VARCHAR(1) NOT NULL,
  `PF_CUEN_SAD_MAYOR` VARCHAR(2) NOT NULL,
  `PF_CUEN_SAD_SUB_MAYOR` VARCHAR(2) NOT NULL,
  `PF_CUEN_SAD_AUXILIAR` VARCHAR(4) NOT NULL,
  `PK_SAD_NIT` VARCHAR(15) NOT NULL,
  `PK_SAD_CENTRO_COSTO` VARCHAR(10) NOT NULL,
  `PK_SAD_SUB_CENTRO_COSTO` VARCHAR(10) NOT NULL,
  `SAD_SALDO_ANTERIOR` FLOAT NULL DEFAULT NULL,
  `SAD_TOTAL_DEBITOS` FLOAT NULL DEFAULT NULL,
  `SAD_TOTAL_CREDITOS` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`PF_EMP_SAD_EMPRESA`, `PF_CUEN_SAD_ANIO`, `PK_SAD_FECHA`, `PF_CUEN_SAD_GRUPO`, `PF_CUEN_SAD_SUB_GRUPO`, `PF_CUEN_SAD_MAYOR`, `PF_CUEN_SAD_SUB_MAYOR`, `PF_CUEN_SAD_AUXILIAR`, `PK_SAD_NIT`, `PK_SAD_CENTRO_COSTO`, `PK_SAD_SUB_CENTRO_COSTO`),
  INDEX `fk_CON_SALDOS_CUENTAS_CON_CUENTAS_DIA_idx` (`PF_CUEN_SAD_ANIO` ASC, `PF_CUEN_SAD_GRUPO` ASC, `PF_CUEN_SAD_SUB_GRUPO` ASC, `PF_CUEN_SAD_MAYOR` ASC, `PF_CUEN_SAD_SUB_MAYOR` ASC, `PF_CUEN_SAD_AUXILIAR` ASC),
  CONSTRAINT `FK_SALDOSCUENTASFECHA_EMPRESA`
    FOREIGN KEY (`PF_EMP_SAD_EMPRESA`)
    REFERENCES `sysfrye_global`.`glb_empresas` (`PK_EMP_CODEMPRESA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CON_SALDOS_CUENTAS_CON_CUENTAS_DIA`
    FOREIGN KEY (`PF_CUEN_SAD_ANIO` , `PF_CUEN_SAD_GRUPO` , `PF_CUEN_SAD_SUB_GRUPO` , `PF_CUEN_SAD_MAYOR` , `PF_CUEN_SAD_SUB_MAYOR` , `PF_CUEN_SAD_AUXILIAR`)
    REFERENCES `sysfrye_conta`.`con_cuentas` (`PK_CUEN_ANIO` , `PK_CUEN_GRUPO` , `PK_CUEN_SUB_GRUPO` , `PK_CUEN_MAYOR` , `PK_CUEN_SUB_MAYOR` , `PK_CUEN_AUXILIAR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;