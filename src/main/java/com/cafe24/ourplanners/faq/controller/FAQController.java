package com.cafe24.ourplanners.faq.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MutablePropertySources;
import org.springframework.core.io.support.ResourcePropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.ourplanners.faq.domain.FAQVO;
import com.cafe24.ourplanners.faq.service.FAQService;
import com.cafe24.ourplanners.member.domain.MemberVO;
import com.cafe24.ourplanners.util.SearchFAQCriteria;

@Controller
public class FAQController {

	@Inject
	private FAQService service;

	// faq 게시판 JSON
	@ResponseBody
	@RequestMapping(value = "/customercenter/faq/json/faq_list.json")
	public HashMap<String, Object> getFAQListJson(HttpServletRequest req, Model model,
			@RequestParam(required = false, defaultValue = "1") Integer nowPage,

			@RequestParam(required = false) Integer category_srl, @RequestParam(required = false) Integer service_srl,

			@RequestParam(required = false) Integer pageSize, @RequestParam(required = false) Integer blockPage,
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String keyword) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		if (pageSize == null || blockPage == null) {
			ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();

			ConfigurableEnvironment env = ctx.getEnvironment();

			MutablePropertySources propertySources = env.getPropertySources();

			try {
				propertySources.addLast(new ResourcePropertySource("classpath:Environment.properties"));
				if (pageSize == null)
					pageSize = Integer.parseInt(env.getProperty("faq.pageSize"));
				if (blockPage == null)
					blockPage = Integer.parseInt(env.getProperty("faq.blockPage"));
			} catch (Exception e) {

				e.printStackTrace();
			}

			ctx.close();
		}

		SearchFAQCriteria scri = new SearchFAQCriteria();

		if (category_srl != null) {
			scri.setCategory_srl(category_srl);
			System.out.println("category_srl:" + category_srl);
		}

		if (service_srl != null) {
			System.out.println("service_srl:" + service_srl);
			scri.setService_srl(service_srl);
		}
		scri.setNowPage(nowPage);
		scri.setPageSize(pageSize);
		scri.setBlockPage(blockPage);

		System.out.println("nowPage:" + nowPage);

		if (searchType != null && searchType.length() != 0)
			scri.setSearchType(searchType);
		if (keyword != null && keyword.length() != 0)
			scri.setKeyword(keyword);

		service.getFAQListJson(scri, map);

		return map;
	}

	// 글 상세 보기
	@RequestMapping(value = "/customercenter/faq/{faq_srl}", method = RequestMethod.GET)
	public String viewFAQ(@PathVariable Integer faq_srl, Model model) {
		model.addAttribute("faq_srl", faq_srl);
		return "customercenter/faq/customercenter_faq_view";
	}

	// 리스트 보기
	@RequestMapping(value = "/customercenter/faq", method = RequestMethod.GET)
	public String listFAQ(Model model) {

		return "customercenter/faq/customercenter_faq_list";
	}

	// 글쓰기 폼 가져오기
	@RequestMapping(value = "/customercenter/faq/new", method = RequestMethod.GET)
	public String writeFormFAQ() {
		return "customercenter/faq/customercenter_faq_write";
	}

	// 글쓰기 처리
	@ResponseBody
	@RequestMapping(value = "/customercenter/faq", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> writeActionFAQ(HttpServletRequest req, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		ResponseEntity<Map<String, Object>> entity = null;

		try {
			if (session.getAttribute("loginUserInfo") == null) {
				map.put("result", "fail");
				map.put("errorMsg", "isNotLogin");

			}

			if (!((MemberVO) session.getAttribute("loginUserInfo")).getIs_admin().equalsIgnoreCase("Y")) {
				map.put("result", "fail");
				map.put("errorMsg", "isNotAdmin");

			}

			int result = service.writeFAQ(req, map);

			if (result <= 0) {
				map.put("result", "fail");
				map.put("errorMsg", "sqlError");
			} else {
				map.put("result", "success");
			}

		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
			map.put("errorMsg", e.getMessage());
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		if (((String) map.get("result")).equals("fail")) {
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		} else if (((String) map.get("result")).equals("success")) {
			System.out.println("글작성 성공");
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}
		return entity;
	}

	// 글수정 폼
	@RequestMapping(value = "/customercenter/faq/{faq_srl}/edit", method = RequestMethod.GET)
	public String modifyFormFAQ(@PathVariable Integer faq_srl, Model model) {
		// model.addAttribute("faq_srl",faq_srl);
		service.readFAQ(faq_srl, model);
		return "customercenter/faq/customercenter_faq_modify";
	}

	// 글수정 처리
	@ResponseBody
	@RequestMapping(value = "/customercenter/faq/{faq_srl}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<Map<String, Object>> modifyActionFAQ(@PathVariable Integer faq_srl, HttpServletRequest req,
			HttpSession session, @RequestBody FAQVO vo) {

		vo.setFaq_srl(faq_srl);
		/*
		 * System.out.println("service_srl:"+vo.getService_srl());
		 * System.out.println("faq_srl:"+faq_srl);
		 * System.out.println("category_srl:"+vo.getCategory_srl());
		 * System.out.println("title:"+vo.getTitle());
		 * System.out.println("contents:"+vo.getContents());
		 */
		Map<String, Object> map = new HashMap<String, Object>();
		ResponseEntity<Map<String, Object>> entity = null;

		try {
			if (session.getAttribute("loginUserInfo") == null) {
				map.put("result", "fail");
				map.put("errorMsg", "isNotLogin");

			} else {

				if (!((MemberVO) session.getAttribute("loginUserInfo")).getIs_admin().equalsIgnoreCase("Y")) {
					map.put("result", "fail");
					map.put("errorMsg", "isNotAdmin");

				} else {

					int result = service.modifyFAQ(vo);

					if (result <= 0) {
						map.put("result", "fail");
						map.put("errorMsg", "sqlError");
					} else {
						map.put("result", "success");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errorMsg", e.getMessage());
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		if (((String) map.get("result")).equals("fail")) {
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		} else if (((String) map.get("result")).equals("success")) {
			System.out.println("글 수정 성공");
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}

		return entity;
	}

	// 해당 글 삭제
	@ResponseBody
	@RequestMapping(value = "/customercenter/faq/{faq_srl}", method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteFAQ(HttpServletRequest req, HttpSession session, Model model,
			@PathVariable Integer faq_srl) {

		Map<String, Object> map = new HashMap<String, Object>();
		ResponseEntity<Map<String, Object>> entity = null;

		try {
			if (session.getAttribute("loginUserInfo") == null) {
				map.put("result", "fail");
				map.put("errorMsg", "isNotLogin");
			} else {

				if (!((MemberVO) session.getAttribute("loginUserInfo")).getIs_admin().equalsIgnoreCase("Y")) {
					map.put("result", "fail");
					map.put("errorMsg", "isNotAdmin");
				} else {

					int result = service.deleteFAQ(faq_srl);

					if (result <= 0) {
						map.put("result", "fail");
						map.put("errorMsg", "sqlError");
					} else {
						map.put("result", "success");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errorMsg", e.getMessage());
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		if (((String) map.get("result")).equals("fail")) {
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		} else if (((String) map.get("result")).equals("success")) {
			System.out.println("글 삭제 성공");
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}
		return entity;
	}
}
