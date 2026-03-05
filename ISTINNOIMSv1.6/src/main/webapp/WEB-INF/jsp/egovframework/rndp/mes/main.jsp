<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />
<script src="/js/jquery-ui-1.14.1/jquery-ui.min.js"></script>
<script src="/js/Chart/ChartB.js"></script>
<script src='/js/fullcalendar.js'></script>

<script type="text/javascript">
$(document).ready(function() {
    $(document).on('click', '#menu-toggle-btn', function() {
        $('body').toggleClass('nav-open');

        // 애니메이션이 끝나는 시점에 리사이즈 이벤트 발생 (차트 깨짐 방지)
        setTimeout(function() {
            window.dispatchEvent(new Event('resize'));
        }, 300);
    });
});
		
/* 페이징 */
function fn_guestList(pageNo) {
	$('#mloader').show();
	document.frm.submit();
}

function fn_keyDown(){
	if(event.keyCode == 13){
		fn_guestList(1);
	}			
}

function nowDate(){
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
    var nowDate = year + "-" + month + "-" + day;
	
    return nowDate;
}


$(document).ready(function(){	
	datepickerSet('topStartDate', 'topEndDate');
	
	$('.tab_button').click(function () {
		const target = $(this).data('tab');
		$('.tab_button').removeClass('active');
		$(this).addClass('active');
		$('.tab_content').hide();
		$('#' + target).show();
	});
	$('.tab_button.active').trigger('click');
	
	
});






function setStartDate(d) {
	var settingDate = new Date();
	if (d === '1d') settingDate.setDate(settingDate.getDate() - 1);
	else if (d === '2d') settingDate.setDate(settingDate.getDate() - 2);
	else if (d === '3d') settingDate.setDate(settingDate.getDate() - 3);
	else if (d === 7) settingDate.setDate(settingDate.getDate() - 7);
	else if (d === 1) settingDate.setMonth(settingDate.getMonth() - 1);
	else settingDate.setMonth(settingDate.getMonth() - 3);

	// 날짜 입력
	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	
	document.getElementById('selectedDateBtnValue').value = d;
	
	applyActiveButton(d);

	fn_guestList(1);
}

function applyActiveButton(value) {
	// 모든 버튼에서 active 제거
	document.querySelectorAll('.select_date .date_btn').forEach(btn => {
		btn.classList.remove('active');
	});

	// 해당 id 조합 버튼에 active 부여
	const targetId = 'btn' + value;
	const targetBtn = document.getElementById(targetId);
	if (targetBtn) {
		targetBtn.classList.add('active');
	}
}

function moveDetail(url){
	$("#topStartDate").val("");
	$("#topEndDate").val("");
	if(url != ''){
		document.frm.action = url;
	}else{
		document.frm.action = "/mes/main.do";
	}
	document.frm.submit();
}
function setDate() {
	  document.getElementById('selectedDateBtnValue').value = '';
	}
</script>
<style>
	.ellipsis {
		max-width: 130px; 
		white-space: nowrap; 
		overflow: hidden; 
		text-overflow: ellipsis;
	}
	.num_2 ul li:not(:first-child) {
	  width: fit-content; 
	  margin: 0 auto; 
	}
	
	.err_group {
	    display: flex;
	    justify-content: flex-end; 
	    align-items: center; 
	    gap: 8px;
	}
	
	.err_all,
	.err_plus {
	    padding-top: 0;
	}


