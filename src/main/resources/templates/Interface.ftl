package ${package_name}.service;
import ${package_name}.domain.${table_name};
import java.util.Map;
import java.util.List;
/**
* 描述：${table_annotation} 服务实现层接口
* @author ${author}
* @date ${date}
*/
public interface ${table_name}Service {

    //新增${table_annotation}
    public int insert(${table_name} ${table_name?uncap_first});

    //删除${table_annotation}
    public int delete(Long id);

    //查找${table_annotation}
    public ${table_name} findById(Long id);

    //更新${table_annotation}
    public int update(${table_name} ${table_name?uncap_first});

    //查询${table_annotation}列表
    public List<${table_name}> list(Map<String,Object> paramMap);

}