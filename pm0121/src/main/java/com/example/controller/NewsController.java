package com.example.controller;

import com.example.common.Result;
import com.example.entity.News;
import com.example.service.impl.NewsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/news")
public class NewsController {
    @Autowired
    private NewsServiceImpl newsService;

    @GetMapping("/hot")
    public Result<List<News>> getHotNews() {
        return Result.success(newsService.getHotNews());
    }
}


