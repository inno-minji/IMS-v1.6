package egovframework.rndp.mes.main.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.rndp.com.utl.EgovStringUtil;
import egovframework.rndp.mes.common.service.impl.MesCommonDAO;
import egovframework.rndp.mes.gubun.service.MesGubunVO;
import egovframework.rndp.mes.main.service.MesCalService;
import egovframework.rndp.mes.main.service.MesCalVO;

@Service("mesCalService")
public class MesCalServiceImpl implements MesCalService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MesCalServiceImpl.class);

	/*공통사용 DAO common 및  Egov 공용 */
	@Resource(name = "mesCommonDAO")
	private MesCommonDAO mesCommonDAO; 
	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;
	

	@Resource(name = "mesCalDAO")
	private MesCalDAO mesCalDAO; 
	

	@Override
	public List mainCalendarWorkList(MesCalVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mesCalDAO.mainCalendarWorkList(vo); 
	}
	
	@Override
	public List mainCalendarErrList(MesCalVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mesCalDAO.mainCalendarErrList(vo); 
	}
	
	@Override
	public List mainCalendarInsList(MesCalVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mesCalDAO.mainCalendarInsList(vo); 
	}
	 
}
