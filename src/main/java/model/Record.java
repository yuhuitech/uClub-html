package model;

import Test.Test;
import operations.ClubOperations;
import operations.DAO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.InputStream;
import java.util.*;


import static java.lang.System.out;

public class Record
{
    private int AcNo;
    private int StuNo;
    private int times;
    private int type;
    public static double Pi = 3.14;
    private List<Integer> my_join_activity;

    public int getTimes()
    {
        return times;
    }

    public void setTimes(int times)
    {
        this.times = times;
    }

    public Record()
    {
        this.type = 0; //初始值type为0，代表是club的记录
    }

    public int getAcNo()
    {
        return AcNo;
    }

    public void setAcNo(int acNo)
    {
        AcNo = acNo;
    }

    public int getStuNo()
    {
        return StuNo;
    }

    public void setStuNo(int stuNo)
    {
        StuNo = stuNo;
    }


    public int getType()
    {
        return type;
    }

    public void setType(int type)
    {
        this.type = type;
    }

    //转换类型方法（是社团还是活动的记录）
    public void changeType()
    {
        if (this.type == 0) this.type = 1;
        else this.type = 0;
    }

    public void print()
    {
        out.println("学号：" + this.StuNo);
        out.println("活动或社团号" + this.AcNo);
        out.println("浏览次数" + this.times);
    }

    //抽象提取出通过标签获取总数（涉及到的总活动数或者总学生人数）
    private List<Integer> getSumbyTag(List<Record> joinAcitiveRecord, String tag)
    {
        List<Integer> result = new ArrayList<>();
        for (Record record : joinAcitiveRecord)
        {
            if (tag.equals("activity"))
            {
                if (result.contains(record.AcNo))
                {
                    continue;
                }
                else result.add(record.AcNo);
            }
            else if (tag.equals("student"))
            {
                if (result.contains(record.StuNo))
                {
                    continue;
                }
                else result.add(record.StuNo);
            }
        }
        return result;
    }

    //抽象提取出获得Map表的方法，每个学生对应的活动或是每个活动对应的学生
    private Map<Integer, List<Integer>> getMapByTag(List<Record> joinAcitiveRecord, List<Integer> list, String tag)
    {
        //首先获取各个活动被参加的学生矩阵，键值是活动号，对象是学号集合
        Map<Integer, List<Integer>> result = new HashMap<Integer, List<Integer>>();
        //先创建所有需要的数组
        ArrayList<ArrayList<Integer>> listSum1 = new ArrayList<ArrayList<Integer>>();
        for (int i : list)
        {
            listSum1.add(new ArrayList<Integer>());
        }
        //做计数变量取list中的list数组
        int k = 0;

        //两重循环得到key为活动号，value为参加活动的学生号数组
        for (int i : list)
        {
            List<Integer> numAll = listSum1.get(k);
            for (Record record : joinAcitiveRecord)
            {
                if (tag.equals("activity"))
                {
                    if (record.getAcNo() == i) numAll.add(record.getStuNo());
                }
                else if (tag.equals("student"))
                {
                    if (record.getStuNo() == i) numAll.add(record.getAcNo());
                }
            }
            result.put(i, numAll);
            k++;
        }
        return result;
    }

