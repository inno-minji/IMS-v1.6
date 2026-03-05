<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<meta http-equiv="refresh" content="900">
<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />
<script src="/js/Chart/ChartB.js"></script>
<script src="/js/highchart/code/modules/exporting.js"></script>
<script src="/js/highchart/code/modules/export-data.js"></script>

<script type="text/javascript">
	$(document).ready(function(){	
		eDivCheck();
		datepickerSet('topStartDate', 'topEndDate');
	});	
	
	function eDivCheck(){
		var eNowPageNum = Number("${mesStatisticsVO.ePageGubun}");
		if(eNowPageNum == 1){
			document.getElementById("div1").style.display = "block";
			document.getElementById("div2").style.display = "none";
			document.getElementById("div3").style.display = "none";
		}
		if(eNowPageNum == 2){
			document.getElementById("div1").style.display = "none";
			document.getElementById("div2").style.display = "block";
			document.getElementById("div3").style.display = "none";
		}
		if(eNowPageNum == 3){
			document.getElementById("div1").style.display = "none";
			document.getElementById("div2").style.display = "none";
			document.getElementById("div3").style.display = "block";
		}
		 
	}
	
	function setStartDate(d) {
	    var settingDate = new Date();
	    if(d == '7'){
	        settingDate.setDate(settingDate.getDate()-7);
	    	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	    }else if(d == '1'){
	        settingDate.setMonth(settingDate.getMonth()-1);
	    	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	    }else{
	        settingDate.setMonth(settingDate.getMonth()-3);
	    	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	    }
	}
	
	// 현재날짜
	function nowDate(){
	    var date = new Date();
	    var year = date.getFullYear();
	    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
	    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
	    var nowDate = year + "-" + month + "-" + day;
		
	    return nowDate;
	}
	/* 페이징 */
	function fn_guestList(pageNo) {
		$('#mloader').show();
		document.frm.submit();
	}

	function showDiv(divId) {
	    // Hide all divs
	    document.getElementById('div1').style.display = 'none';
	    document.getElementById('div2').style.display = 'none';
	    document.getElementById('div3').style.display = 'none';
	    
	    // Show the selected div
	    document.getElementById(divId).style.display = 'block';
	}
</script>

<style>
	td{
		text-align:center;
	}
	
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 310px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	#container {
	    height: 400px;
	}
	
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
	
	.graph-container {
	    display: flex;
	    justify-content: space-between;
	}
	
	.graph {
	    width: 45%; /* 그래프의 너비 조정 */
	    margin: 10px; /* 그래프 간격 조정 */
	}
</style>

