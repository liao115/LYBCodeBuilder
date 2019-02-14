package com.alialiso.CodeBuilder;
import freemarker.template.Template;
import org.apache.commons.lang3.StringUtils;

import java.io.*;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 廖育彬
 * @date 2019/2/14.
 */
public class CodeBuilderUtil {

    //修改以下配置》》》》》》》》》》》》》》》》》》》》》》》》》》》》
    private final String AUTHOR = "廖育彬";//作者
    private final String tableName = "goods_menu";//表名称
    private final String packageName = "com.alialiso.code";//生成的包名
    private final String tableAnnotation = "菜单";//表注释

    private final String URL = "jdbc:mysql:///order";//数据库url
    private final String USER = "";//数据库用户名
    private final String PASSWORD = "";//数据库密码
    private final String idGenPath = "com.alialiso.bak.IdGen";//id生成器引用路径
    private final String responseResultPath = "com.alialiso.bak.ResponseResult";//响应对象引用路径
    private final String codeConstantsPath = "com.alialiso.bak.CodeConstants";//码表应用路径
    //《《《《《《《《《《《《《《《《《《《《《《《《《《《《《《《《《《
    private final String DRIVER = "com.mysql.jdbc.Driver";//数据库驱动
    private final String diskPath = getProjectPath()+"/src/main/java/com/alialiso/code/";//代码存放的模板地址
    private String primaryKey;
    private final String changeTableName = replaceUnderLineAndUpperCase(tableName);
    private final String CURRENT_DATE = dateTransfer();

    //获取数据库连接
    public Connection getConnection() throws Exception{
        Class.forName(DRIVER);
        Connection connection= DriverManager.getConnection(URL, USER, PASSWORD);
        return connection;
    }

    //启动
    public static void main(String[] args) throws Exception{
        CodeBuilderUtil codeGenerateUtils = new CodeBuilderUtil();
        codeGenerateUtils.generate();
    }

    //生成过程
    public void generate() throws Exception{
        try {
            Connection connection = getConnection();
            DatabaseMetaData databaseMetaData = connection.getMetaData();
            ResultSet resultSet = databaseMetaData.getColumns(null,"%", tableName,"%");
            ResultSet primaryKeys = databaseMetaData.getPrimaryKeys(connection.getCatalog(), null, tableName);
            while(primaryKeys.next()){
                primaryKey = primaryKeys.getString("COLUMN_NAME");
            }
            List<ColumnClass> columnClassList = new ArrayList<>();
            ColumnClass columnClass = null;
            while(resultSet.next()){
                //id字段略过
                if(resultSet.getString("COLUMN_NAME").equals("id")) continue;
                columnClass = new ColumnClass();
                //获取字段名称
                columnClass.setColumnName(resultSet.getString("COLUMN_NAME"));
                //获取字段类型
                columnClass.setColumnType(resultSet.getString("TYPE_NAME"));
                //转换字段名称，如 sys_name 变成 SysName
                columnClass.setChangeColumnName(replaceUnderLineAndUpperCase(resultSet.getString("COLUMN_NAME")));
                //字段在数据库的注释
                columnClass.setColumnComment(resultSet.getString("REMARKS"));
                columnClassList.add(columnClass);
            }
            Map<String,Object> dataMap = new HashMap<>();
            dataMap.put("model_column",columnClassList);
            //生成Mapper文件
            generateMapperFile(dataMap);
            //生成Model文件
            generateModelFile(dataMap);
            //生成Dao文件
            generateDaoFile();
            //生成服务层接口文件
            generateServiceInterfaceFile();
            //生成服务实现层文件
            generateServiceImplFile();
            //生成Controller层文件
            generateControllerFile();
            System.out.println("生成完毕！");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private void generateMapperFile(Map<String,Object> dataMap) throws Exception{
        final String suffix = "Mapper.xml";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "Mapper.ftl";
        File mapperFile = new File(path);
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    private void generateModelFile(Map<String,Object> dataMap) throws Exception{
        final String suffix = ".java";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "Model.ftl";
        File mapperFile = new File(path);
        generateFileByTemplate(templateName,mapperFile,dataMap);

    }

    private void generateControllerFile() throws Exception{
        final String suffix = "Controller.java";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "Controller.ftl";
        File mapperFile = new File(path);
        Map<String,Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    private void generateServiceImplFile() throws Exception{
        final String suffix = "ServiceImpl.java";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "Service.ftl";
        File mapperFile = new File(path);
        Map<String,Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    private void generateServiceInterfaceFile() throws Exception{
        final String suffix = "Service.java";
        final String path = diskPath  + changeTableName + suffix;
        final String templateName = "Interface.ftl";
        File mapperFile = new File(path);
        Map<String,Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    private void generateDaoFile() throws Exception{
        final String suffix = "Mapper.java";
        final String path = diskPath + changeTableName + suffix;
        final String templateName = "DAO.ftl";
        File mapperFile = new File(path);
        Map<String,Object> dataMap = new HashMap<>();
        generateFileByTemplate(templateName,mapperFile,dataMap);

    }


    private void generateFileByTemplate(final String templateName,File file,Map<String,Object> dataMap) throws Exception{
        Template template = FreeMarkerTemplateUtils.getTemplate(templateName);
        FileOutputStream fos = new FileOutputStream(file);
        dataMap.put("codeConstantsPath",codeConstantsPath);
        dataMap.put("idGenPath",idGenPath);
        dataMap.put("responseResultPath",responseResultPath);
        dataMap.put("table_name_small",tableName);
        dataMap.put("table_name",changeTableName);
        dataMap.put("author",AUTHOR);
        dataMap.put("date",CURRENT_DATE);
        dataMap.put("package_name",packageName);
        dataMap.put("primaryKey",primaryKey);
        dataMap.put("changePrimaryKey",replaceUnderLineAndUpperCase(primaryKey));
        dataMap.put("table_annotation",tableAnnotation);
        Writer out = new BufferedWriter(new OutputStreamWriter(fos, "utf-8"),10240);
        template.process(dataMap,out);
    }

    //将表名称装换成驼峰表示
    public String replaceUnderLineAndUpperCase(String str){
        StringBuffer sb = new StringBuffer();
        sb.append(str);
        int count = sb.indexOf("_");
        while(count!=0){
            int num = sb.indexOf("_",count);
            count = num + 1;
            if(num != -1){
                char ss = sb.charAt(count);
                char ia = (char) (ss - 32);
                sb.replace(count , count + 1,ia + "");
            }
        }
        String result = sb.toString().replaceAll("_","");
        return StringUtils.capitalize(result);
    }

    public String dateTransfer(){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return  dateFormat.format(new Date());
    }

    public static String getProjectPath() {
        try {
            File directory = new File("");//参数为空
            String courseFile = directory.getCanonicalPath();//标准的路径
            String path =directory.getAbsolutePath();//绝对路径
            return path;
        } catch (Exception e) {
            System.out.println("获取路径失败。");
            e.printStackTrace();
        }
        return "路径错了，自己改下代码哈！";
    }

}