    //通过算好的学生对应活动表获取活动间的公共人数
    private Map<Integer, Map<Integer, Integer>> getCommonNum(Map<Integer, List<Integer>> stu_Join_Active)
    {
        Map<Integer, Map<Integer, Integer>> commonNum = new HashMap<>();
        List<Map<Integer, Integer>> mapList = new ArrayList<>();
        Iterator iter = stu_Join_Active.entrySet().iterator();
        int k = 0;//临时计数变量，存放value中的map
        while (iter.hasNext())
        {
            Map.Entry entry = (Map.Entry) iter.next();
            Integer key = (Integer) entry.getKey();
            List<Integer> val = (List<Integer>) entry.getValue();
            for (int i : val)
            {
                mapList.add(new HashMap<>());
                Map<Integer, Integer> temp = mapList.get(k);
                k++;
                for (int m : val)
                {
                    //如果i>=m说明走过，因为数据库是递增排列的，拉过来也是递增排列的，就直接进行下次循环
                    if (i == m) continue;
                    else if (commonNum.containsKey(i))
                    {
                        //如果没有这个活动间关系则置为1
                        if (commonNum.get(i).containsKey(m) == false)
                        {
                            commonNum.get(i).put(m, 1);
                        }
                        //存在这个活动间关系就+1
                        else commonNum.get(i).put(m, commonNum.get(i).get(m) + 1);
                    }
                    //连第一个活动节点都没有创建也置为1，下面再一并添加
                    else temp.put(m, 1);
                }
                //将map作为值的形式再添加到第一个map中
                if (!temp.isEmpty()) commonNum.put(i, temp);
            }
        }
        return commonNum;
    }

    private Map<Integer, Map<Integer, Double>> getSimilarByInfo(List<Integer> ActiveNo, Map<Integer, List<Integer>> active_Joined_Stu, Map<Integer, Map<Integer, Integer>> commonNum)
    {
        //下面利用协同过滤算法的相似度公式进行活动相似度计算，三个变量分别第一个活动人数，第二个活动人数，共同参加的活动人数
        int num1 = 0;
        int num2 = 0;
        int num3 = 0;
        Map<Integer, Map<Integer, Double>> simlarNum = new HashMap<>();
        for (int i : ActiveNo)
        {
            num1 = active_Joined_Stu.get(i).size();
            for (int m : ActiveNo)
            {
                num2 = active_Joined_Stu.get(m).size();
                //防止两个活动间并没有公共人数
                try
                {
                    num3 = commonNum.get(i).get(m);
                }
                catch (Exception e)
                {
                    num3 = 0;
                }
                //下面用公式进行计算
                double simlar = num3 / Math.sqrt(num1 * num2);
                //并存储
                if (!simlarNum.containsKey(i))
                {
                    Map<Integer, Double> temp = new HashMap<>();
                    temp.put(m, simlar);
                    simlarNum.put(i, temp);
                }
                else
                {
                    simlarNum.get(i).put(m, simlar);
                }
            }
        }
        return simlarNum;
    }

    //返回活动的相似性矩阵
    public Map<Integer, Map<Integer, Double>> getActiveSimilarList(List<Record> joinAcitiveRecord)
    {
        //创建结果矩阵
        Map<Integer, Map<Integer, Integer>> result = new HashMap<>();
        //首先把所有涉及到的活动都取出来
        List<Integer> ActiveNo = this.getSumbyTag(joinAcitiveRecord, "activity");
        List<Integer> StuNo = this.getSumbyTag(joinAcitiveRecord, "student");

        //首先获取各个活动被参加的学生矩阵，键值是活动号，对象是学号集合
        Map<Integer, List<Integer>> active_Joined_Stu = getMapByTag(joinAcitiveRecord, ActiveNo, "activity");
        Map<Integer, List<Integer>> stu_Join_Active = getMapByTag(joinAcitiveRecord, StuNo, "student");

        //首先做公共参加两个活动的人数统计
        Map<Integer, Map<Integer, Integer>> commonNum = getCommonNum(stu_Join_Active);

        //通过调用上面的函数直接生成最终的相似度~耶！
        Map<Integer, Map<Integer, Double>> simlarNum = getSimilarByInfo(ActiveNo, active_Joined_Stu, commonNum);

        return simlarNum;
    }

    //获取当前用户的参加活动数(根据用户号和所有活动记录)
    private List<Integer> getMyActive(int UserNo, List<Record> activeRecord)
    {
        //下面获取现在当前用户参加的活动数
        List<Integer> my_join_active = new ArrayList<>();
        for (Record record : activeRecord)
        {
            if (record.getStuNo() == UserNo)
            {
                my_join_active.add(record.getAcNo());
            }
        }
        return my_join_active;
    }

