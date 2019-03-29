package ${package_name}.service.impl;
import ${package_name}.domain.${table_name};
import ${package_name}.service.${table_name}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;
/**
* 描述：${table_annotation} 服务实现层
* @author ${author}
* @date ${date}
*/
@Service
public class ${table_name}ServiceImpl implements ${table_name}Service {

    @Autowired
    private ${table_name}Mapper ${table_name?uncap_first}Mapper;

   //新增${table_annotation}
    @Override
    public int insert(${table_name} ${table_name?uncap_first}){
		return ${table_name?uncap_first}Mapper.insert(${table_name?uncap_first});
    }

    //删除${table_annotation}
    @Override
    public int delete(Long id){
        return ${table_name?uncap_first}Mapper.delete(id);
    }

    //查找${table_annotation}
    @Override
    public ${table_name} findById(Long id){
        return ${table_name?uncap_first}Mapper.findById(id);
    }

    //更新${table_annotation}
    @Override
    public int update(${table_name} ${table_name?uncap_first}){
        return ${table_name?uncap_first}Mapper.update(${table_name?uncap_first});
    }

    //查询${table_annotation}列表
    @Override
    public List<${table_name}> list(Map<String,Object> paramMap){
        return ${table_name?uncap_first}Mapper.list(paramMap);
    }

}