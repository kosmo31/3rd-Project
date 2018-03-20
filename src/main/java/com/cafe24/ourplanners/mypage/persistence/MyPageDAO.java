package com.cafe24.ourplanners.mypage.persistence;

import java.util.List;

import com.cafe24.ourplanners.board.domain.BoardVO;
import com.cafe24.ourplanners.board.dto.BoardDTO;

public interface MyPageDAO {
	
	public BoardVO view (Integer boardSrl) throws Exception;
	
	public void visitCount(Integer boardSrl) throws Exception;

	public BoardVO modify(Integer board_srl) throws Exception;
	
	public int modifyAction(BoardDTO dto) throws Exception;
	
	public int delete(Integer board_srl) throws Exception;
	
	public int getClientListCheck_TotalRecordCount(String user_id) throws Exception;
	
	public int getClientListUnCheck_TotalRecordCount(String user_id) throws Exception;
	
	public int getClientList_TotalRecordCount(String user_id) throws Exception;
	
	public int getEngineerListCheck_TotalRecordCount(String user_id) throws Exception;
	
	public int getEngineerListUnCheck_TotalRecordCount(String user_id) throws Exception;
	
	public int getEngineerList_TotalRecordCount(String user_id) throws Exception;
	
	public int getEngineerMember_TotalCount() throws Exception;
	
	public int getEngineerCateGory1_TotalCount() throws Exception;
	
	public int getEngineerCateGory2_TotalCount() throws Exception;
	
	public int getEngineerCateGory3_TotalCount() throws Exception;
	
	public int getEngineerCateGory4_TotalCount() throws Exception;
	
	public int getEngineerCateGory5_TotalCount() throws Exception;
}
