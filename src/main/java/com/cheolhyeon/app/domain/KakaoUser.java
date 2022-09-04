package com.cheolhyeon.app.domain;

public class KakaoUser {
    private int k_no;
    private String k_name;
    private String k_email;


    public KakaoUser(){};

    public KakaoUser(String k_name, String k_email) {
        this.k_name = k_name;
        this.k_email = k_email;
    }


    public int getK_no() {
        return k_no;
    }

    public void setK_no(int k_no) {
        this.k_no = k_no;
    }

    public String getK_name() {
        return k_name;
    }

    public void setK_name(String k_name) {
        this.k_name = k_name;
    }

    public String getK_email() {
        return k_email;
    }

    public void setK_email(String k_email) {
        this.k_email = k_email;
    }

    @Override
    public String toString() {
        return "KakaoUser{" +
                "k_no=" + k_no +
                ", k_name='" + k_name + '\'' +
                ", k_email='" + k_email + '\'' +
                '}';
    }
}
