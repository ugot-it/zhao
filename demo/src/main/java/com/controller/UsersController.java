
package com.controller;

import java.util.List;
import java.util.Arrays;
import java.util.Map;
import com.service.UsersService;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.entity.UsersEntity;
import com.service.TokenService;
import com.utils.R;

@RequestMapping("users")
@RestController
public class UsersController {

	@Autowired
	private UsersService usersService;

	@Autowired
	private TokenService tokenService;

	/**
	 * 登录
	 */
	@PostMapping(value = "/login")
	public R login(String username, String password, String captcha, HttpServletRequest request) {
        return null;
    }

	/**
	 * 注册
	 */
	//@IgnoreAuth
	@PostMapping(value = "/register")
	public R register(@RequestBody UsersEntity user) {
        return null;
    }

	/**
	 * 退出
	 */
	@GetMapping(value = "logout")
	public R logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return R.ok("退出成功");
	}

	/**
	 * 修改密码
	 */
	@GetMapping(value = "/updatePassword")
	public R updatePassword(String oldPassword, String newPassword, HttpServletRequest request) {
        return null;
    }


	//密码重置

	@RequestMapping(value = "/resetPass")
	public R resetPass(String username, HttpServletRequest request) {
        return null;
    }

	/**
	 * 列表
	 */
	@RequestMapping("/page")
	public R page(@RequestParam Map<String, Object> params, UsersEntity user) {
        return null;
    }

	/**
	 * 列表
	 */
	@RequestMapping("/list")
	public R list(UsersEntity user) {
        return null;
    }

	/**
	 * 信息
	 */
	@RequestMapping("/info/{id}")
	public R info(@PathVariable("id") String id) {

		return null;
	}

	/**
	 * 获取用户的session用户信息
	 */
	@RequestMapping("/session")
	public R getCurrUser(HttpServletRequest request) {

		return null;
	}

	/**
	 * 保存
	 */
	@PostMapping("/save")
	public R save(@RequestBody UsersEntity user) {

		return null;
	}

	/**
	 * 修改
	 */
	@RequestMapping("/update")
	public R update(@RequestBody UsersEntity user) {
//        ValidatorUtils.validateEntity(user);
		usersService.updateById(user);//全部更新
		return R.ok();
	}

	/**
	 * 删除
	 */
	@RequestMapping("/delete")
	public R delete(@RequestBody Long[] ids) {

		return null;
	}
}
