CREATE DATABASE bibliotheque_mvc;
\c bibliotheque_mvc
-- =========================
-- ENUMS nécessaires
-- =========================
CREATE TYPE role_enum AS ENUM ('BIBLIOTHECAIRE', 'ADHERENT');
CREATE TYPE statut_exemplaire_enum AS ENUM ('DISPONIBLE', 'RESERVE', 'EN_PRET');
CREATE TYPE statut_reservation_enum AS ENUM ('VALIDE', 'EN_ATTENTE_DE_VALIDATION');
CREATE TYPE entite_enum AS ENUM ('PRET', 'RESERVATION', 'PROLONGEMENT');
CREATE TYPE statut_prolongement_enum AS ENUM ('VALIDE', 'EN_ATTENTE_DE_VALIDATION');
CREATE TYPE type_jour_enum AS ENUM ('FERIE', 'HEBDOMADAIRE', 'EXCEPTIONNEL');

-- =========================
-- TABLES
-- =========================

-- Personne
CREATE TABLE Personne (
    idPersonne SERIAL PRIMARY KEY,
    nomPersonne VARCHAR(100) NOT NULL,
    dateDeNaissance DATE NOT NULL,
    sexe VARCHAR(10),
    adresse TEXT
);

-- UserAccount
CREATE TABLE UserAccount (
    idUserAccount SERIAL PRIMARY KEY,
    idPersonne INTEGER REFERENCES Personne(idPersonne) ON DELETE CASCADE,
    login VARCHAR(100) UNIQUE NOT NULL,
    motDePasse VARCHAR(100) NOT NULL,
    role role_enum NOT NULL,
    estActif BOOLEAN DEFAULT TRUE
);

-- Profil
CREATE TABLE Profil (
    idProfil SERIAL PRIMARY KEY,
    profil VARCHAR(50) NOT NULL,
    montantCotisation NUMERIC(10, 2),
    quotaMax INTEGER,
    quotaProlongement INTEGER,
    quotaReservation INTEGER,
    dureePenalite INTEGER,
    dureeMaxPret INTEGER
);

-- Adherent
CREATE TABLE Adherent (
    idAdherent SERIAL PRIMARY KEY,
    idUserAccount INTEGER REFERENCES UserAccount(idUserAccount) ON DELETE CASCADE,
    idProfil INTEGER REFERENCES Profil(idProfil)
);

-- Bibliothecaire
CREATE TABLE Bibliothecaire (
    idBibliothecaire SERIAL PRIMARY KEY,
    idUserAccount INTEGER REFERENCES UserAccount(idUserAccount) ON DELETE CASCADE
);

-- Abonnement
CREATE TABLE Abonnement (
    idAbonnement SERIAL PRIMARY KEY,
    idAdherent INTEGER REFERENCES Adherent(idAdherent) ON DELETE CASCADE,
    dateDebut DATE NOT NULL,
    dateFin DATE NOT NULL
);

-- Auteur
CREATE TABLE Auteur (
    idAuteur SERIAL PRIMARY KEY,
    idPersonne INTEGER REFERENCES Personne(idPersonne) ON DELETE CASCADE
);

-- Theme
CREATE TABLE Theme (
    idTheme SERIAL PRIMARY KEY,
    theme VARCHAR(100) NOT NULL
);

-- Livre
CREATE TABLE Livre (
    idLivre SERIAL PRIMARY KEY,
    titreLivre VARCHAR(200) NOT NULL,
    idAuteur INTEGER REFERENCES Auteur(idAuteur)
);

-- Theme_Livre
CREATE TABLE Theme_Livre (
    idTheme INTEGER REFERENCES Theme(idTheme) ON DELETE CASCADE,
    idLivre INTEGER REFERENCES Livre(idLivre) ON DELETE CASCADE,
    PRIMARY KEY (idTheme, idLivre)
);

-- Exemplaire
CREATE TABLE Exemplaire (
    idExemplaire SERIAL PRIMARY KEY,
    idLivre INTEGER REFERENCES Livre(idLivre) ON DELETE CASCADE,
    statutExemplaire statut_exemplaire_enum NOT NULL
);

-- RestrictionProfilLivre
CREATE TABLE RestrictionProfilLivre (
    idRestrictionProfilLivre SERIAL PRIMARY KEY,
    idLivre INTEGER REFERENCES Livre(idLivre),
    ageMinRequis INTEGER,
    idProfil INTEGER REFERENCES Profil(idProfil)
);

