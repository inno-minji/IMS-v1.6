package egovframework.rndp.mes.main.service;

import java.util.List;

import egovframework.rndp.com.cmm.service.DefultVO;
import egovframework.rndp.com.utl.EgovStringUtil;

public class MesCalVO extends DefultVO{
	
	private String calStart						= "";
	private String calEnd						= "";
	private String itemId						= "";
	private String itemDate						= "";
	
	
	public String getCalStart() {
		return calStart;
	}
	public void setCalStart(String calStart) {
		this.calStart = calStart;
	}
	public String getCalEnd() {
		return calEnd;
	}
	public void setCalEnd(String calEnd) {
		this.calEnd = calEnd;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getItemDate() {
		return itemDate;
	}
	public void setItemDate(String itemDate) {
		this.itemDate = itemDate;
	}
	 
}
