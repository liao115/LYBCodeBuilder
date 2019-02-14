package com.alialiso.CodeBuilder;

import java.io.File;
/**
 * @author 廖育彬
 * @date 2019/2/14.
 */
public class Main {

    public static void main(String[] args) throws Exception{
        //启动前需要修改CodeBuilderUtil的常量配置
        CodeBuilderUtil codeGenerateUtils = new CodeBuilderUtil();
        codeGenerateUtils.generate();
    }
}
