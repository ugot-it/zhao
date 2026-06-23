package com.entity.view;

import com.annotation.ColumnInfo;
import com.entity.GonggaoEntity;
import org.apache.commons.beanutils.BeanUtils;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;

/**
 * @author 朝
 * @ClassName: GonggaoView
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @date 2026-06-21  上午 2:28
 * @Version:
 */
public class GonggaoView  extends GonggaoEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    //当前表
    /**
     * 公告类型的值
     */
    @ColumnInfo(comment="公告类型的字典表值",type="varchar(200)")
    private String gonggaoValue;




    public GonggaoView() {

    }

    public GonggaoView(GonggaoEntity gonggaoEntity) {
        try {
            BeanUtils.copyProperties(this, gonggaoEntity);
        } catch (IllegalAccessException | InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }



    //当前表的
    /**
     * 获取： 公告类型的值
     */
    public String getGonggaoValue() {
        return gonggaoValue;
    }
    /**
     * 设置： 公告类型的值
     */
    public void setGonggaoValue(String gonggaoValue) {
        this.gonggaoValue = gonggaoValue;
    }




    @Override
    public String toString() {
        return "GonggaoView{" +
                ", gonggaoValue=" + gonggaoValue +
                "} " + super.toString();
    }
}
