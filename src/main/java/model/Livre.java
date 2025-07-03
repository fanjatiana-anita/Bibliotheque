package model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "livre")
public class Livre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idLivre;

    private String titreLivre;

    @ManyToOne
    @JoinColumn(name = "idAuteur")
    private Auteur auteur;

    @ManyToMany
    @JoinTable(
        name = "theme_livre",
        joinColumns = @JoinColumn(name = "idLivre"),
        inverseJoinColumns = @JoinColumn(name = "idTheme")
    )
    private List<Theme> themes;

    public Integer getIdLivre() {
        return idLivre;
    }

    public void setIdLivre(Integer idLivre) {
        this.idLivre = idLivre;
    }

    public String getTitreLivre() {
        return titreLivre;
    }

    public void setTitreLivre(String titreLivre) {
        this.titreLivre = titreLivre;
    }

    public Auteur getAuteur() {
        return auteur;
    }

    public void setAuteur(Auteur auteur) {
        this.auteur = auteur;
    }

    public List<Theme> getThemes() {
        return themes;
    }

    public void setThemes(List<Theme> themes) {
        this.themes = themes;
    }
}
