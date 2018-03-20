package com.cafe24.ourplanners.mypage.service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.cafe24.ourplanners.board.domain.BoardVO;
import com.cafe24.ourplanners.board.dto.BoardDTO;
import com.cafe24.ourplanners.board.persistence.BoardDAO;
import com.cafe24.ourplanners.mypage.persistence.MyPageDAO;

@Service
public class MyPageServiceImpl implements MyPageService{
	
	@Inject
	private MyPageDAO dao;
	
	@Override
	public BoardVO view(Integer boardSrl) throws Exception {
		return dao.view(boardSrl);
	}
	
	@Override
	public void visitCount(Integer boardSrl) throws Exception {
		dao.visitCount(boardSrl);
	}
	
	@Override
	public void modify(Integer board_srl, Model model) throws Exception {
		BoardVO vo = new BoardVO();
		vo = dao.modify(board_srl);
		vo.setContents(vo.getContents().replaceAll("\r\n", "<br/>"));
		model.addAttribute("vo", vo);
	}
	
	@Override
	public int modifyAction(HttpServletRequest req) throws Exception {
		
		int board_srl = Integer.parseInt(req.getParameter("board_srl"));
		
	    String user_id = req.getParameter("user_id");
	    String title = req.getParameter("title");
	    String contents = req.getParameter("contents");
	    
	    Pattern srcPattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
	    //Pattern titlePattern = Pattern.compile("<img[^>]*title=[\"']?([^>\"']+)[\"']?[^>]*>");
	    Matcher srcMatcher = srcPattern.matcher(contents);
	    //Matcher titleMatcher = titlePattern.matcher(contents);
	    
	    String imageSrc = "";
	    
	    while(srcMatcher.find()) {
	    	imageSrc += srcMatcher.group(1);
	    }
	    int index1 = imageSrc.indexOf("e/");
	    int index2 = imageSrc.indexOf("&#");
	    
	    String main_image = imageSrc.substring(index1+2, index2);
	    System.out.println("main_image : " + main_image);
	    
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
		
		BoardDTO dto = new BoardDTO(board_srl, user_id, title, contents, location, sqlService_time_start,
				sqlService_time_end, contact_time_start, contact_time_end, main_image, category_srl, subcategory_srl, 
				service_cost, board_type);
	    		
		return dao.modifyAction(dto);
	}
	
	@Override
	public int delete(Integer board_srl) throws Exception {
		
		return dao.delete(board_srl);
	}
	
	@Override
	public int getClientListCheck_TotalRecordCount(String user_id) throws Exception {
		return dao.getClientListCheck_TotalRecordCount(user_id);
	}
	
	@Override
	public int getClientListUnCheck_TotalRecordCount(String user_id) throws Exception {
		return dao.getClientListUnCheck_TotalRecordCount(user_id);
	}
	
	@Override
	public int getClientList_TotalRecordCount(String user_id) throws Exception {
		return dao.getClientList_TotalRecordCount(user_id);
	}
	
	@Override
	public int getEngineerListCheck_TotalRecordCount(String user_id) throws Exception {
		return dao.getEngineerListCheck_TotalRecordCount(user_id);
	}
	
	@Override
	public int getEngineerListUnCheck_TotalRecordCount(String user_id) throws Exception {
		return dao.getEngineerListUnCheck_TotalRecordCount(user_id);
	}
	
	
	@Override
	public int getEngineerList_TotalRecordCount(String user_id) throws Exception {
		return dao.getEngineerList_TotalRecordCount(user_id);
	}
	
	@Override
	public void getServiceData(Model model, HttpServletRequest req) {
		
		//엔지니어회원 총 회원수 구하기 
		int engineerMember_TotalCount = 0;
		//엔지니어 카테고리1~6 글 총 구하기
		int engineerCateGory1_TotalCount = 0;
		int engineerCateGory2_TotalCount = 0;
		int engineerCateGory3_TotalCount = 0;
		int engineerCateGory4_TotalCount = 0;
		int engineerCateGory5_TotalCount = 0;
		
		try {
			engineerMember_TotalCount = dao.getEngineerMember_TotalCount();
			//엔지니어 카테고리1~6 글 총 구하기
			engineerCateGory1_TotalCount = dao.getEngineerCateGory1_TotalCount();
			engineerCateGory2_TotalCount = dao.getEngineerCateGory2_TotalCount();
			engineerCateGory3_TotalCount = dao.getEngineerCateGory3_TotalCount();
			engineerCateGory4_TotalCount = dao.getEngineerCateGory4_TotalCount();
			engineerCateGory5_TotalCount = dao.getEngineerCateGory5_TotalCount();
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("engineerMember_TotalCount", engineerMember_TotalCount);
		model.addAttribute("engineerCateGory1_TotalCount", engineerCateGory1_TotalCount);
		model.addAttribute("engineerCateGory2_TotalCount", engineerCateGory2_TotalCount);
		model.addAttribute("engineerCateGory3_TotalCount", engineerCateGory3_TotalCount);
		model.addAttribute("engineerCateGory4_TotalCount", engineerCateGory4_TotalCount);
		model.addAttribute("engineerCateGory5_TotalCount", engineerCateGory5_TotalCount);
		

	}
}





















