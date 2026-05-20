package com.steelballrun.model;

public class Runner {
    private int bib;
    private int idPerson;
    private int idMount;
    private byte[] image;
    private Integer points;
    private Integer km;
    private Integer idStage;
    private String passkey;

    public Runner() {}

    public int getBib() { return bib; }
    public void setBib(int bib) { this.bib = bib; }

    public int getIdPerson() { return idPerson; }
    public void setIdPerson(int idPerson) { this.idPerson = idPerson; }

    public int getIdMount() { return idMount; }
    public void setIdMount(int idMount) { this.idMount = idMount; }

    public byte[] getImage() { return image; }
    public void setImage(byte[] image) { this.image = image; }

    public Integer getPoints() { return points; }
    public void setPoints(Integer points) { this.points = points; }

    public Integer getKm() { return km; }
    public void setKm(Integer km) { this.km = km; }

    public Integer getIdStage() { return idStage; }
    public void setIdStage(Integer idStage) { this.idStage = idStage; }

    public String getPasskey() { return passkey; }
    public void setPasskey(String passkey) { this.passkey = passkey; }
}
