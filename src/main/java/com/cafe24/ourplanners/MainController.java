package com.cafe24.ourplanners;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafe24.ourplanners.member.domain.MemberVO;
import com.cafe24.ourplanners.mypage.service.MyPageService;

@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Inject
	private MyPageService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("메인 페이지. 언어 {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
	@RequestMapping(value = "policy/privacy", method = RequestMethod.GET)
	public String privacy(Model model) {
		logger.info("개인정보 취급방침 페이지");
			
		return "policy/policy_privacy";
	}
	
	@RequestMapping(value = "policy/provision", method = RequestMethod.GET)
	public String provision(Model model) {
		logger.info("사이트 이용약관 페이지");
			
		return "policy/policy_provision";
	}
	
	@RequestMapping(value = "about/ourplanners", method = RequestMethod.GET)
	public String aboutOurPlanners(Model model) {
		logger.info("Our Planners 팀 소개");
			
		return "about/about_ourplanners";
	}
	
	@RequestMapping(value = "about/service", method = RequestMethod.GET)
	public String aboutService(Model model,HttpServletRequest req) {
		logger.info("서비스 소개 페이지");
		
	
		service.getServiceData(model,req);
		
		
		return "about/about_service";
	}
	
	@RequestMapping(value = "about/recruit", method = RequestMethod.GET)
	public String aboutRecruit(Model model) {
		logger.info("인재채용 페이지");
			
		return "about/about_recruit";
	}
	
	@RequestMapping(value = "about/sitemap", method = RequestMethod.GET)
	public String aboutSitemap(Model model) {
		logger.info("사이트맵 페이지");
			
		return "about/about_sitemap";
	}	
	
}