</style>
<form id="frm" name="frm" method="post"	action="/mes/main.do">
<input type="hidden" id="selectedDateBtnValue" name="searchTypeSet10" value="${vo.searchTypeSet10}">
<input type="hidden" id="calStart" name="calStart" value="${cvo.calStart}">
<input type="hidden" id="calEnd" name="calEnd" value="${cvo.calEnd}">

		 <div id="mes_container">
		 	<div class="main_top">
		 		<div class="main_title" style="font-size:23px; padding-left: 17px;">
					시스템 운영 현황
				</div>
				<div class="seoeun_top">
				  <div class="seoeun_row">
					<ul class="select_date">
						<li>
							<button type="button" class="date_btn" id="btn1d" onclick="setStartDate('1d');">
								1일전
							</button>
						</li>
						<li>
							<button type="button" class="date_btn" id="btn2d" onclick="setStartDate('2d');">
								2일전
							</button>
						</li>
						<li>
							<button type="button" class="date_btn" id="btn3d" onclick="setStartDate('3d');">
								3일전
							</button>
						</li>
						<li>
							<button type="button" class="date_btn" id="btn7" onclick="setStartDate(7);">
								1주일
							</button>
						</li>
						<li>
							<button type="button" class="date_btn"  id="btn1" onclick="setStartDate(1);">
								1개월
							</button>
						</li>
						<li>
							<button type="button" class="date_btn"  id="btn3" onclick="setStartDate(3);">
								3개월
							</button>
						</li>
					</ul>
					</div>
					<div class="range_select">
						<img src="../../images/main_img/113.svg" class="cal">
						<input type="text" name="topStartDate" id="topStartDate" value="${vo.topStartDate}" readonly class="inp_color" onchange="setDate()" />
						- <input type="text" name="topEndDate" id="topEndDate" value="${vo.topEndDate}" readonly class="inp_color"  onchange="setDate()"/>
					<!-- <button type="submit" class="basic_btn dark" onclick="fn_guestList(1)">검색</button> -->
					</div>
					<img src="../../images/main_img/2.svg" class="se_2"  onclick="fn_guestList(1)">
				</div>
		 	</div>
		 	<div class="dashboard_wrap">
		 		<div class="top">
		 			<div class="error">
		 				<div>
		 					<div class="err_text">
		 						<span>장애 처리</span>
			 						<div class="err_all">
			 							<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/issue/kw_issue_lf.do');" </c:if> style="cursor:pointer;">viewAll</a>
			 						</div>
		 							<div class="err_plus">
		 								<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/issue/kw_issue_if.do');" </c:if> style="cursor:pointer;">+</a>
		 							</div>
		 					</div>
		 					<div class="error_statu" >
		 						<div class="regist">
		 							<p class="r_1">${mainIssueInfo.eSearchWordA}</p>		 							
		 							<strong>접수</strong>
		 							<%-- <div class="r_2"></div>
		 							<span>지난주 등록 건</span>
		 							<div class="r_3">
			 							<p class="r_3_1">${mainIssueInfo.eSearchWordA}</p>
			 							<img src="../../images/main_img/57_1.svg" /> <!-- 감소 -->
		 							</div> --%>
		 						</div>
		 						<div class="ing" style="padding:10px;">		 							
		 							<p class="r_1" style="margin: -1px 0 5px 0;">${mainIssueInfo.eSearchWordB}</p>
		 							<strong>처리중</strong>
		 							<%-- <div class="r_2_1"></div>
		 							<span>지난주 등록 건</span>
		 							<div class="r_3">
			 							<p class="r_3_2">${mainIssueInfo.eSearchWordB}</p>
			 							<img src="../../images/main_img/57_2.svg" /> <!-- //증가 -->
		 							</div> --%>
		 						</div>
		 						<div class="complete">
		 							<p class="r_1">${mainIssueInfo.eSearchWordC}</p>
		 							<strong>완료</strong>
		 							<%-- <div class="r_2_1"></div>
		 							<span>지난주 등록 건</span>
		 							<div class="r_3">
			 							<p class="r_3_2">${mainIssueInfo.eSearchWordB}</p>
			 							<img src="../../images/main_img/57_2.svg" /> <!-- //증가 -->
		 							</div> --%>
		 						</div>
		 					</div>
							<table class="dash_table_err">
								<!-- <thead>
									<tr>
										<th>No.</th>
										<th>자산유형 </th>
										<th>요청내용 </th>
										<th>상태</th>
										<th>요청일자</th>
									</tr>
								</thead> -->
								<tbody>
									<c:forEach var="list" items="${mainIssueList}" varStatus="i" end="9">
										<tr <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/issue/kw_issue_lf.do');" </c:if> style="cursor:pointer;">
												<td width="40px"> ${i.count}
<%-- 													<c:choose> --%>
<%-- 														<c:when test="${list.eAssetTypeName eq '네트워크'}"> --%>
<!-- 															<div class="nw_img"> -->
<!-- 																<img src="../../images/main_img/icon_7.svg"/> -->
<!-- 															</div> -->
<%-- 														</c:when> --%>
<%-- 														<c:when test="${list.eAssetTypeName eq 'PC'}"> --%>
<!-- 															<div class="pc_img"> -->
<!-- 																<img src="../../images/main_img/icon_217.svg"/> -->
<!-- 															</div> -->
<%-- 														</c:when> --%>
<%-- 														<c:when test="${list.eAssetTypeName eq '서버'}"> --%>
<!-- 															<div class="sv_img"> -->
<!-- 																<img src="../../images/main_img/icon_1.svg"/> -->
<!-- 															</div> -->
<%-- 														</c:when> --%>
<%-- 														<c:when test="${list.eAssetTypeName eq '보안'}"> --%>
<!-- 															<div class="sc_img"> -->
<!-- 																<img src="../../images/main_img/icon_4.svg"/> -->
<!-- 															</div> -->
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<!-- 															<div class="ba_img"> -->
<!-- 																<img src="../../images/main_img/icon_5.svg"/> -->
<!-- 															</div> -->
<%-- 														</c:otherwise> --%>
<%-- 													</c:choose>													 --%>
												</td>
												<td>${list.eAssetTypeName}</td>
												<td class="ellipsis">${list.eIssueContent}</td>
												<c:choose>
													<c:when test="${list.eIssueStatus eq '처리등록'}">
														<td>완료</td>
													</c:when>
													<c:otherwise>
														<td>처리중</td>
													</c:otherwise>
												</c:choose>
												<td>${list.eRequestDate}</td>
										</tr>
									</c:forEach>
									 <c:forEach var="i" begin="${fn:length(mainIssueList) + 1}" end="10">
									      <tr>
									        <td>-</td>
									        <td>-</td>
									        <td>-</td>
									        <td>-</td>
									        <td>-</td>
									      </tr>
								    </c:forEach>
								</tbody>
							</table>
						</div>
		 			</div>
		 			<div class="device">
		 				<div class="err_text">
	 						<span>대상장비</span>
	 						<div class="err_all">
	 							<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/asset/kw_asset_lf.do');" </c:if> style="cursor:pointer;">viewAll</a>
	 						</div>