<form id="frm" name="frm" method="post" action="/mes/statistics/kw_outputs_lf.do">
	
	<div class="content_top">
		<div class="content_tit">
			<h2>산출물통계</h2>
		</div>
		<div class="filter_wrap"> 
			<div class="search_filter">
				<ul> 
					<li>
		           		<span>사업기간기간 </span>
		           		<div class="date">
		           			<input type="text" class='inp_color' name="topStartDate" style="width:120px; text-align:center;" id="topStartDate" value="${mesStatisticsVO.topStartDate}" readonly/>
				       		-
				           	<input type="text" class='inp_color' name="topEndDate" style="width:120px; text-align:center;"  id="topEndDate"  value="${mesStatisticsVO.topEndDate}" readonly/>
		           		</div>
					</li>
				</ul>
			</div>
			<div class="button_wrap">
				<button type="button" class="form_btn bg" onclick="fn_guestList(1)">검색</button>
			</div>
		</div>
	</div>
	
	<div class="graph-container">
	     <div id="containerGraph1Div" class="graph" style="cursor:pointer;" onclick="showDiv('div1')">
	     <canvas id="containerGraph1" width="400" height="286"></canvas></div>
	    <div id="containerGraph2Div" class="graph" style="cursor:pointer;" onclick="showDiv('div2')">
	    <canvas id="containerGraph2" width="400" height="286"></canvas></div>
	</div>
	
	<div id="div1"  style="display: block;" >
		<div class="normal_table">
	 		<table>
	   		   <thead>
   		  		<tr> 
	   		  		<th rowspan="2">프로젝트명</th>
	   		  		<th colspan="4"> 산출물 </th>
	   		  		
  		  		</tr>
  		  		<tr>
  		  			<th class="bl">착수</th>
	   		  		<th>수행</th>
	   		  		<th>완료</th>
	   		  		<th>합계</th>
  		  		</tr>
	   		  </thead>
	   		  <tbody>
	   		 	<c:forEach var="outputList" items="${outputList}" varStatus="status1">
	   		 		<c:if test="${outputList.eValueD != 0}">
	  		  			<tr> 
			   		  		<td>
								<c:out value="${outputList.eWordA}" />
								<input type="hidden" id="eWordA_${status1.index}" name="eWordA" value="${outputList.eWordA}">
								<input type="hidden" id="eValueD_${status1.index}" name="eValueD" value="${outputList.eValueD}">
							</td>
							<td>
			   		  			 ${outputList.eValueA} 
							</td>
							<td>
			   		  			 ${outputList.eValueB} 
							</td>
							<td>
			   		  			 ${outputList.eValueC} 
							</td>
							<td>
			   		  			 ${outputList.eValueD} 
							</td>
						</tr>
						
	   		 		</c:if>
				</c:forEach>
	   		  </tbody>
			</table>
		</div>
	</div>

	<div id="div2"  style="display: none;" >
		<div class="normal_table">
	 		<table>
	   		  <thead>
	   		  	<tr> 
	   		  		<th rowspan="2">프로젝트명</th>
	   		  		<th colspan="5"> 보고서 </th>
	   		  		
  		  		</tr>
  		  		<tr>
  		  			<th  class="bl">주간</th>
	   		  		<th>월간</th>
	   		  		<th>분기</th>
	   		  		<th>반기</th>
	   		  		<th>합계</th>
  		  		</tr>
	   		  </thead>
	   		  <tbody>
	   		 	<c:forEach var="projectList" items="${projectList}" varStatus="status2">
	   		 		<c:if test="${projectList.eValueE != 0}">
	  		  			<tr> 
			   		  		<td>
								<c:out value="${projectList.eWordA}" />
								<input type="hidden" id="eWordB_${status2.index}" name="eWordB" value="${projectList.eWordA}">
								<input type="hidden" id="eValueB_${status2.index}" name="eValueB" value="${projectList.eValueE}">
							</td>
							<td>
			   		  			 ${projectList.eValueA} 
							</td>
							<td>
			   		  			 ${projectList.eValueB} 
							</td>
							<td>
			   		  			 ${projectList.eValueC} 
							</td>
							<td>
			   		  			 ${projectList.eValueD} 
							</td>
							<td>
			   		  			 ${projectList.eValueE} 
							</td>
						</tr>
						</c:if>
				</c:forEach>
	   		  </tbody>
			</table>
		</div>
	</div>

	<div id="div3"  style="display: none;" >
		<div class="normal_table">
	 		<table>
	   		  <thead>
	   		  	<tr> 
	   		  		<th>사용자명</th>
	   		  		<th>건수</th>
  		  		</tr>
	   		  </thead>
	   		  <tbody>
	   		 	<c:forEach var="outputsmemList" items="${outputsmemList}" varStatus="status1">
	   		 		<c:if test="${outputsmemList.kStaffName ne ''}"> 
	  		  			<tr> 
			   		  		<td>
								<c:out value="${outputsmemList.kStaffName}" />
							</td>
							<td>
			   		  			 ${outputsmemList.sOutputCount} 
							</td>
						</tr>
						</c:if>
	  		  		</c:forEach>
	   		  </tbody>
			</table>
		</div>
	</div>
	
	<c:forEach var="outputsyList" items="${outputsyList}" varStatus="i">
		<c:if test="${outputsyList.sOutputCount > 0}">
		<input type="hidden" id="sYear_${i.index}" name="sYear" value="${outputsyList.sYear}">
		<input type="hidden" id="sOutputYCount_${i.index}" name="sOutputYCount" value="${outputsyList.sOutputCount}">
		</c:if>
	</c:forEach>

	<c:forEach var="outputsmList" items="${outputsmList}" varStatus="i">
		<c:if test="${outputsmList.sOutputCount > 0}">
		<input type="hidden" id="eDate_${i.index}" name="eDate" value="${outputsmList.eDate}">
		<input type="hidden" id="sOutputmCount_${i.index}" name="sOutputmCount" value="${outputsmList.sOutputCount}">
		</c:if>
	</c:forEach>

	<c:forEach var="outputsmemList" items="${outputsmemList}" varStatus="i">
		<c:if test="${outputsmemList.sOutputCount > 0}">
		<input type="hidden" id="kStaffName_${i.index}" name="kStaffName" value="${outputsmemList.kStaffName}">
		<input type="hidden" id="sOutputmemCount_${i.index}" name="sOutputmemCount" value="${outputsmemList.sOutputCount}">
		</c:if>
	</c:forEach>
	
	<c:forEach var="environmentList" items="${environmentList}" varStatus="i">
		<input type="hidden" id="maxtemperature_${i.index}" name="maxtemperature" value="${environmentList.maxtemperature}">
		<input type="hidden" id="mintemperature_${i.index}" name="mintemperature" value="${environmentList.mintemperature}">
		<input type="hidden" id="environmentName_${i.index}" name="environmentName" value="${environmentList.environmentName}">
	</c:forEach>
