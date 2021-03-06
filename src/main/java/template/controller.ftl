package ${controllerpackage};

/**
*
* @author 喻鑫
* @Date ${date}
* @Desc ${className}
*/
public
import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.MediaType;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import ${basepackage}.common.MessageBean;
import ${basepackage}.common.RestfulContants;
import ${basepackage}.common.ShortMsg;
import ${pojopackage}.${className};
import ${servicepackage}.I${className}Service;

@RestController
public class ${className}Controller {
	
	private Logger logger = LoggerFactory.getLogger(${className}Controller.class);
	
	@Autowired
	private I${className}Service ${className?uncap_first}Service;
	
	/**
	 * 新增${className}
	 * ${className}/add
	 * 
	 * @param body
	 * 
	 * @return
	 */

	@RequestMapping(value = "${className?lower_case}/add", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String add(@RequestBody String body) {
		String code = ShortMsg.ERROR;
		${className} ${className?uncap_first} = null;
		if(!StringUtils.isEmpty(body)){
			try {
				ObjectMapper mapper = new ObjectMapper();
				${className?uncap_first} = mapper.readValue(body, ${className}.class);
				if (${className?uncap_first} != null) {
					${className?uncap_first}Service.save${className}(${className?uncap_first});
					code = ShortMsg.SUCCESS;
				}
			} catch (JsonParseException e) {
				logger.error(e.getMessage());
				e.printStackTrace();
			} catch (JsonMappingException e) {
				logger.error(e.getMessage());
				e.printStackTrace();
			} catch (IOException e) {
				logger.error(e.getMessage());
				e.printStackTrace();
			}
		}		
		MessageBean mb = new MessageBean(code, ShortMsg.getValue(code));
		String result = getJson(mb);
		return result;
	}

	/**
	 * 根据ID删除${className}
	 * ${className}/delete/xxx
	 * @param id
	 * xxx
	 * @return
	 */
	@RequestMapping(value ="${className?lower_case}/delete/{id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String delete(@PathVariable Integer id) {
		String code = ShortMsg.ERROR;
		${className?uncap_first}Service.delete${className}ById(id);
		code = ShortMsg.SUCCESS;
		MessageBean mb = new MessageBean(code, ShortMsg.getValue(code));
		String result = getJson(mb);
		return result;
	}
	
	/**
	 * 根据ID查询${className}
	 * ${className}/findById
	 * @param id
	 * xxx
	 * @return
	 */
	@RequestMapping(value ="${className?lower_case}/findById/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String findById(@PathVariable Integer id) {
		String result = null;
		${className} ${className?uncap_first} = ${className?uncap_first}Service.find${className}ById(id);
		try {
			ObjectMapper mapper = new ObjectMapper();
			result = mapper.writeValueAsString(${className?uncap_first});
		} catch (JsonProcessingException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 更新${className}
	 */
	@RequestMapping(value = "${className?lower_case}/update", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String put(@RequestBody String body) {
		String code = ShortMsg.ERROR;
		${className} ${className?uncap_first} = null;
		if(!StringUtils.isEmpty(body)){
			try {
				ObjectMapper mapper = new ObjectMapper();
				${className?uncap_first} = mapper.readValue(body, ${className}.class);
				if(${className?uncap_first} != null && ${className?uncap_first}.getId() != null){
					${className?uncap_first}Service.update${className}(${className?uncap_first});
					code = ShortMsg.SUCCESS;
				}
			} catch (JsonParseException e) {
				logger.error(e.getMessage());
				e.printStackTrace();
			} catch (JsonMappingException e) {
				logger.error(e.getMessage());
				e.printStackTrace();
			} catch (IOException e) {
				logger.error(e.getMessage());
				e.printStackTrace();
			}
		}
		MessageBean mb = new MessageBean(code, ShortMsg.getValue(code));
		String result = getJson(mb);
		return result;
	}

	/**
	 * 获取所有${className}
	 * ${className}/getList
	 * @return
	 */
	@RequestMapping(value = "${className?lower_case}/getList", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String getList() {
		String result = ShortMsg.ERROR;
		List<${className}> list = ${className?uncap_first}Service.queryForList("from ${className}", new Object[]{});
		try {
			ObjectMapper mapper = new ObjectMapper();
			result = mapper.writeValueAsString(list);
		} catch (JsonParseException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		} catch (JsonMappingException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		if(ShortMsg.ERROR.equals(result)){
			MessageBean mb = new MessageBean(result, ShortMsg.getValue(result));
			String ret = getJson(mb);
			return ret;
		}
		return result;
	}
	

	private String getJson(Object val) {
		ObjectMapper mapper = new ObjectMapper();
		String result = null;
		try {
			result = mapper.writeValueAsString(val);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return result;
	}

}