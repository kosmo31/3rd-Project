package com.cafe24.ourplanners.search.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MutablePropertySources;
import org.springframework.core.io.support.ResourcePropertySource;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cafe24.ourplanners.board.domain.SubCategoryVO;
import com.cafe24.ourplanners.search.service.SearchService;
import com.cafe24.ourplanners.util.ServiceBoardCriteria;
import com.cafe24.ourplanners.util.SearchServiceBoardCriteria;

@RestController
public class SearchRestController {

	@Inject
	private SearchService service;

	// 핫 검색어 20개 가져오기(워드 클라우드)
	@RequestMapping(value = "/board/json/top_search_list.json")
	public HashMap<String, Object> getHotKeyWordList(HttpServletRequest req, Model model,
			@RequestParam(required = false, defaultValue = "1") Integer nowPage,
			@RequestParam(required = false, defaultValue = "") String board_type,
			@RequestParam(required = false, defaultValue = "") Integer category_srl,
			@RequestParam(required = false, defaultValue = "") Integer subcategory_srl,
			@RequestParam(required = false, defaultValue = "") String keyword) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		// 외부파일에서 페이지 설정값 가져오기(Environment 객체 사용)
		int pageSize = 5;
		int blockPage = 5;

		// 설정값으로 외부파일을 사용하기 위한 방법
		// 1) 스프링 컨텍스트 파일을 생성한다.
		ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();

		// 2)Environment 객체를 생성
		ConfigurableEnvironment env = ctx.getEnvironment();

		// 3)PropertySources를 가져옴
		MutablePropertySources propertySources = env.getPropertySources();

		try {
			// 4) 외부파일인 properties 파일을 가져와서 addLast로 추가한다
			propertySources.addLast(new ResourcePropertySource("classpath:Environment.properties"));
			// 5) getProperty로 해당 데이터를 읽어와서 변수에 저장한다.
			// 단, 반환 결과가 String 타입이므로 사용하려는 int타입으로 캐스팅 후 사용해야 한다.
			
			pageSize = Integer.parseInt(env.getProperty("board.pageSize"));
			blockPage = Integer.parseInt(env.getProperty("board.blockPage"));
		} catch (Exception e) {
			e.printStackTrace();
		}

		ctx.close();

		ServiceBoardCriteria cri = new ServiceBoardCriteria();

		cri.setBoard_type(board_type);
		if (category_srl != null)
			cri.setCategory_srl(category_srl);
		if (subcategory_srl != null)
			cri.setSubcategory_srl(subcategory_srl);
		cri.setNowPage(nowPage);
		cri.setPageSize(pageSize);
		cri.setBlockPage(blockPage);

		service.getHotKeyWordList(cri, map);