</form>



<script>
	const eMachineDate = document.getElementsByName('eDate');
	const eMachineDateValue = Array.from(eMachineDate).map(eMachineDate => eMachineDate.value);

	const sYear = document.getElementsByName('sYear');
	const sYearValue = Array.from(sYear).map(sYear => sYear.value);
	
	const sOutputYCount = document.getElementsByName('sOutputYCount');
	const sOutputYCountValue = Array.from(sOutputYCount).map(sOutputYCount => parseInt(sOutputYCount.value));
	
	const sOutputmCount = document.getElementsByName('sOutputmCount');
	const sOutputmCountValue = Array.from(sOutputmCount).map(sOutputmCount => parseInt(sOutputmCount.value));
	
	const kStaffName = document.getElementsByName('kStaffName');
	const kStaffNameValue = Array.from(kStaffName).map(kStaffName => kStaffName.value);

	const sOutputmemCount = document.getElementsByName('sOutputmemCount');
	const sOutputmemCountValue = Array.from(sOutputmemCount).map(sOutputmemCount => parseInt(sOutputmemCount.value));
	
	const eWordA = document.getElementsByName('eWordA');
	const eWordAValue = Array.from(eWordA).map(eWordA => eWordA.value);

	const eValueD = document.getElementsByName('eValueD');
	const eValueDCountValue = Array.from(eValueD).map(eValueD => parseInt(eValueD.value));

	function uncomma(str) {
	    str = String(str);
	    return isNullChk(str.replace(/(,)/g, ''));
	}
	var ctx = document.getElementById('containerGraph1').getContext('2d');

	var chart1 = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: eWordAValue.map(label => {
	            const maxLen = 12;
	            return label.length > maxLen ? label.substring(0, maxLen) + '...' : label;
	        }), // x축 라벨을 12자 이하로 자르고, 길면 '...' 추가
	        datasets: [{
	            label: '산출물 등록 건',
	            data: eValueDCountValue, // 등록 건수 배열
	            backgroundColor: [
	            	'#CC705C', '#4DCC4D', '#3C61CC', '#CC5291', '#CC6529',
	            	  '#66CC29', '#2999CC', '#CCCC52', '#CC5291', '#6E3F3F',
	            	  '#CCAA29', '#4DCC4D', '#CC654D', '#CC4529', '#3D6E50',
	            	  '#29A629', '#CC7BA3', '#7A91CC', '#A0521A', '#843DCB'
	            ], // 파스텔톤 색상 배열
	            borderColor: '#fff', // 막대 간 경계선 색상
	            borderWidth: 2
	        }]
	    },
	    options: {
	    	legend: {
		          display: false 
		        },	    	
	        responsive: true,
	        title: {
	            display: true,
	            text: '산출물 등록 건',
	            fontSize: 16,
	            fontStyle: 'bold',
	            fontFamily: 'Pretendard',
	            fontColor: '#171D2F'
	        },
	        tooltips: {
	            callbacks: {
	                label: function(tooltipItem, data) {
	                    var dataset = data.datasets[tooltipItem.datasetIndex];
	                    var value = dataset.data[tooltipItem.index];
	                    return '' + data.labels[tooltipItem.index] + ' : ' + value + '건';
	                }
	            }
	        },
	        scales: {
	            xAxes: [{
	                ticks: {
	                    fontFamily: 'Pretendard',
	                    fontSize: 13,
	                    fontColor: '#6A6D75',
	                    autoSkip: true, // 자동으로 x축 라벨을 잘라서 표시
	                }
	            }],
	            yAxes: [{
	                ticks: {
	                    beginAtZero: true,
	                    fontFamily: 'Pretendard',
	                    fontSize: 13,
	                    fontColor: '#6A6D75',
	                    callback: function(value) {
	                        return value + ' 건'; // y축 값에 '건' 추가
	                    }
	                }
	            }]
	        },
	        responsiveAnimationDuration: 1000
	    }
	});
	
	
	const eWordB = document.getElementsByName('eWordB');
	const eWordBValue = Array.from(eWordB).map(eWordB => eWordB.value);

	const eValueB = document.getElementsByName('eValueB');
	const eValueBCountValue = Array.from(eValueB).map(eValueB => parseInt(eValueB.value));
	
	var ctx = document.getElementById('containerGraph2').getContext('2d');

	var chart2 = new Chart(ctx, {
	    type: 'pie',
	    data: {
	        labels: eWordBValue.map(label => {
	            const maxLen = 12;
	            return label.length > maxLen ? label.substring(0, maxLen) + '...' : label;
	        }), // 라벨이 12자 이상일 경우 '...' 추가
	        datasets: [{
	            label: '보고서 등록 건',
	            data: eValueBCountValue, // 등록 건수 배열
	            backgroundColor: [
	            	'#CC705C', '#4DCC4D', '#3C61CC', '#CC5291', '#CC6529',
	            	  '#66CC29', '#2999CC', '#CCCC52', '#CC5291', '#6E3F3F',
	            	  '#CCAA29', '#4DCC4D', '#CC654D', '#CC4529', '#3D6E50',
	            	  '#29A629', '#CC7BA3', '#7A91CC', '#A0521A', '#843DCB'
	            ], // 파스텔톤 색상 배열
	            borderColor: '#fff', // 섹션 간의 경계선 색상
	            borderWidth: 2
	        }]
	    },
	    options: {
	        responsive: true,
	        title: {
	            display: true,
	            text: '보고서 등록 건',
	            fontSize: 16,
	            fontStyle: 'bold',
	            fontFamily: 'Pretendard',
	            fontColor: '#171D2F'
	        },
	        tooltips: {
	            callbacks: {
	                label: function(tooltipItem, data) {
	                    var dataset = data.datasets[tooltipItem.datasetIndex];
	                    var value = dataset.data[tooltipItem.index];
	                    return '' + data.labels[tooltipItem.index] + ' : ' + value + '건';
	                }
	            }
	        },
	        responsiveAnimationDuration: 1000,
	        plugins: {
	            labels: {
	                render: 'percentage',
	                fontSize: 13,
	                fontFamily: 'Pretendard',
	                fontColor: '#6A6D75',
	                fontStyle: 'normal',
	                precision: 2
	            }
	        }
	    }
	});
	
	
 
</script>