<!--  							<div class="err_plus"> -->
<%--  								<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/asset/kw_asset_lf.do');" </c:if> style="cursor:pointer;">+</a> --%>
<!--  							</div> -->
	 					</div>
		 					
		 				<div class="tabs">
		 					<div class="tab">
		 						<button type="button" class="tab_button active" data-tab="all_content">자산유형별</button>
		 						<button type="button" class="tab_button" data-tab="programming_content">제조사별</button>
		 					</div>
		 					<div class="tab_contents" >
			 					<div class="tab_content" id="all_content">
							        <div id="containerGraph1div" <c:if test="${ass742 eq 'T' || staff.kAdminAuth eq 'T'}"> onclick="moveDetail('/mes/asset/kw_asset_lf.do');" </c:if>>
							       	 <canvas id="containerGraph1" ></canvas>
							        </div>
							        
							        <div class="list_graph_1" >
										<div class="list_graph_nw"><!-- 네트워크 -->
											<img src="../../images/main_img/4.svg" class="top_cycle" />
<!-- 											<img src="../../images/main_img/107.svg" />	 -->
																	
											<c:forEach var="assetTypeList" items="${assetTypeList}" varStatus="j">										
											<c:if test="${assetTypeList.aRowNo eq '1'}">
												<span style="font-size:13px;">${assetTypeList.aAssetModel}</span>
												<p>${assetTypeList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
										<div class="list_graph_ba"><!-- 기반시설-->	
											<img src="../../images/main_img/5.svg" class="top_cycle" />
<!-- 											<img src="../../images/main_img/51.svg" /> -->
											<c:forEach var="assetTypeList" items="${assetTypeList}" varStatus="j">										
											<c:if test="${assetTypeList.aRowNo eq '2'}">
												<span style="font-size:13px;">${assetTypeList.aAssetModel}</span>
												<p>${assetTypeList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
										<div class="list_graph_pc"><!-- pc-->
											<img src="../../images/main_img/8.svg" class="top_cycle" />									
<!-- 											<img src="../../images/main_img/65.svg" /> -->
											<c:forEach var="assetTypeList" items="${assetTypeList}" varStatus="j">										
											<c:if test="${assetTypeList.aRowNo eq '3'}">
												<span style="font-size:13px;">${assetTypeList.aAssetModel}</span>
												<p>${assetTypeList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
										<div class="list_graph_sc"><!-- 보안 -->
											<img src="../../images/main_img/9.svg" class="top_cycle" />
<!-- 											<img src="../../images/main_img/53.svg" /> -->
											<c:forEach var="assetTypeList" items="${assetTypeList}" varStatus="j">										
											<c:if test="${assetTypeList.aRowNo eq '4'}">
												<span style="font-size:13px;">${assetTypeList.aAssetModel}</span>
												<p>${assetTypeList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
										<div class="list_graph_sv"><!-- 서버-->
											<img src="../../images/main_img/10.svg" class="top_cycle" />
<!-- 											<img src="../../images/main_img/63.svg" /> -->
											<c:forEach var="assetTypeList" items="${assetTypeList}" varStatus="j">										
											<c:if test="${assetTypeList.aRowNo eq '5'}">
												<span style="font-size:13px;">${assetTypeList.aAssetModel}</span>
												<p>${assetTypeList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
									</div>	
							
							        
							    </div> 
								<div class="tab_content" id="programming_content">
							        <div id="containerGraph2div" <c:if test="${ass742 eq 'T' || staff.kAdminAuth eq 'T'}"> onclick="moveDetail('/mes/asset/kw_asset_lf.do');" </c:if>>
							       	 <canvas id="containerGraph2"></canvas>
							        </div>
							        
							        <div class="list_graph_1">
										<div class="list_graph_nw"><!-- 네트워크 -->
											<img src="../../images/main_img/4.svg" class="top_cycle" />
<!-- 											<img src="../../images/main_img/107.svg" />	 -->
																	
											<c:forEach var="assetMakerList" items="${assetMakerList}" varStatus="j">										
											<c:if test="${assetMakerList.aRowNo eq '1'}">
												<span style="font-size:13px;">${assetMakerList.aAssetModel}</span>
												<p>${assetMakerList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
										<div class="list_graph_ba"><!-- 기반시설-->	
											<img src="../../images/main_img/5.svg" class="top_cycle" />
<!-- 											<img src="../../images/main_img/51.svg" /> -->
											<c:forEach var="assetMakerList" items="${assetMakerList}" varStatus="j">										
											<c:if test="${assetMakerList.aRowNo eq '2'}">
												<span style="font-size:13px;">${assetMakerList.aAssetModel}</span>
												<p>${assetMakerList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
										<div class="list_graph_pc"><!-- pc-->
											<img src="../../images/main_img/8.svg" class="top_cycle" />									
<!-- 											<img src="../../images/main_img/65.svg" /> -->
											<c:forEach var="assetMakerList" items="${assetMakerList}" varStatus="j">										
											<c:if test="${assetMakerList.aRowNo eq '3'}">
												<span style="font-size:13px;">${assetMakerList.aAssetModel}</span>
												<p>${assetMakerList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
										<div class="list_graph_sc"><!-- 보안 -->
											<img src="../../images/main_img/9.svg" class="top_cycle" />
<!-- 											<img src="../../images/main_img/53.svg" /> -->
											<c:forEach var="assetMakerList" items="${assetMakerList}" varStatus="j">										
											<c:if test="${assetMakerList.aRowNo eq '4'}">
												<span style="font-size:13px;">${assetMakerList.aAssetModel}</span>
												<p>${assetMakerList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
										<div class="list_graph_sv"><!-- 서버-->
											<img src="../../images/main_img/10.svg" class="top_cycle" />
<!-- 											<img src="../../images/main_img/63.svg" /> -->
											<c:forEach var="assetMakerList" items="${assetMakerList}" varStatus="j">										
											<c:if test="${assetMakerList.aRowNo eq '5'}">
												<span style="font-size:13px;">${assetMakerList.aAssetModel}</span>
												<p>${assetMakerList.aAssetCost}</p>
											</c:if>										
											</c:forEach>
										</div>
									</div>
							    </div>
							</div>
		 				</div>	
		 			</div>
		 			<div class="statu">
		 				<div class="main">
		 					<div class="err_text">
		 						<span>유지관리</span>
		 						<div class="err_all">
		 							<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/issue/kw_issue_lf.do');" </c:if> style="cursor:pointer;">viewAll</a>
		 						</div>
<!-- 	 							<div class="err_plus"> -->
<%-- 	 								<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/issue/kw_issue_if.do');" </c:if> style="cursor:pointer;">+</a> --%>
<!-- 	 							</div> -->
		 					</div>
	 					
		 					<ul class="main_statu">
		 						<li class="error">
		 							<label <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/issue/kw_issue_lf.do');" </c:if>>
		 							<span>장애</span>
		 							<div class="err_1">
		 								<em></em>
		 							</div>
		 							<div class="err_2">
		 								<p><strong>${empty mainIssueTotal.eSearchWordA ? 0 : mainIssueTotal.eSearchWordA}건</strong></p>
		 							</div>
		 							</label>
		 						</li>
		 						<li class="change">
		 							<label <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/blueprint/kw_blueprint_lf.do');" </c:if>>
		 							<span>작업</span>
		 							<div class="ch_1">
		 							<em></em>
		 							</div>
		 							<div class="err_2">
		 							<p><strong>${empty mainIssueTotal.eSearchWordB ? 0 : mainIssueTotal.eSearchWordB}건</strong></p>
		 							</div>
		 							</label>
		 						</li>
		 						<li class="problem">
		 							<label <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/blueprint/kw_issue_lf.do');" </c:if>>
		 							<span>문제</span>
		 							<div class="pr_1">
		 							<em></em>
		 							</div>
		 							<div class="err_2">
		 							<p><strong>${empty mainIssueTotal.eSearchWordC ? 0 : mainIssueTotal.eSearchWordC}건</strong></p>
		 							</div>
		 							</label>
		 						</li>
		 						<li class="sr">
		 							<label <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/blueprint/kw_sr_lf.do');" </c:if>>
		 							<span>SR</span>
		 							<div class="sr_1">
		 							<em></em>
		 							</div>
		 							<div class="err_2">
		 							<p><strong>${empty mainIssueTotal.eSearchWordD ? 0 : mainIssueTotal.eSearchWordD}건</strong></p>
		 							</div>
		 							</label>
		 						</li>
		 					</ul>
		 					
		 					
		 					
		 					<div class="num_box"  style="width: 100%;"<c:if test="${ass758 eq 'T' || staff.kAdminAuth eq 'T'}"> onclick="moveDetail('/mes/inspection/kw_inspection_lf.do');"</c:if>>
		 					<div class="num_left_color_1" style="width: 100%;">
		 						<div class="num_2" style="width: 100%;">
		 						<ul style="width: 100%;">
		 							<li>정기정검</li>
		 							<li>
		 								<em>일일</em>
		 								<strong class="text_color_1">${mainIssueTotal.eSearchWordF }건</strong>
		 							</li>
		 							<li>
		 								<em>주간</em>
		 								<strong class="text_color_1">${mainIssueTotal.eSearchWordG }건</strong>
		 							</li>
		 							<li>
		 								<em>월간</em>
		 								<strong class="text_color_1">${mainIssueTotal.eSearchWordH }건</strong>
		 							</li>
		 						</ul>
		 						</div>
		 					</div>	
		 					</div>
		 				</div>
	 					<div class="data">
	 						<div class="err_text">
		 						<span>자산변동</span>
		 						<div class="err_all">
		 							<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/issue/kw_issue_lf.do');" </c:if> style="cursor:pointer;">viewAll</a>
		 						</div>
<!-- 	 							<div class="err_plus"> -->
<%-- 	 								<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/asset/kw_eCondition_if.do');" </c:if> style="cursor:pointer;">+</a> --%>
<!-- 	 							</div> -->
		 					</div>
	 						<div class="num_box" style="width: 100%;" <c:if test="${ass756 eq 'T' || staff.kAdminAuth eq 'T'}"> onclick="moveDetail('/mes/asset/kw_eCondition_lf.do');"</c:if>>
		 						
		 						<div class="num_left_color_2" style="width: 100%;">
		 						<div class="num_2" style="width: 100%;">
		 						<ul style="width: 100%;">
		 							<li>보유자산</li>
		 							<li>
		 								<em>반출</em>
		 								<strong class="text_color_2">${mainIssueTotal.eSearchWordI }건</strong>
		 							</li>
		 							<li>
		 								<em>반입</em>
		 								<strong class="text_color_2">${mainIssueTotal.eSearchWordJ }건</strong>
		 							</li>
		 							<li>
		 								<em>미반입</em>
		 								<strong class="text_color_2">${mainIssueTotal.eSearchWordK }건</strong>
		 							</li>
		 						</ul>
		 						</div>
		 						</div>	
		 					</div>
		 					<div class="num_box" style="width: 100%;" <c:if test="${ass767 eq 'T' || staff.kAdminAuth eq 'T'}"> onclick="moveDetail('/mes/equipment/kw_equipment_in_lf.do');"</c:if>>
		 						<div class="num_left_color_3" style="width: 100%;">
		 						<div class="num_2" style="width: 100%;">
		 						<ul style="width: 100%;">
		 							<li>임시자산</li>
		 							<li>
		 								<em>반입</em>
		 								<strong class="text_color_3">${mainIssueTotal.eSearchWordL }건</strong>
		 							</li>
		 							<li>
		 								<em>반출</em>
		 								<strong class="text_color_3">${mainIssueTotal.eSearchWordM }건</strong>
		 							</li>
		 							<li>
		 								<em>미반출</em>
		 								<strong class="text_color_3">${mainIssueTotal.eSearchWordN }건</strong>
		 							</li>
		 						</ul>
		 						</div>
		 						</div>
		 					</div>
	 					</div>
		 			</div>
		 		</div>
		 		<div class="btm">
		 			<div>
		 				<div class="eos_text">
	 						<span>EoS</span>
	 						<c:if test="${ass742 eq 'T' || staff.kAdminAuth eq 'T'}">
	 						<div class="eos_all">
	 							<a onclick="moveDetail('/mes/asset/kw_asset_lf.do');" style="cursor:pointer;">viewAll</a>
	 						</div>
	 						</c:if>
<!--  							<div class="eos_plus"> -->
<%--  								<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/asset/kw_asset_if.do');" </c:if> style="cursor:pointer;">+</a> --%>
<!--  							</div> -->
	 					</div>
		 				<table  class="dash_table" >
							<thead>
								<tr>
									<th>No.</th>
									<th>대상</th>
									<th>유효기간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="alist" items="${assetEosList}" varStatus="a" end="4">
									<tr <c:if test="${ass742 eq 'T' || staff.kAdminAuth eq 'T'}">  onclick="moveDetail('/mes/asset/kw_asset_vf.do?eAssetKey=${alist.eAssetKey}');" </c:if>>
										<td colspan="1" width="10%">${a.count }</td>
										<td colspan="1">${alist.eAssetModel }</td>
										<td colspan="1">${alist.eEosDate } : ${alist.searchTypeSet1 } </td>
									</tr>
								</c:forEach>
								 <c:forEach var="i" begin="${fn:length(assetEosList) + 1}" end="5">
								      <tr>
								        <td width="10%">${i}</td>
								        <td>-</td>
								        <td>-</td>
								      </tr>
							    </c:forEach>
							</tbody>
						</table>
		 			</div>
		 			<div>
		 				<div class="eos_text">
	 						<span>EoL</span>
	 						<c:if test="${ass742 eq 'T' || staff.kAdminAuth eq 'T'}">
	 						<div class="eos_all">
	 							<a onclick="moveDetail('/mes/asset/kw_asset_lf.do');" style="cursor:pointer;">viewAll</a> 
	 						</div>
	 						</c:if>
<!--  							<div class="eos_plus"> -->
<%--  								<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/asset/kw_asset_if.do');" </c:if> style="cursor:pointer;">+</a> --%>
<!--  							</div> -->
	 					</div>
		 				<table class="dash_table" >
							<thead>
								<tr>
									<th>No.</th>
									<th>대상</th>
									<th>유효기간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="blist" items="${assetEolList}" varStatus="b" end="4">
									<tr <c:if test="${ass742 eq 'T' || staff.kAdminAuth eq 'T'}"> onclick="moveDetail('/mes/asset/kw_asset_vf.do?eAssetKey=${blist.eAssetKey}');" </c:if>>
										<td colspan="1" width="10%">${b.count }</td>
										<td colspan="1">${blist.eAssetModel }</td>
										<td colspan="1">${blist.eEolDate } : ${blist.searchTypeSet2 } </td>
									</tr>
								</c:forEach>
								 <c:forEach var="i" begin="${fn:length(assetEolList) + 1}" end="5">
								      <tr>
								        <td width="10%">${i}</td>
								        <td>-</td>
								        <td>-</td>
								      </tr>
							    </c:forEach>
							</tbody>
						</table>
		 			</div>
		 			<div>
		 				<div class="eos_text">
	 						<span>라이선스</span>
	 						<c:if test="${ass754 eq 'T' || staff.kAdminAuth eq 'T'}">
	 						<div class="eos_all">
	 							<a onclick="moveDetail('/mes/asset/kw_Software_Register_lf.do');" style="cursor:pointer;">viewAll</a> 
	 						</div>
	 						</c:if>
<!--  							<div class="eos_plus"> -->
<%--  								<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/asset/kw_Software_Register_if.do');" </c:if> style="cursor:pointer;">+</a> --%>
<!--  							</div> -->
	 					</div>
		 				<table class="dash_table" >
							<thead>
								<tr>
									<th>No.</th>
									<th>대상</th>
									<th>유효기간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="clist" items="${mainSoftwareList}" varStatus="c" end="4">
									<tr <c:if test="${ass754 eq 'T' || staff.kAdminAuth eq 'T'}">  onclick="moveDetail('/mes/asset/kw_Software_Register_vf.do?eSWRegisterKey=${clist.eSWRegisterKey}');" </c:if>>
										<td colspan="1" width="10%">${c.count }</td>
										<td colspan="1">${clist.eProductName }</td>
										<td colspan="1">${clist.eEndDate } : ${clist.searchTypeSet1 } </td>
									</tr>
								</c:forEach>
								 <c:forEach var="i" begin="${fn:length(mainSoftwareList) + 1}" end="5">
								      <tr>
								        <td width="10%">${i}</td>
								        <td>-</td>
								        <td>-</td>
								      </tr>
							    </c:forEach>
							</tbody>
						</table>
		 			</div>
		 			<div>
		 				<div class="eos_text">
	 						<span>노후장비</span>
	 						<c:if test="${ass742 eq 'T' || staff.kAdminAuth eq 'T'}">
	 						<div class="eos_all">
	 							<a onclick="moveDetail('/mes/asset/kw_asset_lf.do');"style="cursor:pointer;">viewAll</a> 
	 						</div>
	 						</c:if> 
<!--  							<div class="eos_plus"> -->
<%--  								<a <c:if test="${ass766 eq 'T' || staff.kAdminAuth eq 'T'}">onclick="moveDetail('/mes/asset/kw_asset_if.do');" </c:if> style="cursor:pointer;">+</a> --%>
<!--  							</div> -->
	 					</div>
		 				<table class="dash_table" >
							<thead>
								<tr>
									<th>No.</th>
									<th>대상</th>
									<th>도입일자(내구연수)</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dlist" items="${mainLifeStatusList}" varStatus="d" end="4">
									<tr <c:if test="${ass742 eq 'T' || staff.kAdminAuth eq 'T'}"> onclick="moveDetail('/mes/asset/kw_asset_vf.do?eAssetKey=${dlist.eAssetKey}');" </c:if>>
										<td colspan="1" width="10%">${d.count }</td>
										<%--	<td colspan="1">${dlist.aAssetName }</td>   --%>
										<td colspan="1">${dlist.aAssetModel }</td>
										<td colspan="1">${dlist.eAssetDate }(${dlist.eLifespan }) </td>
									</tr>
								</c:forEach>
								 <c:forEach var="i" begin="${fn:length(mainLifeStatusList) + 1}" end="5">
								      <tr>
								        <td width="10%">${i}</td>
								        <td>-</td>
								        <td>-</td>
								      </tr>
							    </c:forEach>
							</tbody>
						</table>
		 			</div>
		 		</div>
		 	</div>
		</div>
	</form>

							
						<c:forEach var="assetMakerList" items="${assetMakerList}" varStatus="j">
							<input type="hidden" id="aAssetMaker_${j.index}" name="aAssetMaker" value="${assetMakerList.aAssetMaker}">
							<input type="hidden" id="aAssetCost_${j.index}" name="aAssetCost" value="${assetMakerList.aAssetCost}">
						</c:forEach>
						<c:forEach var="assetTypeList" items="${assetTypeList}" varStatus="j">
							<input type="hidden" id="aAssetType_${j.index}" name="aAssetType" value="${assetTypeList.aAssetType}">
							<input type="hidden" id="aAssetTypeCost_${j.index}" name="aAssetTypeCost" value="${assetTypeList.aAssetCost}">
						</c:forEach>

<script>
window.onload = function() {
	  // 데이터 추출
	  const sAssetTypeCost = document.getElementsByName('aAssetTypeCost');
	  const sAssetTypeCostValue = Array.from(sAssetTypeCost).map(el => parseInt(el.value));

	  const sAssetType = document.getElementsByName('aAssetType');
	  const sAssetTypeValue = Array.from(sAssetType).map(el => el.value);

	  const sAssetmcCount = document.getElementsByName('aAssetCost');
	  const sAssetmcCountValue = Array.from(sAssetmcCount).map(el => parseInt(el.value));

	  const sAssetMaker = document.getElementsByName('aAssetMaker');
	  const sAssetMakerValue = Array.from(sAssetMaker).map(el => el.value);

	  // ctx 변수 이름 분리 (중복 방지)
	  const ctx1 = document.getElementById('containerGraph1').getContext('2d');
	  const ctx2 = document.getElementById('containerGraph2').getContext('2d');

	  var maxY1 = 0;

	  if (Array.isArray(sAssetTypeCostValue) && sAssetTypeCostValue.length > 0) {
	    maxY1 = Math.max.apply(null, sAssetTypeCostValue);
	  }

		var yTicks1 = {
		  min: 0,
		  beginAtZero: true,
		  fontColor: '#6A6D75'
		};
		
		if (maxY1 <= 6) {
		  yTicks1.stepSize = 1;
		  yTicks1.max = 6;
		}
		
	   var maxY2 = 0;

	    if (Array.isArray(sAssetmcCountValue) && sAssetmcCountValue.length > 0) {
	      maxY2 = Math.max.apply(null, sAssetmcCountValue);
	    }

		var yTicks2 = {
		  min: 0,
		  beginAtZero: true,
		  fontColor: '#6A6D75'
		};
		
		if (maxY2 <= 6) {
		  yTicks2.stepSize = 1;
		  yTicks2.max = 6;
		}
		
	  // containerGraph1: sAssetTypeValue + sAssetTypeCostValue 사용, 막대그래프
	  new Chart(ctx1, {
		  type: 'bar',
		  data: {
		    labels: sAssetTypeValue,
		    datasets: [{
		      label: '식',
		      data: sAssetTypeCostValue,
		      backgroundColor: [
		        '#013d92', '#005cd3', '#a28cf8', '#37afc5', '#fdbf00',
		        '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'
		      ],
		      borderWidth: 2,
		      borderColor: '#fff'
		    }]
		  },
		  options: {
		    responsive: true,
		    maintainAspectRatio: false,
		    legend: { display: false },
		
		    scales: {
		      yAxes: [{
		        ticks: yTicks1,
		        gridLines: {
		          display: true
		        }
		      }],
		      xAxes: [{
		        ticks: {
		          fontColor: '#6A6D75',
		          callback: function(value) {
		            return value.length > 12 ? value.substring(0, 12) + '...' : value;
		          }
		        },
		        gridLines: {
		          display: false
		        }
		      }]
		    },
		
		    tooltips: {
		      callbacks: {
		        label: function(tooltipItem) {
		          return Math.round(tooltipItem.yLabel) + '식';
		        }
		      }
		    }
		  }
		});

	  // containerGraph2: sAssetMakerValue + sAssetmcCountValue 사용, 막대그래프
	  new Chart(ctx2, {
		  type: 'bar',
		  data: {
		    labels: sAssetMakerValue,
		    datasets: [{
		      label: '식',
		      data: sAssetmcCountValue,
		      backgroundColor: [
		        '#013d92', '#005cd3', '#a28cf8', '#37afc5', '#fdbf00',
		        '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'
		      ],
		      borderWidth: 2,
		      borderColor: '#fff'
		    }]
		  },
		  options: {
		    responsive: true,
		    maintainAspectRatio: false,
		    legend: { display: false },
		
		    scales: {
		      yAxes: [{
		        ticks: yTicks2,
		        gridLines: {
		          display: true
		        }
		      }],
		      xAxes: [{
		        ticks: {
		          fontColor: '#6A6D75',
		          callback: function(value) {
		            return value.length > 12 ? value.substring(0, 12) + '...' : value;
		          }
		        },
		        gridLines: {
		          display: false
		        }
		      }]
		    },
		
		    tooltips: {
		      callbacks: {
		        label: function(tooltipItem) {
		          return Math.round(tooltipItem.yLabel) + '식';
		        }
		      }
		    }
		  }
		});
	};
	
	const savedValue = document.getElementById('selectedDateBtnValue').value;
	if (savedValue) {
		applyActiveButton(savedValue);
	}
 </script>


<style>
/* 대시보드 화면 넓게보기 */
/* [1] 최상위 레이아웃 및 브라우저 깨짐 방지 */
#main_container {
    min-width: 1200px !important;
    width: 100% !important;
    padding: 63px 32px 12px 80px !important; /* 좌측 80px은 햄버거 버튼 공간 */
    transition: padding-left 0.3s ease;
}

/* [2] 사이드바 및 토글 상태 제어 */
#side-nav {
    left: -260px !important;
    transition: left 0.3s ease !important;
}
body.nav-open #side-nav {
    left: 0 !important;
}
body.nav-open #main_container {
    padding-left: 280px !important; /* 사이드바 열릴 때 여백 복구 */
    min-width: 1480px !important; 
}

/* [3] 대시보드 메인 컨테이너 */
#mes_container {
    width: 100% !important;
    max-width: none !important;
    margin: 0 !important;
    padding: 10px !important;
}

/* [4] 대시보드 행(Row) 설정: 높이 균등화(Stretch) */
.dashboard_wrap, 
.dashboard_wrap .top, 
.dashboard_wrap .btm {
    width: 100% !important;
    display: flex !important;
    flex-wrap: nowrap !important; /* 박스 떨어짐 방지 */
    gap: 20px;
}

.dashboard_wrap .top {
    align-items: stretch !important; /* 모든 박스 높이를 가장 큰 박스에 맞춤 */
}

/* [5] 박스 공통 설정 및 너비 배분 */
.dashboard_wrap .top > div, 
.dashboard_wrap .btm > div {
    display: flex !important;
    flex-direction: column !important;
    min-width: 200px !important;
    height: auto !important;
}

/* 윗줄(top) 3분할 / 아랫줄(btm) 4분할 */
.dashboard_wrap .top > div { flex: 1 1 calc(33.333% - 20px) !important; max-width: 33.333% !important; }
.dashboard_wrap .btm > div { flex: 1 1 calc(25% - 20px) !important; max-width: 25% !important; }

/* [6] 첫 번째 박스 (테이블 & 제목 보호) */
.dashboard_wrap .top > div:nth-child(1) .err_text {
    flex: 0 0 auto !important; /* 제목 영역 찌그러짐 방지 */
    width: 100% !important;
}

.dashboard_wrap .top > div:nth-child(1) > div:not(.err_text) {
    flex-grow: 1 !important; /* 제목 제외 나머지 영역 확장 */
    display: flex !important;
    flex-direction: column !important;
}

.dashboard_wrap .top > div:nth-child(1) .dash_table {
    flex-grow: 1 !important;
    height: 100% !important;
    width: 100% !important;
    table-layout: fixed !important;
}

/* [7] 두 번째 박스 (Chart.js 그래프) */
#containerGraph1div, #containerGraph2div {
    width: 100% !important;
    height: 300px !important; /* 그래프 높이 기준 */
    position: relative;
}
#containerGraph1, #containerGraph2 { width: 100% !important; height: 100% !important; }


/* [9] 탭 컨텐츠 및 공통 테이블 */
.tab_content { width: 100% !important; }
.tab_content.active { display: block !important; }
.dash_table { width: 100% !important; }

/* [10] 햄버거 토글 버튼 디자인 */
#menu-toggle-btn {
    position: fixed !important;
    bottom: 30px !important;
    left: 30px !important;
    z-index: 999999 !important;
    width: 50px;
    height: 50px;
    background: #101935;
    color: white;
    border-radius: 50%;
    border: none;
    cursor: pointer;
    box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    opacity: 0.7;
    transition: all 0.3s;
}
#menu-toggle-btn:hover { opacity: 1; transform: scale(1.1); background: #4869fb; }
</style>