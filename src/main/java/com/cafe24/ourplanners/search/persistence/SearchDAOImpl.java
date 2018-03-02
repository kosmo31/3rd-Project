package com.cafe24.ourplanners.search.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cafe24.ourplanners.board.domain.BoardVO;
import com.cafe24.ourplanners.board.domain.SubCategoryVO;
import com.cafe24.ourplanners.board.domain.WordCloudVO;
import com.cafe24.ourplanners.util.Criteria;
import com.cafe24.ourplanners.util.SearchServiceBoardCriteria;

@Repository
public class SearchDAOImpl implements SearchDAO {

	@Autowired
	private SqlSession sqlSession;

	private static String searchMapper = "com.kosmo.mapper.SearchMapper";
	private static String wordCloudMapper = "com.kosmo.mapper.WordCloudMapper";
	
	@Override
	public List<BoardVO> getHotServiceList(Criteria cri) {
		
		 return sqlSession.selectList(searchMapper + ".getHotServiceList", cri);		 
		 
	}
	@Override
	public List<WordCloudVO> getHotKeyWordList(Criteria cri) {
		
		return sqlSession.selectList(wordCloudMapper + ".getHotWordCloud", cri);
	}
	@Override
	public List<SubCategoryVO> getSubCategoryListSearch(SubCategoryVO vo) {
		 return sqlSession.selectList(searchMapper + ".getSubCategoryListSearch", vo);		 
	}
	
	@Override
	public List<BoardVO> getServiceListSearch(SearchServiceBoardCriteria scri) {
		 return sqlSession.selectList(searchMapper + ".getServiceListSearch", scri);		 
	}
	
	//검색어 워드 클라우드 입력
	@Override
	public int insertWordCloud(SearchServiceBoardCriteria scri) {
		
		Map<String,Object> paramMap = new HashMap<String, Object>();

		System.out.println("키워드:"+scri.getKeyword());
		System.out.println("서브카테:"+scri.getSubcategory_srl());
		System.out.println("보드타입:"+scri.getBoard_type());					
		paramMap.put("searchword", scri.getKeyword());
		paramMap.put("subcategory_srl", scri.getSubcategory_srl());
		paramMap.put("category_srl", scri.getCategory_srl());
		paramMap.put("board_type", scri.getBoard_type());
		
		return sqlSession.insert(wordCloudMapper + ".insertWordCloud", paramMap);
	}
}