		return map;
	}

	// HOT 게시글 목록 가져오기
	@RequestMapping(value = "/board/json/hot_service_list.json")
	public HashMap<String, Object> getHotServiceList(HttpServletRequest req, Model model,
			@RequestParam(required = false, defaultValue = "1") Integer nowPage,

			@RequestParam(required = false) Integer category_srl,
			@RequestParam(required = false) Integer subcategory_srl,

			@RequestParam(required = false, defaultValue = "") String board_type,
			@RequestParam(required = false) Integer pageSize, 
			@RequestParam(required = false) Integer blockPage,
			@RequestParam(required = false, defaultValue = "") String keyword) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		// 2.외부파일에서 페이지 설정값 가져오기(Environment 객체 사용)

		if (pageSize == null || blockPage == null) {
			// 설정값으로 외부파일을 사용하기 위한 방법
			// 1) 스프링 컨텍스트 파일을 생성한다.
			ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();

			// 2)Environment 객체를 생성
			ConfigurableEnvironment env = ctx.getEnvironment();

			// 3)PropertySources를 가져옴
			MutablePropertySources propertySources = env.getPropertySources();

			try {
				// 4) 외부파일인 properties 파일을 가져와서 addLast로 추가한다
				propertySources.addLast(new ResourcePropertySource("classpath:Environment.properties"));
				// 5) getProperty로 해당 데이터를 읽어와서 변수에 저장한다.
				// 단, 반환 결과가 String 타입이므로 사용하려는 int타입으로 캐스팅 후 사용해야 한다.
				if(pageSize==null)
				pageSize = Integer.parseInt(env.getProperty("hotBoard.pageSize"));
				if(blockPage==null)
				blockPage = Integer.parseInt(env.getProperty("hotBoard.blockPage"));
			} catch (Exception e) {
				e.printStackTrace();
			}

			ctx.close();
		}

		SearchServiceBoardCriteria cri = new SearchServiceBoardCriteria();

		cri.setBoard_type(board_type);
		if (category_srl != null)
			cri.setCategory_srl(category_srl);
		if (subcategory_srl != null)
			cri.setSubcategory_srl(subcategory_srl);
		cri.setNowPage(nowPage);
		cri.setPageSize(pageSize);
		cri.setBlockPage(blockPage);

		service.getHotServiceList(cri, map);

		return map;
	}

	// 서비스 목록 가져오기 (검색기능 지원)

	@RequestMapping(value = "/board/json/subcategory_list.json")
	public HashMap<String, Object> getSubCategoryListSearch(HttpServletRequest req, Model model,
			@RequestParam(required = false) Integer category_srl,
			@RequestParam(required = false) Integer subcategory_srl,
			@RequestParam(required = false, defaultValue = "") String category_name , 
			@RequestParam(required = false, defaultValue = "") String subcategory_name , 
			@RequestParam(required = false, defaultValue = "") String keyword) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		SubCategoryVO vo = new SubCategoryVO();

		if (category_srl != null)
			vo.setCategory_srl(category_srl);
		if (subcategory_srl != null)
			vo.setSubcategory_srl(subcategory_srl);
		
		vo.setCategory_name(subcategory_name);
		vo.setSubcategory_name(subcategory_name);
		
		if (keyword != null && keyword.length() != 0) {
			vo.setSubcategory_name(keyword);
			vo.setCategory_name(keyword);
		}
		
		service.getSubCategoryListSearch(vo, map);

		return map;
	}

	// 서비스 게시판 내 검색하기 searchType 기능 추가
	@RequestMapping(value = "/board/json/service_list.json")
	public HashMap<String, Object> getServiceListSearch(HttpServletRequest req, Model model,
			@RequestParam(required = false, defaultValue = "1") Integer nowPage,

			@RequestParam(required = false) Integer category_srl,
			@RequestParam(required = false) Integer subcategory_srl,

			@RequestParam(required = false, defaultValue = "") String board_type,
			
			@RequestParam(required = false, defaultValue = "") String service_expired,
			@RequestParam(required = false, defaultValue = "") String user_id,
			
			
			@RequestParam(required = false) Integer pageSize, 
			@RequestParam(required = false) Integer blockPage,
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String keyword) {
			
		HashMap<String, Object> map = new HashMap<String, Object>();

		if (pageSize == null || blockPage == null) {
			ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();

			ConfigurableEnvironment env = ctx.getEnvironment();

			MutablePropertySources propertySources = env.getPropertySources();

			try {
				propertySources.addLast(new ResourcePropertySource("classpath:Environment.properties"));
				pageSize = Integer.parseInt(env.getProperty("board.pageSize"));
				blockPage = Integer.parseInt(env.getProperty("board.blockPage"));
			} catch (Exception e) {
				
				e.printStackTrace();
			}

			ctx.close();
		}

		SearchServiceBoardCriteria scri = new SearchServiceBoardCriteria();

		scri.setBoard_type(board_type);
		scri.setService_expired(service_expired);
		scri.setUser_id(user_id);
		
		if (category_srl != null)
			scri.setCategory_srl(category_srl);
		if (subcategory_srl != null)
			scri.setSubcategory_srl(subcategory_srl);
		scri.setNowPage(nowPage);
		scri.setPageSize(pageSize);
		scri.setBlockPage(blockPage);
		
		//if(searchType != null && searchType.length() != 0)
		scri.setSearchType(searchType);
		//if(keyword != null && keyword.length() != 0)
		scri.setKeyword(keyword);		
		
		service.getServiceListSearch(scri, map);

		return map;
	}
	
	

}