-- Pret
CREATE TABLE Pret (
    idPret SERIAL PRIMARY KEY,
    idAdherent INTEGER REFERENCES Adherent(idAdherent),
    idExemplaire INTEGER REFERENCES Exemplaire(idExemplaire),
    dateDuPret DATE NOT NULL,
    dateDeRetourPrevue DATE,
    dateDeRetourReelle DATE
);
CREATE TABLE ListeLecture (
    idListeLecture SERIAL PRIMARY KEY,
    idAdherent INTEGER REFERENCES Adherent(idAdherent),
    idExemplaire INTEGER REFERENCES Exemplaire(idExemplaire),
    debutLecture DATETIME NOT NULL,
    finLecture DATETIME
);

-- Reservation
CREATE TABLE Reservation (
    idReservation SERIAL PRIMARY KEY,
    idAdherent INTEGER REFERENCES Adherent(idAdherent),
    idExemplaire INTEGER REFERENCES Exemplaire(idExemplaire),
    dateDeReservation DATE,
    dateDuPretPrevue DATE,
    statutReservation statut_reservation_enum NOT NULL
);

-- HistoriqueEtat
CREATE TABLE HistoriqueEtat (
    idHistoriqueEtat SERIAL PRIMARY KEY,
    entite entite_enum NOT NULL,
    id_entite INTEGER NOT NULL,
    date_changement TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    etat_avant VARCHAR(100),
    etat_apres VARCHAR(100)
);

-- Prolongement VALIDATION BIBLIOTHECAIRE   
CREATE TABLE Prolongement (
    idProlongement SERIAL PRIMARY KEY,
    idPret INTEGER REFERENCES Pret(idPret),
    dateDeDemande DATE NOT NULL,
    statutProlongement statut_prolongement_enum NOT NULL
);

-- Penalisation
CREATE TABLE Penalisation (
    idPenalisation SERIAL PRIMARY KEY,
    idAdherent INTEGER REFERENCES Adherent(idAdherent),
    idPret INTEGER REFERENCES Pret(idPret),
    dateDebutPenalisation DATE NOT NULL,
    dateFinPenalisation DATE NOT NULL
);

-- JourNonOuvrable
CREATE TABLE JourNonOuvrable (
    idJourNonOuvrable SERIAL PRIMARY KEY,
    type type_jour_enum NOT NULL,
    jourSemaine SMALLINT CHECK (jourSemaine BETWEEN 1 AND 7),
    dateFerie DATE,
    description VARCHAR(150)
);

INSERT INTO Personne (nomPersonne, dateDeNaissance, sexe, adresse) VALUES
('Jean Rasoanaivo', '1995-06-12', 'Homme', 'Lot II Analakely'),
('Marie Rakoto', '2002-04-18', 'Femme', 'Ambanidia'),
('Pauline Andrianarisoa', '1985-01-10', 'Femme', 'Ivandry'),
('Hery Ramaroson', '1990-09-22', 'Homme', 'Ambohipo');

INSERT INTO UserAccount (idPersonne, login, motDePasse, role, estActif) VALUES
(1, 'adherant', 'adherant', 'ADHERENT', true),
(2, 'marie2002', 'motdepasse', 'ADHERENT', true),
(3, 'admin', 'admin', 'BIBLIOTHECAIRE', true),
(4, 'heryBib', 'biblio2025', 'BIBLIOTHECAIRE', true);

INSERT INTO Profil (profil, montantCotisation, quotaMax, quotaProlongement, quotaReservation, dureePenalite, dureeMaxPret) VALUES
('Étudiant', 5000, 3, 2, 2, 5, 7),
('Professionnel', 10000, 5, 3, 3, 3, 10),
('Professeur', 15000, 7, 4, 4, 2, 15);

INSERT INTO Adherent (idUserAccount, idProfil) VALUES
(1, 1),
(2, 2);

INSERT INTO Bibliothecaire (idUserAccount) VALUES
(3),
(4);

INSERT INTO Abonnement (idAdherent, dateDebut, dateFin) VALUES
(1, '2025-01-01', '2025-12-31'),
(2, '2025-02-01', '2025-10-31');

INSERT INTO Auteur (idPersonne) VALUES
(1),
(2);

INSERT INTO Theme (theme) VALUES
('Science Fiction'),
('Philosophie'),
('Informatique');

INSERT INTO Livre (titreLivre, idAuteur) VALUES
('Les robots rêvent-ils ?', 1),
('La logique de l’esprit', 2);

INSERT INTO Theme_Livre (idTheme, idLivre) VALUES
(1, 1),
(2, 2);

INSERT INTO Exemplaire (idLivre, statutExemplaire) VALUES
(1, 'DISPONIBLE'),
(1, 'RESERVE'),
(2, 'EN_PRET');

INSERT INTO RestrictionProfilLivre (idLivre, ageMinRequis, idProfil) VALUES
(1, 18, 1),
(2, 25, 2);
