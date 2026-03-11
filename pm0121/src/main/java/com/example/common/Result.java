package com.example.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor //生成无参构造
@AllArgsConstructor //生成全参构造
public class Result<T>{
    private Integer code; //状态码（如 200 成功，400 失败）
    private String msg; //提示信息
    private T data; //响应数据（泛型）

    //成功响应（带数据）
    public static <T> Result<T> success(T data) {
        return new Result<>(200,"success",data);
    }

    //成功响应（无数据）
    public static <T> Result<T> success(String msg) {
        return new Result<>(200,msg,null);
    }
    //错误响应
    public static <T> Result<T> error(String msg) {
        return new Result<>(400,msg,null);
    }


}
