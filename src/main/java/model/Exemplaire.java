package model;

import jakarta.persistence.*;

@Entity
@Table(name = "exemplaire")
public class Exemplaire {

    public enum StatutExemplaire {
        DISPONIBLE,
        RESERVE,
        EN_PRET
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idExemplaire;

    @ManyToOne
    @JoinColumn(name = "idLivre")
    private Livre livre;

    @Enumerated(EnumType.STRING)
    private StatutExemplaire statutExemplaire;

    public Integer getIdExemplaire() {
        return idExemplaire;
    }

    public void setIdExemplaire(Integer idExemplaire) {
        this.idExemplaire = idExemplaire;
    }

    public Livre getLivre() {
        return livre;
    }

    public void setLivre(Livre livre) {
        this.livre = livre;
    }

    public StatutExemplaire getStatutExemplaire() {
        return statutExemplaire;
    }

    public void setStatutExemplaire(StatutExemplaire statutExemplaire) {
        this.statutExemplaire = statutExemplaire;
    }
}
