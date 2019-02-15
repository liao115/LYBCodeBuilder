<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${package_name}.mapper.${table_name}Mapper">

    <resultMap id="BaseResultMap" type="${package_name}.domain.${table_name}">
        <#if model_column?exists>
            <#list model_column as model>
                <#if (model.columnName = primaryKey)>
        <id column="${model.columnName}" property="${model.changeColumnName?uncap_first}"/>
                </#if>
                <#if (model.columnName != primaryKey)>
        <result column="${model.columnName}" property="${model.changeColumnName?uncap_first}"/>
                </#if>
            </#list>
        </#if>
    </resultMap>

    <sql id="table_name">
        `${table_name_small}`
    </sql>

    <sql id="all_column">
        <#if model_column?exists>
            <#list model_column as model>
                ${model.columnName}<#if model_has_next>,</#if>
            </#list>
        </#if>
    </sql>
    <sql id="all_property">
        <#if model_column?exists>
            <#list model_column as model>
                ${model.changeColumnName?uncap_first}<#if model_has_next>,</#if>
            </#list>
        </#if>
    </sql>


    <sql id="column_where">
        <#if model_column?exists>
            <#list model_column as model>
                <#if (model.columnType = 'VARCHAR' || model.columnType = 'TEXT')>
        <if test='${model.changeColumnName?uncap_first} != null and ${model.changeColumnName?uncap_first} != ""'>
            and ${model.columnName} = ${r'${'}${model.changeColumnName?uncap_first}${r'}'}
        </if>
                </#if>
                <#if (model.columnType != 'VARCHAR' && model.columnType != 'TEXT')>
        <if test='${model.changeColumnName?uncap_first} != null'>
            and ${model.columnName} = ${r'${'}${model.changeColumnName?uncap_first}${r'}'}
        </if>
                </#if>
            </#list>
        </#if>
    </sql>
ds
    <sql id="column_update">
        <#if model_column?exists>
            <#list model_column as model>
        <if test='${model.changeColumnName?uncap_first} != null'>
            ${model.columnName} = ${r'${'}${model.changeColumnName?uncap_first}${r'}'}<#if model_has_next>,</#if>
        </if>
            </#list>
        </#if>
    </sql>

    <insert id="insert">
        INSERT INTO
        <include refid="table_name"/>
        (
        <include refid="all_column" />
        )
        VALUES (
        <include refid="all_property"/>
        )
    </insert>

    <delete id="delete">
        delete from
        <include refid="table_name"/>
        where ${primaryKey} = ${r'${'}${changePrimaryKey?uncap_first}${r'}'}
    </delete>

    <update id="update">
        update
        <include refid="table_name"/>
        set
        <include refid="column_update"/>
        where ${primaryKey} = ${r'${'}${changePrimaryKey?uncap_first}${r'}'}
    </update>

    <select id="findById" resultMap="BaseResultMap">
        select
        <include refid="all_column" />
        from
        <include refid="table_name"/>
        where ${primaryKey} = ${r'${'}${changePrimaryKey?uncap_first}${r'}'}
    </select>

    <select id="list" resultMap="BaseResultMap">
        SELECT
        <include refid="all_column"/>
        from
        <include refid="table_name"/>
        where
        <include refid="column_where"/>
    </select>

</mapper>