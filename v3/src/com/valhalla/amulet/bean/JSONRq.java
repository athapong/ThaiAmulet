package com.valhalla.amulet.bean;

public class JSONRq {
    private String id4scan;
    private String sql;
    private String table;

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }



    public String getId4scan() {
        return id4scan;
    }

    public void setId4scan(String id4scan) {
        this.id4scan = id4scan;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }
}
