package model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "historiqueetat")
public class HistoriqueEtat {

    public enum Entite {
        PRET,
        RESERVATION,
        PROLONGEMENT
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idHistoriqueEtat;

    @Enumerated(EnumType.STRING)
    private Entite entite;

    private Integer id_entite;

    private LocalDateTime date_changement;

    private String etatAvant;

    private String etatApres;


    public Integer getIdHistoriqueEtat() {
        return idHistoriqueEtat;
    }

    public void setIdHistoriqueEtat(Integer idHistoriqueEtat) {
        this.idHistoriqueEtat = idHistoriqueEtat;
    }

    public Entite getEntite() {
        return entite;
    }

    public void setEntite(Entite entite) {
        this.entite = entite;
    }

    public Integer getId_entite() {
        return id_entite;
    }

    public void setId_entite(Integer id_entite) {
        this.id_entite = id_entite;
    }

    public LocalDateTime getDate_changement() {
        return date_changement;
    }

    public void setDate_changement(LocalDateTime date_changement) {
        this.date_changement = date_changement;
    }

    public String getEtatAvant() {
        return etatAvant;
    }

    public void setEtatAvant(String etatAvant) {
        this.etatAvant = etatAvant;
    }

    public String getEtatApres() {
        return etatApres;
    }

    public void setEtatApres(String etatApres) {
        this.etatApres = etatApres;
    }
}
