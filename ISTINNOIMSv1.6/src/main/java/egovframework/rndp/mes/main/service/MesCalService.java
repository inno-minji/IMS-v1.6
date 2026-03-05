package egovframework.rndp.mes.main.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;


public interface MesCalService {

	public List mainCalendarWorkList(MesCalVO vo) throws Exception;
	
	public List mainCalendarErrList(MesCalVO vo) throws Exception;

	public List mainCalendarInsList(MesCalVO vo) throws Exception;
	
}
