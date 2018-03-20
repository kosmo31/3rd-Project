package com.cafe24.ourplanners.mypage.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cafe24.ourplanners.board.domain.BoardVO;
import com.cafe24.ourplanners.board.dto.BoardDTO;

@Repository
public class MyPageDAOImpl implements MyPageDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static String namespace = "com.kosmo.mapper.MyPageMapper";
	
	@Override
	public BoardVO view(Integer boardSrl) throws Exception{
		return sqlSession.selectOne(namespace + ".view", boardSrl);
	}
	
	@Override
	public void visitCount(Integer boardSrl) throws Exception {
		sqlSession.update(namespace + ".visitCount", boardSrl);
	}
	
	@Override
	public BoardVO modify(Integer board_srl) {
		return sqlSession.selectOne(namespace + ".modify", board_srl);
	}
	
	@Override
	public int modifyAction(BoardDTO dto) throws Exception {
		return sqlSession.update(namespace + ".modifyAction", dto); 
	}
	
	@Override
	public int delete(Integer board_srl) throws Exception {
		return sqlSession.delete(namespace + ".delete", board_srl); 
	}
	
	@Override
	public int getClientListCheck_TotalRecordCount(String user_id) throws Exception {
		return sqlSession.selectOne(namespace + ".getClientListCheck_TotalRecordCount", user_id); 
	}
	
	@Override
	public int getClientListUnCheck_TotalRecordCount(String user_id) throws Exception {
		return sqlSession.selectOne(namespace + ".getClientListUnCheck_TotalRecordCount", user_id); 
	}
	
	@Override
	public int getClientList_TotalRecordCount(String user_id) throws Exception {
		return sqlSession.selectOne(namespace + ".getClientList_TotalRecordCount", user_id); 
	}
	
	@Override
	public int getEngineerListCheck_TotalRecordCount(String user_id) throws Exception {
		return sqlSession.selectOne(namespace + ".getEngineerListCheck_TotalRecordCount", user_id); 
	}
	
	@Override
	public int getEngineerListUnCheck_TotalRecordCount(String user_id) throws Exception {
		return sqlSession.selectOne(namespace + ".getEngineerListUnCheck_TotalRecordCount", user_id); 
	}
	
	@Override
	public int getEngineerList_TotalRecordCount(String user_id) throws Exception {
		return sqlSession.selectOne(namespace + ".getEngineerList_TotalRecordCount", user_id); 
	}
	
	@Override
	public int getEngineerMember_TotalCount() throws Exception {
		return sqlSession.selectOne(namespace + ".getEngineerMember_TotalCount"); 
	}
	
	@Override
	public int getEngineerCateGory1_TotalCount() throws Exception {
		return sqlSession.selectOne(namespace + ".getEngineerCateGory1_TotalCount"); 
	}
	
	@Override
	public int getEngineerCateGory2_TotalCount() throws Exception {
		return sqlSession.selectOne(namespace + ".getEngineerCateGory2_TotalCount"); 
	}
	
	@Override
	public int getEngineerCateGory3_TotalCount() throws Exception {
		return sqlSession.selectOne(namespace + ".getEngineerCateGory3_TotalCount"); 
	}
	
	@Override
	public int getEngineerCateGory4_TotalCount() throws Exception {
		return sqlSession.selectOne(namespace + ".getEngineerCateGory4_TotalCount"); 
	}
	
	@Override
	public int getEngineerCateGory5_TotalCount() throws Exception {
		return sqlSession.selectOne(namespace + ".getEngineerCateGory5_TotalCount"); 
	}
	
	
}








































