package ${package_name}.model;
import lombok.Data;
<#list model_column as model>
    <#if model.columnType = 'TIMESTAMP' || model.columnType = 'DATETIME' >
import java.util.Date;
    </#if>
</#list>

/**
* 描述：${table_annotation}模型
* @author ${author}
* @date ${date}
*/
@Data
public class ${table_name} {
    /**
    *${primaryKey}
    */
        <#if (primaryKey??)>
     private Long ${primaryKey?uncap_first};
        </#if>
<#if model_column?exists>
    <#list model_column as model>
    /**
    *${model.columnComment!}
    */
        <#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT')>
    private String ${model.changeColumnName?uncap_first};
        </#if>
        <#if model.columnType = 'TIMESTAMP' || model.columnType = 'DATETIME'>
    private Date ${model.changeColumnName?uncap_first};
        </#if>
        <#if model.columnType = 'BIGINT' || model.columnType = 'INT'>
    private Long ${model.changeColumnName?uncap_first};
        </#if>
        <#if model.columnType = 'DECIMAL' >
    private BigDecimal ${model.changeColumnName?uncap_first};
        </#if>
        <#if model.columnType = 'BIT' >
    private Boolean ${model.changeColumnName?uncap_first};
        </#if>
    </#list>
</#if>

}