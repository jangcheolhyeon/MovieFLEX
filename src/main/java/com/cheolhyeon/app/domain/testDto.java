package com.cheolhyeon.app.domain;

import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Valid
public class testDto {
    @Size(min = 2, max = 10, message = "아이디 오류!")
    private String data1;

    @Size(min = 8, max = 30, message = "비밀번호 오류!")
    private String data2;

    public String getData1() {
        return data1;
    }

    public void setData1(String data1) {
        this.data1 = data1;
    }

    public String getData2() {
        return data2;
    }

    public void setData2(String data2) {
        this.data2 = data2;
    }
}