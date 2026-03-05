<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<meta http-equiv="refresh" content="900">
<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />

<!-- 그리드 S -->
<link href="/css/mes/jquery-ui.min.css" rel="stylesheet"	type="text/css" />
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
    td {
        text-align: center;
    }
    
    .graph-container {
        display: flex;
        justify-content: space-between;
        min-height: calc(100vh - 300px); 
    }
    
    .graph {
        width: 48%; 
        margin: 10px; 
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .chart-wrapper {
        display: flex;
        align-items: center;
        padding: 20px;
        width: 100%;
        height: 100%;
        box-sizing: border-box;
    }

    .chart-area {
        width: 65%; 
        height: 420px; 
        position: relative;
        display: flex;
        justify-content: center;
    }

    .legend-area {
        width: 35%; 
        max-height: 400px; 
        overflow-y: auto;
        overflow-x: hidden;
        border: 1px solid #e2e2e2;
        border-radius: 8px;
        padding: 15px;
        box-sizing: border-box;
    }

</style>

<form id="frm" name="frm" method="post" action="/mes/statistics/kw_asset_us_lf.do">
	
	<div class="content_top">
		<div class="content_tit">
			<h2>자산 반출입통계</h2>
		</div>
		<div class="filter_wrap"> 
			<div class="search_filter">
				<ul> 
<!-- 				<li> -->
<!-- 	          		<span>조회 구분</span> -->
<!-- 					<select name="ePageGubun" id="ePageGubun" onchange="eNowPage()"> -->
<%-- 						<option value="1" <c:if test="${mesStatisticsVO.ePageGubun eq '1'}">selected</c:if>>사용자기준</option> --%>
<%-- 						<option value="2" <c:if test="${mesStatisticsVO.ePageGubun eq '2'}">selected</c:if>>유형별기준</option> --%>
<%-- 						<option value="3" <c:if test="${mesStatisticsVO.ePageGubun eq '3'}">selected</c:if>>기간별</option> --%>
<!-- 			      	</select> -->
<!-- 			    </li> -->
					<li>
		           		<span>기간 </span>
		           		<div class="date">
		           			<input type="text" class='inp_color' name="topStartDate" id="topStartDate" value="${mesStatisticsVO.topStartDate}" readonly/>
				       		-
				           	<input type="text" class='inp_color' name="topEndDate" id="topEndDate"  value="${mesStatisticsVO.topEndDate}" readonly/>
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
    <div id="containerGraph1Div" class="graph">
        <div class="chart-wrapper">
            <div class="chart-area">
                <canvas id="containerGraph1"></canvas>
            </div>
            <div class="legend-area">
                <ul id="customLegend1" style="list-style: none; padding: 0; margin: 0;"></ul>
            </div>
        </div>
    </div>

    <div id="containerGraph2Div" class="graph">
        <div class="chart-wrapper">
            <div class="chart-area">
                <canvas id="containerGraph2"></canvas>
            </div>
            <div class="legend-area">
                <ul id="customLegend2" style="list-style: none; padding: 0; margin: 0;"></ul>
            </div>
        </div>
    </div>
</div>
	
	<div id="div1"  style="display: none;" >
		<div class="normal_table">
	 		<table>
	   		  <thead>
	   		  	<tr> 
	   		  		<th>제조사</th>
	   		  		<th>반출 건수</th>
	   		  		<th>미반입 건수</th>
  		  		</tr>
	   		  </thead>
	   		   <tbody>
	   		 	<c:forEach var="iMakerList" items="${iMakerList}" varStatus="a">
	  		  			<tr>
				   		 	<td>${iMakerList.eWordA}
								<input type="hidden" id="eWordA_${a.index}" name="eWordA" value="${iMakerList.eWordA}">
								<input type="hidden" id="eValueA_${a.index}" name="eValueA" value="${iMakerList.eValueA}">
								<input type="hidden" id="eWordB_${a.index}" name="eValueB" value="${iMakerList.eValueB}">
							</td>
				   		 	<td>${iMakerList.eValueA}</td>
				   		 	<td>${iMakerList.eValueB}</td>
								
						</tr>
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
	   		  		<th>자산유형</th>
	   		  		<th>반출 건수</th>
	   		  		<th>미반입 건수</th>
  		  		</tr>
	   		  </thead>
	   		   <tbody>
	   		 	<c:forEach var="iTypeList" items="${iTypeList}" varStatus="b">
	  		  			<tr> 
			   		  		<td>${iTypeList.eWordB}
								<input type="hidden" id="eWordB_${b.index}" name="eWordB" value="${iTypeList.eWordB}">
								<input type="hidden" id="eValueC_${b.index}" name="eValueC" value="${iTypeList.eValueC}">
								<input type="hidden" id="eValueD_${b.index}" name="eValueD" value="${iTypeList.eValueD}">
							</td>
				   		 	<td>${iTypeList.eValueC}</td>
				   		 	<td>${iTypeList.eValueD}</td>
						</tr>
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
	   		  		<th>기간</th>
	   		  		<th>건수</th>
	  		  		</tr>
	   		  </thead>
	   		  <tbody>
	   		 	<c:forEach var="statisticsList" items="${statisticsList}" varStatus="status1">
	   		 		<c:if test="${statisticsList.mMaintanceCount > 0}"> 
	  		  			<tr> 
			   		  		<td>
								<c:out value="${statisticsList.eDate}" />
							</td>
							<td>
			   		  			 ${statisticsList.mMaintanceCount} 
							</td>
						</tr>
						</c:if>
	  		  		</c:forEach>
	   		  </tbody>
			</table>
		</div>
	</div>
</form>



<script>
	const eMachineDate = document.getElementsByName('eDate');
	const eMachineDateValue = Array.from(eMachineDate).map(eMachineDate => eMachineDate.value);
 
	const Countst = document.getElementsByName('Countst');
	const CountstValue = Array.from(Countst).map(Countst => parseInt(Countst.value));
 
	
	
// 	--
	const eValueA = document.getElementsByName('eValueA');
	const eValueAValue = Array.from(eValueA).map(eValueA => parseInt(eValueA.value));

	const eWordAa = document.getElementsByName('eWordA');
	const eWordAValuea = Array.from(eWordAa).map(eWordAa => eWordAa.value);
	 
	
	function uncomma(str) {
	    str = String(str);
	    return isNullChk(str.replace(/(,)/g, ''));
	}
    const pieColors_old = [
        '#CC705C', '#4DCC4D', '#3C61CC', '#CC5291', '#CC6529',
        '#66CC29', '#2999CC', '#CCCC52', '#CC5291', '#6E3F3F',
        '#CCAA29', '#4DCC4D', '#CC654D', '#CC4529', '#3D6E50',
        '#29A629', '#CC7BA3', '#7A91CC', '#A0521A', '#843DCB'
    ];
	const pieColors = [
        '#4869fb', '#1fccb4', '#ff8c42', '#f9d857', '#9c6dfb', 
        '#6f9df9', '#f96d6d', '#4ed99b', '#3d60f9', '#f96df9', 
        '#5acdf9', '#a9e98d', '#2638a9', '#d96df9', '#8dd8f9', 
        '#a1b8d9', '#29b4d9', '#b98df9', '#8df9e9', '#cbd9e9'  
    ];


    let chart1Labels = [];
    let chart1Data = [];
    let chart1BgColors = [];
    let otherCount1 = 0; // 기타(나머지)

    const isOverSix2 = eWordAValuea.length >= 7;

    for (let i = 0; i < eWordAValuea.length; i++) {
        if (isOverSix2 && i >= 5) {
            otherCount1 += eValueAValue[i];
        } else {
            chart1Labels.push(eWordAValuea[i]);
            chart1Data.push(eValueAValue[i]);
            chart1BgColors.push(pieColors[i % pieColors.length]);
        }
    }

    if (isOverSix2) {
        chart1Labels.push('기타');
        chart1Data.push(otherCount1);
        chart1BgColors.push('#d1d5db');
    }

    var ctx1 = document.getElementById('containerGraph1').getContext('2d');
    var chart1 = new Chart(ctx1, {
        type: 'pie',
        data: {
            labels: chart1Labels,
            datasets: [{
                label: '제조사별 반출 건',
                data: chart1Data,
                backgroundColor: chart1BgColors,
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            layout: { padding: 0 },
            title: { display: true, text: '제조사별 반출 건', fontSize: 16, fontStyle: 'bold', fontFamily: 'Pretendard', fontColor: '#171D2F' },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        var dataset = data.datasets[tooltipItem.datasetIndex];
                        var value = dataset.data[tooltipItem.index];
                        return '' + data.labels[tooltipItem.index] + ' : ' + value + '건'; 
                    }
                }
            },
            legend: { display: false },
            responsiveAnimationDuration: 1000
        }
    });

    
    let legendHtml1 = '';
    for (let i = 0; i < eWordAValuea.length; i++) {
        //  let color = pieColors[i % pieColors.length];
          let color = (isOverSix2 && i >= 5) ? '#d1d5db' : pieColors[i % pieColors.length];
          
        let fullName = eWordAValuea[i];
        let shortName = fullName.length > 15 ? fullName.substring(0, 15) + '...' : fullName;

        legendHtml1 += '<li style="display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px solid #f4f4f4;">' +
            '<div style="display: flex; align-items: center; flex: 1; min-width: 0; padding-right: 10px;">' + 
                '<span style="display: inline-block; flex-shrink: 0; width: 12px; height: 12px; background-color: ' + color + '; margin-right: 8px; border-radius: 2px;"></span>' +
                '<span title="' + fullName + '" style="font-size: 13px; font-family: \'Pretendard\'; color: #555; display: block; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; min-width: 0;">' + shortName + '</span>' +
            '</div>' +
            '<span style="font-size: 13px; font-weight: bold; font-family: \'Pretendard\'; flex-shrink: 0;">' + eValueAValue[i] + '건</span>' +
        '</li>';
    }
    document.getElementById('customLegend1').innerHTML = legendHtml1;


    const eValueB = document.getElementsByName('eValueC');
    const eValueBValue = Array.from(eValueB).map(eValueB => parseInt(eValueB.value)); 

    const eWordBa = document.getElementsByName('eWordB'); 
    const eWordBValuea = Array.from(eWordBa).map(eWordBa => eWordBa.value);


    var ctx2 = document.getElementById('containerGraph2').getContext('2d'); 

    var chart2 = new Chart(ctx2, {
        type: 'pie', 
        data: {
            labels: eWordBValuea, 
            datasets: [{
                label: '자산유형별 반출 건', 
                data: eValueBValue, 
                backgroundColor: pieColors,
                borderColor: '#fff', 
                borderWidth: 2 
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            layout: { padding: 0 },
            title: { display: true, text: '자산유형별 반출 건', fontSize: 16, fontStyle: 'bold', fontFamily: 'Pretendard', fontColor: '#171D2F' },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        var dataset = data.datasets[tooltipItem.datasetIndex];
                        var value = dataset.data[tooltipItem.index];
                        return '' + data.labels[tooltipItem.index] + ' : ' + value + '건';
                    }
                }
            },
            legend: { display: false }, 
            responsiveAnimationDuration: 1000
        }
    });
    
    let legendHtml2 = '';
    for (let i = 0; i < eWordBValuea.length; i++) { 
        let color = pieColors[i % pieColors.length];
        
        let fullName = eWordBValuea[i]; 
        let shortName = fullName.length > 15 ? fullName.substring(0, 15) + '...' : fullName;

        legendHtml2 += '<li style="display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px solid #f4f4f4;">' +
            '<div style="display: flex; align-items: center; flex: 1; min-width: 0; padding-right: 10px;">' + 
                '<span style="display: inline-block; flex-shrink: 0; width: 12px; height: 12px; background-color: ' + color + '; margin-right: 8px; border-radius: 2px;"></span>' +
                '<span title="' + fullName + '" style="font-size: 13px; font-family: \'Pretendard\'; color: #555; display: block; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; min-width: 0;">' + shortName + '</span>' +
            '</div>' +
            '<span style="font-size: 13px; font-weight: bold; font-family: \'Pretendard\'; flex-shrink: 0;">' + eValueBValue[i] + '건</span>' +
        '</li>';
    }
    document.getElementById('customLegend2').innerHTML = legendHtml2;
</script>