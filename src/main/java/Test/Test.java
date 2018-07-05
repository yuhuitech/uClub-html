package Test;

import model.*;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.InputStream;

public class Test {

    public String getDescription(){
        String resource = "mybatis.xml";
        //使用类加载器加载mybatis的配置文件（它也加载关联的映射文件）
        InputStream is = Test.class.getClassLoader().getResourceAsStream(resource);
        //构建sqlSession的工厂
        SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);

        SqlSession session = sessionFactory.openSession();
        String statement = "mapping.LoginMapping.loginResultMap";//映射sql的标识字符串
        //执行查询返回一个唯一user对象的sql
        Student student = session.selectOne(statement, 1);
        String result = student.getPassword();
        session.close();
        return result;
    }

    public static void main(String args[]){
        Test test = new Test();
        System.out.println(test.getDescription());
    }
}
