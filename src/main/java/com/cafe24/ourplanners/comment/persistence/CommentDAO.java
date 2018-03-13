package com.cafe24.ourplanners.comment.persistence;

import java.util.List;

import com.cafe24.ourplanners.comment.domain.CommentVO;
import com.cafe24.ourplanners.util.CommentCriteria;
import com.cafe24.ourplanners.util.Criteria;

public interface CommentDAO {
	public List<CommentVO> getCommentListJson(CommentCriteria scri);

	public int getTotalCount(CommentCriteria scri);

	public int count(Integer bno) throws Exception;

	public int addComment(CommentVO vo);

	public int modifyComment(CommentVO vo);

	public int deleteComment(Integer comment_srl);

	public CommentVO readComment(Integer comment_srl);

}
