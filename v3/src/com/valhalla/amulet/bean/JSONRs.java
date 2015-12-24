package com.valhalla.amulet.bean;

import java.util.List;

public class JSONRs {
    private JSONRq req;
    private List entities;
    private String status;


    public JSONRq getReq() {
        return req;
    }

    public void setReq(JSONRq req) {
        this.req = req;
    }
    public List getEntities() {
        return entities;
    }

    public void setEntities(List entities) {
        this.entities = entities;
    }
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
