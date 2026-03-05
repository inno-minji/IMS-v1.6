package egovframework.rndp.mes.main.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rndp.mes.main.service.MesCalVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("mesCalDAO")
public class MesCalDAO extends EgovAbstractDAO{


	public List mainCalendarWorkList(MesCalVO vo) throws Exception{
		// TODO Auto-generated method stub
		return list("mesCalDAO.mainCalendarWorkList", vo);
	}
	
	public List mainCalendarErrList(MesCalVO vo) throws Exception{
		// TODO Auto-generated method stub
		return list("mesCalDAO.mainCalendarErrList", vo);
	}
	
	public List mainCalendarInsList(MesCalVO vo) throws Exception{
		// TODO Auto-generated method stub
		return list("mesCalDAO.mainCalendarInsList", vo);
	}
	
	

}