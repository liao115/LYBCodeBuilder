package ${package_name}.mapper;
import ${package_name}.domain.${table_name};
import org.springframework.stereotype.Component;
import java.util.List;
import java.util.Map;
/**
* 描述：${table_annotation} 服务实现层接口
* @author ${author}
* @date ${date}
*/
@Component
public interface ${table_name}Mapper {
    //新增${table_annotation}
    int insert(${table_name} ${table_name?uncap_first});

    //删除${table_annotation}
    int delete(Long id);

    //查找${table_annotation}
    ${table_name} findById(Long id);

    //更新${table_annotation}
    int update(${table_name} ${table_name?uncap_first});

    //查询${table_annotation}列表
    List<${table_name}> list(Map<String,Object> paramMap);

}