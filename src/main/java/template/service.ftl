package ${servicepackage};

/**
*
* @author 喻鑫
* @Date ${date}
* @Desc ${className}
*/
import java.util.List;
import ${pojopackage}.${className};

public interface I${className}Service {

	public void save${className?cap_first}(${className} t);

	public void delete${className?cap_first}(${className} t);
	
	public void delete${className?cap_first}ById(Integer id);

	public ${className} find${className?cap_first}ById(Integer id);

	public void update${className?cap_first}(${className} t);

	public List<${className}> queryForList(String hqlString, Object... values);
	
}