    private Map<Integer, Integer> getMySkinActive(int UserNo, List<Record> activeRecord)
    {
        Map<Integer, Integer> my_skin_active = new HashMap<>();
        for (Record record : activeRecord)
        {
            if (record.getStuNo() == UserNo)
            {
                my_skin_active.put(record.AcNo, record.times);
            }
        }
        return my_skin_active;
    }


    //获取最后的推荐值数组
    private Map<Integer, Double> getRecommendByJoin_Skin(Map<Integer, Integer> skin_time, List<Integer> my_join_active, Map<Integer, Map<Integer, Double>> SimliarMatrix)
    {
        Map<Integer, Double> result = new HashMap<>();
        //首先获取参加活动所贡献的推荐值,参加的爱好度设置为1，最终由爱好度乘以活动间的相似度
        for (int i : my_join_active)
        {
            Map<Integer, Double> map_i = SimliarMatrix.get(i);

            Iterator iter = map_i.entrySet().iterator();
            while (iter.hasNext())
            {
                Map.Entry entry = (Map.Entry) iter.next();
                Integer key = (Integer) entry.getKey();
                Double val = (Double) entry.getValue();
                if (!result.containsKey(key))
                {
                    result.put(key, val);
                }
                else
                {
                    result.put(key, val + result.get(key));
                }
            }
        }
        //接下来是浏览活动贡献的推荐值，浏览的爱好度为π/2*acrtanX（X为浏览次数）
        Map<Integer, Integer> map_i = skin_time;
        Iterator iter = map_i.entrySet().iterator();
        while (iter.hasNext())
        {
            Map.Entry entry = (Map.Entry) iter.next();
            Integer key = (Integer) entry.getKey();//活动号
            Integer val = (Integer) entry.getValue();//浏览次数

            Map<Integer, Double> map_key = SimliarMatrix.get(key);

            Iterator iter1 = map_key.entrySet().iterator();
            while (iter1.hasNext())
            {
                Map.Entry entry1 = (Map.Entry) iter1.next();
                Integer key1 = (Integer) entry1.getKey();
                Double val1 = (Double) entry1.getValue();
                if (!result.containsKey(key1))
                {
                    result.put(key1, 2 * Math.atan(val) * val1 / Pi);//无限接近于1但永远不超过1
                }
                else
                {
                    result.put(key1, 2 * Math.atan(val) * val1 / Pi + result.get(key1));
                }
            }

        }
        return result;
    }


    //获取各个活动对当前用户的推荐度
    public Map<Integer, Double> getRecommendNum(List<Record> activeRecord, List<Record> join_activeRecord, Map<Integer, Map<Integer, Double>> SimliarMatrix, int UserNo)
    {
        //结果map表
        Map<Integer, Double> result;
        //提取出的浏览次数
        Map<Integer, Integer> skin_time = getMySkinActive(UserNo, activeRecord);
        //提取出参加的活动
        List<Integer> my_join_active = getMyActive(UserNo, join_activeRecord);
        this.my_join_activity = my_join_active;
        //获取最终推荐度
        result = getRecommendByJoin_Skin(skin_time, my_join_active, SimliarMatrix);
        return result;
    }

    //获取最终的排序
    public List<Integer> getSort(Map<Integer, Double> recommendNum, int UserNo)
    {

        List<Integer> sortResult = new ArrayList<>();
        int size = recommendNum.size();
        for (int i = 0; i <size; i++)
        {
            Map<Integer, Double> map_i = recommendNum;
            Iterator iter = map_i.entrySet().iterator();
            //临时存储的最大值处理
            int max_key = 0;
            Double max_value = 0.0;
            while (iter.hasNext())
            {
                Map.Entry entry = (Map.Entry) iter.next();
                Integer key = (Integer) entry.getKey();//活动号
                Double val = (Double) entry.getValue();//推荐值
                if (val > max_value)
                {
                    max_key = key;
                    max_value = val;
                }
            }
            if(!this.my_join_activity.contains(max_key))   sortResult.add(max_key);
            recommendNum.remove(max_key);
        }
        return sortResult;
    }
}
