package com.cafe24.ourplanners.search.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.cafe24.ourplanners.board.domain.BoardVO;
import com.cafe24.ourplanners.board.domain.SubCategoryVO;
import com.cafe24.ourplanners.board.domain.WordCloudVO;
import com.cafe24.ourplanners.search.persistence.SearchDAO;
import com.cafe24.ourplanners.util.Criteria;
import com.cafe24.ourplanners.util.PagingUtil;
import com.cafe24.ourplanners.util.SearchServiceBoardCriteria;
import com.cafe24.ourplanners.util.ServiceBoardCriteria;
import com.cafe24.ourplanners.util.wordcloud.KoreanWords;

@Service
public class SearchServiceImpl implements SearchService {

	@Inject
	private SearchDAO dao;

	@Override
	public void getHotServiceList(Criteria cri, HashMap<String, Object> map) {
		List<BoardVO> list = new ArrayList<BoardVO>();

		list = dao.getHotServiceList(cri);
		map.put("list", list);

	}

	@Override
	public void getHotKeyWordList(ServiceBoardCriteria cri, HashMap<String, Object> map) {
		List<WordCloudVO> list = new ArrayList<WordCloudVO>();

		list = dao.getHotKeyWordList(cri);
		map.put("list", list);

	}

	@Override
	public void getSubCategoryListSearch(SubCategoryVO vo, HashMap<String, Object> map) {
		List<SubCategoryVO> list = new ArrayList<SubCategoryVO>();

		list = dao.getSubCategoryListSearch(vo);
		map.put("subCategoryList", list);

	}

	// 서비스 검색시 리스트 가져오기
	@Override
	public void getServiceListSearch(SearchServiceBoardCriteria scri, HashMap<String, Object> map) {
		List<BoardVO> list = new ArrayList<BoardVO>();

		list = dao.getServiceListSearch(scri);

		String searchType = scri.getSearchType();
		String keyword = scri.getKeyword();

		int affected = 0;
		if (searchType != null && searchType.length() != 0 && keyword != null && keyword.length() != 0) {
			List<SearchServiceBoardCriteria> scriLists = new ArrayList<SearchServiceBoardCriteria>();

			scriLists = KoreanWords.getNounWords(scri);

			for (SearchServiceBoardCriteria scriList : scriLists) {
				affected = dao.insertWordCloud(scriList);
			}
		}

		// affected = dao.insertWordCloud(scri);
		// todo 공백을 기준으로 형태소 분석해서 명사만 등록하기

		map.put("searchList", list);

		int totalRecordCount = dao.getTotalServiceCount(scri);
		String pagingDiv = PagingUtil.pagingAjaxService(totalRecordCount, scri, "servicePaging");

		map.put("pagingDiv", pagingDiv);

	}

