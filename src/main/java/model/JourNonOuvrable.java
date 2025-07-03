package model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "journonouvrable")
public class JourNonOuvrable {

    public enum TypeJour {
        FERIE,
        HEBDOMADAIRE,
        EXCEPTIONNEL
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idJourNonOuvrable;

    @Enumerated(EnumType.STRING)
    private TypeJour type;

    private Integer jourSemaine; 

    private LocalDate dateFerie;

    private String description;


    public Integer getIdJourNonOuvrable() {
        return idJourNonOuvrable;
    }

    public void setIdJourNonOuvrable(Integer idJourNonOuvrable) {
        this.idJourNonOuvrable = idJourNonOuvrable;
    }

    public TypeJour getType() {
        return type;
    }

    public void setType(TypeJour type) {
        this.type = type;
    }

    public Integer getJourSemaine() {
        return jourSemaine;
    }

    public void setJourSemaine(Integer jourSemaine) {
        this.jourSemaine = jourSemaine;
    }

    public LocalDate getDateFerie() {
        return dateFerie;
    }

    public void setDateFerie(LocalDate dateFerie) {
        this.dateFerie = dateFerie;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
