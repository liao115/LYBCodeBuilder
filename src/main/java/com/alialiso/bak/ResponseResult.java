package com.alialiso.bak;

import lombok.Data;
import java.io.Serializable;
/**
 * @author 廖育彬
 * @date 2018/5/5.
 */
@Data
public class ResponseResult implements Serializable  {
    private static final long serialVersionUID = 1L;

    private String code;
    private String msg;
    private Object data;

    /**
     * 成功不返回参数
     */
    public ResponseResult(){
        this.code = CodeConstants.success.getCode();
        this.msg = CodeConstants.success.getMsg();
    }

    /**
     * 成功时返回参数
     */
    public ResponseResult(Object data){
        this.code = CodeConstants.success.getCode();
        this.msg = CodeConstants.success.getMsg();
        this.data = data;
    }

    /**
     * 失败不返回参数
     */
    public ResponseResult(String code, String msg){
        this.code = code;
        this.msg = msg;
    }

    /**
     * 失败返回参数
     */
    public ResponseResult(String code, String msg, Object data){
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public ResponseResult setData(Object data){
        this.data = data;
        return this;
    }

}
