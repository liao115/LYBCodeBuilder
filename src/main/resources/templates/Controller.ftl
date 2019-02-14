package ${package_name}.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.stereotype.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import ${package_name}.service.${table_name}Service;
import ${package_name}.domain.${table_name};
import ${codeConstantsPath};
import ${idGenPath};
import ${responseResultPath};

/**
* 描述：${table_annotation} 控制层
* @author ${author}
* @date ${date}
*/
@Controller
public class ${table_name}Controller {

    private static final Logger logger = LoggerFactory.getLogger(${table_name}Controller.class);

    private ${table_name}Service ${table_name?uncap_first}Service;

    /**
    * 描述：新增${table_annotation}
    * @param ${table_name?uncap_first}
    */
    @RequestMapping(value = "add", method = RequestMethod.POST)
    @ResponseBody
    public ResponseResult add(${table_name} ${table_name?uncap_first}){
        ResponseResult result = new ResponseResult();
        try {
            ${table_name?uncap_first}.setId(IdGen.get().nextId());
            ${table_name?uncap_first}Service.insert(${table_name?uncap_first});
            return result;
        } catch (Exception e) {
            logger.error("${table_name} add error:[]",e);
            return new ResponseResult(CodeConstants.system_error.getCode(),CodeConstants.system_error.getMsg());
        }
    }

    /**
    * 描述：删除${table_annotation}
    * @param id
    */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    public ResponseResult delete(Long id){
        ResponseResult result = new ResponseResult();
        try {
            ${table_name?uncap_first}Service.delete(id);
            return result;
        } catch (Exception e) {
            logger.error("${table_name} delete error:[]",e);
            return new ResponseResult(CodeConstants.system_error.getCode(),CodeConstants.system_error.getMsg());
        }
    }

    /**
    * 描述：查找${table_annotation}
    * @param id
    */
    @RequestMapping(value = "findById", method = RequestMethod.POST)
    @ResponseBody
    public ResponseResult findById(Long id){
        ResponseResult result = new ResponseResult();
        try {
            ${table_name?uncap_first}Service.findById(id);
            return result;
        } catch (Exception e) {
            logger.error("${table_name} findById error:[]",e);
            return new ResponseResult(CodeConstants.system_error.getCode(),CodeConstants.system_error.getMsg());
        }
    }

    /**
    * 描述：更新${table_annotation}
    * @param ${table_name?uncap_first}
    */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    public ResponseResult update(${table_name} ${table_name?uncap_first}){
        ResponseResult result = new ResponseResult();
        try {
            ${table_name?uncap_first}Service.update(${table_name?uncap_first});
            return result;
        } catch (Exception e) {
            logger.error("${table_name} update error:[]",e);
            return new ResponseResult(CodeConstants.system_error.getCode(),CodeConstants.system_error.getMsg());
        }
    }

    /**
    * 描述：查询${table_annotation}列表
    */
    @RequestMapping(value = "list", method = RequestMethod.POST)
    @ResponseBody
    public ResponseResult list(){
        ResponseResult result = new ResponseResult();
        try {
            Map<String,Object> paramMap = new HashMap<String,Object>();
            List<${table_name}> list = ${table_name?uncap_first}Service.list(paramMap);
            return result.setData(list);
        } catch (Exception e) {
            logger.error("${table_name} list error:[]",e);
            return new ResponseResult(CodeConstants.system_error.getCode(),CodeConstants.system_error.getMsg());
        }
    }

}