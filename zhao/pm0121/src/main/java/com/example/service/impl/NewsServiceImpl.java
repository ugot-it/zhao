package com.example.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.entity.News;
import com.example.mapper.NewsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.service.NewsService;

import java.util.List;

@Service // 标记为Spring服务组件
public class NewsServiceImpl implements NewsService { // 实现接口

    @Autowired
    private NewsMapper newsMapper;

    @Override
    public List<News> getHotNews() {  return newsMapper.selectList(
                new LambdaQueryWrapper<News>()
                        .eq(News::getIsActive, 1)
                        .orderByDesc(News::getCreateTime)
        );
    }
}