package com.alialiso.bak;

import lombok.Getter;
/**
 * @author 廖育彬
 * @date 2018/5/5.
 */
@Getter
public enum CodeConstants {
    //==============响应码=================
    error("00000","操作失败，请重试!"),
    success("10000","操作成功"),
    system_error("10001","系统异常!")
    ;

    //===============================
    private String code;
    private String msg;

    private CodeConstants(String code, String msg){
        this.code = code;
        this.msg = msg;
    }
}
