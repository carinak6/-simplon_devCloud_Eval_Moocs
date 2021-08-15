CREATE DATABASE  IF NOT EXISTS bdd_evalmoocstest;
USE bdd_evalmoocstest;

--
-- Table type_utilisateur
--

DROP TABLE IF EXISTS type_utilisateur;
CREATE TABLE type_utilisateur (
  id_type_utilisateur int(11) unsigned NOT NULL AUTO_INCREMENT,
  libelle varchar(200) DEFAULT NULL,
  droit_ajouter_commentaire tinyint(1) DEFAULT NULL,
  droit_ajouter_notation tinyint(1) DEFAULT NULL,
  droit_promouvoir_utilisateur tinyint(1) DEFAULT NULL,
  droit_suprimer_comentaires tinyint(1) DEFAULT NULL,
  droit_actualiser_cours tinyint(1) DEFAULT NULL,
  droit_suprimer_cours tinyint(1) DEFAULT NULL,
  PRIMARY KEY (id_type_utilisateur)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table utilisateur
--
DROP TABLE IF EXISTS utilisateur;
CREATE TABLE utilisateur (
  id_utilisateur int(11) unsigned NOT NULL AUTO_INCREMENT,
  nom varchar(200) NOT NULL,
  prenom varchar(200) NOT NULL,
  adresse varchar(250) DEFAULT NULL,
  telephone varchar(30) DEFAULT NULL,
  email varchar(250) DEFAULT NULL,
  fk_id_type_utilisateur int(11) unsigned NOT NULL,
  PRIMARY KEY (id_utilisateur),
  KEY constraint_chapitre_idx (fk_id_type_utilisateur),
  CONSTRAINT PK_type_utilisateur FOREIGN KEY (fk_id_type_utilisateur) REFERENCES type_utilisateur (id_type_utilisateur) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table mooc
--
DROP TABLE IF EXISTS mooc;
CREATE TABLE mooc (
  id_mooc int(11) unsigned NOT NULL,
  title varchar(250) NOT NULL,
  duration varchar(45) DEFAULT NULL,
  description longtext,
  material_necesaire longtext,
  date_creation datetime DEFAULT NULL,
  fk_id_autheur_utilisateur int(11) unsigned NOT NULL,
  PRIMARY KEY (id_mooc),
  KEY constraint_utilisateur_idx (fk_id_autheur_utilisateur),
  CONSTRAINT constraint_utilisateur FOREIGN KEY (fk_id_autheur_utilisateur) REFERENCES utilisateur (id_utilisateur) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table chapitre
--
DROP TABLE IF EXISTS chapitre;
CREATE TABLE chapitre (
  id_chapitre int(11) unsigned NOT NULL AUTO_INCREMENT,
  titre_chapitre varchar(250) DEFAULT NULL,
  duration datetime DEFAULT NULL,
  fk_id_mooc int(11) unsigned NOT NULL,
  PRIMARY KEY (id_chapitre),
  KEY constraint_mooc_idx (fk_id_mooc),
  CONSTRAINT constraint_chapitre_mooc FOREIGN KEY (fk_id_mooc) REFERENCES mooc (id_mooc) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table commentaire
--
DROP TABLE IF EXISTS commentaire;
CREATE TABLE commentaire (
  id_commentaire int(11) NOT NULL AUTO_INCREMENT,
  texte_commentaire longtext NOT NULL,
  date_time_creation datetime DEFAULT NULL,
  fk_id_mooc int(11) unsigned NOT NULL,
  fk_id_utilisateur int(11) unsigned NOT NULL,
  PRIMARY KEY (id_commentaire),
  KEY constraint_commentaire_mooc_idx (fk_id_mooc),
  KEY constraint_commentaire_utilisateur_idx (fk_id_utilisateur),
  CONSTRAINT constraint_commentaire_mooc FOREIGN KEY (fk_id_mooc) REFERENCES mooc (id_mooc) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT constraint_commentaire_utilisateur FOREIGN KEY (fk_id_utilisateur) REFERENCES utilisateur (id_utilisateur) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



--
-- Table note
--
DROP TABLE IF EXISTS note;
CREATE TABLE note (
  id_note int(11) unsigned NOT NULL AUTO_INCREMENT,
  nb_etoiles int(11) NOT NULL,
  libelle varchar(45) NOT NULL,
  PRIMARY KEY (id_note)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table notexmooc
--
DROP TABLE IF EXISTS notexmooc;
CREATE TABLE notexmooc (
  nxm_id_mooc int(11) unsigned NOT NULL,
  nxm_note int(11) unsigned NOT NULL,
  mxc_id_utilisateur int(11) unsigned NOT NULL,
  date_notation datetime DEFAULT NULL,
  PRIMARY KEY (nxm_id_mooc,nxm_note,mxc_id_utilisateur),
  KEY constraint_nxm_notes_idx (nxm_note),
  KEY constraint_nxm_utilisateur_idx (mxc_id_utilisateur),
  CONSTRAINT constraint_nxm_mooc FOREIGN KEY (nxm_id_mooc) REFERENCES mooc (id_mooc) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT constraint_nxm_note FOREIGN KEY (nxm_note) REFERENCES note (id_note) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT constraint_nxm_utilisateur FOREIGN KEY (mxc_id_utilisateur) REFERENCES utilisateur (id_utilisateur) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



