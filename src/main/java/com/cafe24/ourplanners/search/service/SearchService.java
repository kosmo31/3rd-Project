package com.cafe24.ourplanners.search.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.cafe24.ourplanners.board.domain.BoardVO;
import com.cafe24.ourplanners.board.domain.SubCategoryVO;
import com.cafe24.ourplanners.util.Criteria;
import com.cafe24.ourplanners.util.SearchServiceBoardCriteria;
import com.cafe24.ourplanners.util.ServiceBoardCriteria;

public interface SearchService {

	public void getHotServiceList(Criteria cri, HashMap<String, Object> map);

	public void getHotKeyWordList(ServiceBoardCriteria cri, HashMap<String, Object> map);

	public void getSubCategoryListSearch(SubCategoryVO vo, HashMap<String, Object> map);

	public void getServiceListSearch(SearchServiceBoardCriteria scri, HashMap<String, Object> map);

	public int writeBoard(HttpServletRequest req, Map<String, Object> map) throws Exception;

	public BoardVO readBoard(Integer board_srl, Model model);

	public int modifyBoard(BoardVO vo);

	public int deleteBoard(Integer board_srl);

	void visitCount(Integer boardSrl) throws Exception;

	public BoardVO readBoardJson(Integer board_srl);	
}
