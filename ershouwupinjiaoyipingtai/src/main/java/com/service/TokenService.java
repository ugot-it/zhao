package com.service;

import com.entity.TokenEntity;

public interface TokenService extends IService<TokenEntity> {
 	PageUtils queryPage(Map<String, Object> params);
    
   	List<TokenEntity> selectListView(Wrapper<TokenEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<TokenEntity> wrapper);
	
   	String generateToken(Integer userid,String username,String tableName, String role);
   	
   	TokenEntity getTokenEntity(String token);
}
