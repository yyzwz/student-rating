<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>元培学院ZWZ通讯录管理大数据</title>
	<script src="js/jquery-2.1.1.min.js"></script>
	<script>
	 $(window).load(function(){  
             $(".loading").fadeOut()
            })  
	</script>
	
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/map.css">
</head>
<body>
	<div class="loading">
      <div class="loadbox"> <img src="picture/loading.gif"> 页面加载中... </div>
    </div>
<div class="data">
    <div class="data-title">
        <div class="title-center">元培学院ZWZ通讯录管理大数据</div>
    </div>
    <div class="data-content">
        <div class="con-left fl">
            <div class="left-top">
                <div class="info boxstyle">
                    <div class="title">实时统计</div>
                    <div class="info-main">
						<ul>
							<li><img src="picture/car2.png" width=48px height=48px alt=""><span>当前关系数</span><p id="totalShipNum">12,457</p></li>
							<li><img src="picture/car.png" width=48px height=48px alt=""><span>当前通讯录总数</span><p id="totalTelNum">12,457</p></li>
						</ul>
                    </div>
                </div>
            </div>
            <div class="left-bottom boxstyle">
                <div class="title">关系总数Top5</div>
                <div id="shupTop5" class="charts" style="margin-top:15px;"></div>
            </div>
        </div>
        <div class="con-center fl">
            
        
            <div class="cen-bottom boxstyle">
                <div class="title">最近12个月通讯录总数</div>
                <div id="echarts_3" class="charts"></div>
            </div>
            <div class="cen-bottom boxstyle">
                <div class="title">最近12个月通讯录总数</div>
                <div id="echarts_5" class="charts"></div>
            </div>
            
        </div>
       
    </div>
</div>
</body>

<script src="js/echarts.min.js"></script>

<script src="js/echarts.js"></script>
</html>