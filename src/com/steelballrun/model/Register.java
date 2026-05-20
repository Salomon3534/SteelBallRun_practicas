package com.steelballrun.model;

import java.util.Date;

public class Register {
    private int id;
    private int runnerId;
    private int stageId;
    private int saddleNumber;
    private Date registrationDate;

    public Register() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getRunnerId() { return runnerId; }
    public void setRunnerId(int runnerId) { this.runnerId = runnerId; }

    public int getStageId() { return stageId; }
    public void setStageId(int stageId) { this.stageId = stageId; }

    public int getSaddleNumber() { return saddleNumber; }
    public void setSaddleNumber(int saddleNumber) { this.saddleNumber = saddleNumber; }

    public Date getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(Date registrationDate) { this.registrationDate = registrationDate; }
}
