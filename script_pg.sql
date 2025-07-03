
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
    dureePenalite INTEGER
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