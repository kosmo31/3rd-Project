package com.cafe24.ourplanners.member.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.cafe24.ourplanners.MainController;
import com.cafe24.ourplanners.member.service.MemberService;

@RestController
public class MemberRestController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	@Inject
	private MemberService service;
	
	@RequestMapping(value="/jsontest", method= RequestMethod.GET)
	  public HashMap<String, Object> jsonTest() {
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      map.put("name", "박세창");
	      return map;
	  }
	
	@RequestMapping(value="/json/id_check",method= RequestMethod.GET)
	  public HashMap<String, Object> idCheck(HttpServletRequest req) {
			
		String user_id = req.getParameter("user_id");
		
			
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      
	      map.put("result", "success");
	      
	      
	      map.put("result", "fail");
	      
	      return map;
	  }
	
	
}