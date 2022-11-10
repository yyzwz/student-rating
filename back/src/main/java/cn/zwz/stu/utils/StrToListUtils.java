package cn.zwz.stu.utils;

import cn.zwz.data.utils.ZwzNullUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 字符串工具类
 * @author 郑为中
 */
public class StrToListUtils {

    public static List<String> getListByStr(String str) {
        List<String> ans = new ArrayList<>();
        if(ZwzNullUtils.isNull(str)) {
            return ans;
        }
        String[] split = str.split(",");
        for (String s : split) {
            ans.add(s);
        }
        return ans;
    }
}
