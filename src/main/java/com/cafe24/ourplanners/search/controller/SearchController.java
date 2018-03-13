package com.cafe24.ourplanners.search.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.cafe24.ourplanners.board.domain.BoardVO;
import com.cafe24.ourplanners.member.domain.MemberVO;
import com.cafe24.ourplanners.search.service.SearchService;

@Controller
public class SearchController {
	@Inject
	private SearchService service;
	
	//메인 검색폼에서 검색시 그외 검색은 searchrestcontroller내에 getServiceListSearch 메소드를 이용하여 ajax처리
	@RequestMapping(value="/board/search", method = RequestMethod.GET)
	public String searchBoard(Model model,HttpServletRequest req, @RequestParam(required = false, defaultValue = "1") Integer nowPage,

			@RequestParam(required = false) Integer category_srl,
			@RequestParam(required = false) Integer subcategory_srl,

			@RequestParam(required = false, defaultValue = "") String board_type,
			@RequestParam(required = false) Integer pageSize, @RequestParam(required = false) Integer blockPage,
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String keyword) { 
		
		//RedirectAttributes rediAttr
		//rediAttr.addFlashAttribute(arg0, arg1)
		//return "redirect:/board/search/board_search_list";
		//http://localhost:8080/ourplanners/board/search?board_type=E&keyword=ㄱㄱ
		//http://localhost:8080/ourplanners/board/json/service_list.json?board_type=E&pageSize=5&blockPage=1&keyword=&searchType=tc
		
		model.addAttribute("board_type",board_type);
		if (category_srl != null)
			model.addAttribute("category_srl",category_srl);
		if (subcategory_srl != null)
			model.addAttribute("subcategory_srl",subcategory_srl);
		if(searchType != null && searchType.length() != 0)
			model.addAttribute("searchType",searchType);
		if(keyword != null && keyword.length() != 0)
			model.addAttribute("keyword",keyword);

		return "board/search/board_search_list";
	}
	
	
	//리스트(O)
	@RequestMapping(value="/board/service", method = RequestMethod.GET)
	public String mainBoard(Model model,HttpServletRequest req, @RequestParam(required = false, defaultValue = "1") Integer nowPage,

			@RequestParam(required = false) Integer category_srl,
			@RequestParam(required = false) Integer subcategory_srl,

			@RequestParam(required = false, defaultValue = "") String board_type,
			@RequestParam(required = false) Integer pageSize, @RequestParam(required = false) Integer blockPage,
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String keyword) { 
		
		//RedirectAttributes rediAttr
		//rediAttr.addFlashAttribute(arg0, arg1)
		//return "redirect:/board/search/board_search_list";
		//http://localhost:8080/ourplanners/board/search?board_type=E&keyword=ㄱㄱ
		//http://localhost:8080/ourplanners/board/json/service_list.json?board_type=E&pageSize=5&blockPage=1&keyword=&searchType=tc
		
		model.addAttribute("board_type",board_type);
		if (category_srl != null)
			model.addAttribute("category_srl",category_srl);
		if (subcategory_srl != null)
			model.addAttribute("subcategory_srl",subcategory_srl);
		if(searchType != null && searchType.length() != 0)
			model.addAttribute("searchType",searchType);
		if(keyword != null && keyword.length() != 0)
			model.addAttribute("keyword",keyword);

		return "board/service/board_service_list";
	}
	