	@Override
	public int writeBoard(HttpServletRequest req, Map<String, Object> map) throws Exception {

		int board_srl = 0;

		String user_id = req.getParameter("user_id");
		String title = req.getParameter("title");
		String contents = req.getParameter("contents");

		Pattern srcPattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		// Pattern titlePattern =
		// Pattern.compile("<img[^>]*title=[\"']?([^>\"']+)[\"']?[^>]*>");
		Matcher srcMatcher = srcPattern.matcher(contents);
		// Matcher titleMatcher = titlePattern.matcher(contents);

		String imageSrc = "";

		while (srcMatcher.find()) {
			imageSrc += srcMatcher.group(1);
		}

		int index1 = imageSrc.indexOf("e/");
		int index2 = imageSrc.indexOf("&#");
		String main_image = null;
		if(index1!=-1&&index2!=-1)
		{
		 main_image = imageSrc.substring(index1 + 2, index2);
		}
		
		System.out.println("main_image : " + main_image);
		// imageName : baca2009-be88-4092-a316-4c489a8b850e.jpg

		/*
		 * while(titleMatcher.find()) { System.out.println(titleMatcher.group(1)+","); }
		 */

		String location = req.getParameter("location");

		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date utilDate = null;

		String strService_time_start = req.getParameter("service_time_start");
		utilDate = fm.parse(strService_time_start);
		java.sql.Date sqlService_time_start = new java.sql.Date(utilDate.getTime());

		String strService_time_end = req.getParameter("service_time_end");
		utilDate = fm.parse(strService_time_end);
		java.sql.Date sqlService_time_end = new java.sql.Date(utilDate.getTime());

		int contact_time_start = Integer.parseInt(req.getParameter("contact_time_start"));
		int contact_time_end = Integer.parseInt(req.getParameter("contact_time_end"));
		int category_srl = Integer.parseInt(req.getParameter("category_srl"));
		int subcategory_srl = Integer.parseInt(req.getParameter("subcategory_srl"));
		int service_cost = Integer.parseInt(req.getParameter("service_cost"));
		String board_type = req.getParameter("board_type");

		BoardVO vo = new BoardVO();
		vo.setBoard_srl(board_srl);
		vo.setBoard_type(board_type);
		vo.setUser_id(user_id);
		vo.setTitle(title);
		vo.setContents(contents);
		vo.setLocation(location);
		vo.setService_time_start(sqlService_time_start);
		vo.setService_time_end(sqlService_time_end);
		vo.setContact_time_start(contact_time_start);
		vo.setContact_time_end(contact_time_end);
		vo.setMain_image(main_image);
		vo.setCategory_srl(category_srl);
		vo.setSubcategory_srl(subcategory_srl);
		vo.setService_cost(service_cost);

		return dao.writeBoard(vo);

	}

	@Override
	public BoardVO readBoardJson(Integer boardSrl) {
		return dao.readBoard(boardSrl);
	}

	@Override
	public BoardVO readBoard(Integer board_srl, Model model) {
		BoardVO vo = new BoardVO();
		vo = dao.readBoard(board_srl);
		// 싱글 쿼테이션 더블 쿼테이션 변경
		vo.setContents(vo.getContents().replaceAll("'", "\"").replaceAll("’", "\"").replaceAll("‘", "\"")
				.replaceAll("\"", "\""));
		// 줄바꿈 처리
		// vo.setContents(vo.getContents().replaceAll("\r\n", "<br/>"));
		// vo.setContents(vo.getContents().replaceAll(System.getProperty("line.separator"),
		// "<br/>"));
		model.addAttribute("boardVO", vo);
		return vo;
	}

	@Override
	public void visitCount(Integer boardSrl) throws Exception {
		dao.visitCount(boardSrl);
	}

	@Override
	public int modifyBoard(BoardVO vo) {

		BoardVO OriginVO = dao.readBoard(vo.getBoard_srl());
		
		OriginVO.setTitle(vo.getTitle());
		OriginVO.setContents(vo.getContents());
		OriginVO.setLocation(vo.getLocation());
		OriginVO.setService_time_start(vo.getService_time_start());
		
		OriginVO.setService_time_end(vo.getService_time_end());
		
		OriginVO.setService_cost(vo.getService_cost());
		
		OriginVO.setContact_time_start(vo.getContact_time_start());
		OriginVO.setContact_time_end(vo.getContact_time_end());
		
		String contents = vo.getContents();

		// 스마트 에디터의 img테그 src값 얻어오기
		Pattern srcPattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		// Pattern titlePattern =
		// Pattern.compile("<img[^>]*title=[\"']?([^>\"']+)[\"']?[^>]*>");
		Matcher srcMatcher = srcPattern.matcher(contents);
		// Matcher titleMatcher = titlePattern.matcher(contents);

		String imageSrc = "";

		// src 속성값 얻어와서 imageSrc에 더하기
		while (srcMatcher.find()) {
			imageSrc += srcMatcher.group(1);
		}
		
		
		int index1 = imageSrc.indexOf("e/");
		int index2 = imageSrc.indexOf("&#");
		
		String main_image = null;
		if(index1!=-1&&index2!=-1)
		{
		 main_image = imageSrc.substring(index1 + 2, index2);
		}
		
		System.out.println("main_image : " + main_image);

		
		OriginVO.setMain_image(main_image);

		return dao.modifyBoard(OriginVO);
	}

	@Override
	public int deleteBoard(Integer board_srl) {
		return dao.deleteBoard(board_srl);
	}
}