	// 글 상세보기 AJAX 부분 가져오기
	@RequestMapping(value = "/board/service/{board_srl}/little", method = RequestMethod.GET)
	public String readBoardJson(@PathVariable Integer board_srl, Model model) {
		
		BoardVO vo = null;
		try {
			vo = service.readBoardJson(board_srl);
			
			//줄바꿈
			vo.setContents(vo.getContents().replace("\r\n", "<br/>"));
			
			//조회수 증가
			service.visitCount(board_srl);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("view", vo);
		
		return "board/service/board_service_view_little";
	}
	
	// 글 상세 보기
	@RequestMapping(value = "/board/service/{board_srl}", method = RequestMethod.GET)
	public String readBoard(@PathVariable Integer board_srl, Model model) {
		
		
		model.addAttribute("board_srl", board_srl);
		
		
		return "board/service/board_service_view";
	}
	
	// 글쓰기 폼 가져오기
		@RequestMapping(value = "/board/service/new", method = RequestMethod.GET)
		public String writeFormBoard() {
			return "board/service/board_service_write";
		}

		// 글쓰기 처리
		@ResponseBody
		@RequestMapping(value = "/board/service", method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> writeActionBoard(HttpServletRequest req, HttpSession session) {
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

				int result = service.writeBoard(req, map);

				if (result <= 0) {
					map.put("result", "fail");
					map.put("errorMsg", "sqlError");
				} else {
					map.put("result", "success");
				}

			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
			}

			if (((String) map.get("result")).equals("fail")) {
				entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
			} else if (((String) map.get("result")).equals("success")) {
				System.out.println("글수정 성공");
				entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			}
			return entity;
		}

		// 글수정 폼
		@RequestMapping(value = "/board/service/{board_srl}/edit", method = RequestMethod.GET)
		public String modifyFormBoard(@PathVariable Integer board_srl, Model model) {
			// model.addAttribute("board_srl",board_srl);
			System.out.println("글 수정 폼");
			service.readBoard(board_srl, model);
			return "board/service/board_service_modify";
		}

		// 글수정 처리
		@ResponseBody
		@RequestMapping(value = "/board/service/{board_srl}", method = { RequestMethod.PUT, RequestMethod.PATCH })
		public ResponseEntity<Map<String, Object>> modifyActionBoard(@PathVariable Integer board_srl, HttpServletRequest req,
				HttpSession session, @RequestBody BoardVO vo,Model model) {

			  vo.setBoard_srl(board_srl);
			 
			  BoardVO originVO =service.readBoard(board_srl, model);
			  String origin_id = originVO.getUser_id();
			  String user_id = ((MemberVO) session.getAttribute("loginUserInfo")).getUser_id();
			  
			  System.out.println("board_srl:"+board_srl);
			  System.out.println("category_srl:"+vo.getCategory_srl());
			  System.out.println("title:"+vo.getTitle());
			  System.out.println("contents:"+vo.getContents());
			
			Map<String, Object> map = new HashMap<String, Object>();
			ResponseEntity<Map<String, Object>> entity = null;

			try {
				if (session.getAttribute("loginUserInfo") == null) {
					map.put("result", "fail");
					map.put("errorMsg", "isNotLogin");

				} else {

					if (!user_id.equalsIgnoreCase(origin_id)) {
						map.put("result", "fail");
						map.put("errorMsg", "hasNotAuth");
						
					} else {

						int result = service.modifyBoard(vo);

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
				map.put("result", "fail");
				map.put("layer_msg", e.getMessage());
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
		@RequestMapping(value = "/board/service/{board_srl}", method = RequestMethod.DELETE)
		public ResponseEntity<Map<String, Object>> deleteBoard(HttpServletRequest req, HttpSession session, Model model,
				@PathVariable Integer board_srl) {

			BoardVO originVO =service.readBoard(board_srl, model);
			  String origin_id = originVO.getUser_id();
			  String user_id = ((MemberVO) session.getAttribute("loginUserInfo")).getUser_id();
			  
			Map<String, Object> map = new HashMap<String, Object>();
			ResponseEntity<Map<String, Object>> entity = null;

			try {
				if (session.getAttribute("loginUserInfo") == null) {
					map.put("result", "fail");
					map.put("errorMsg", "isNotLogin");
				} else {

					if (!user_id.equalsIgnoreCase(origin_id)) {
						map.put("result", "fail");
						map.put("errorMsg", "hasNotAuth");
					} else {

						int result = service.deleteBoard(board_srl);

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
