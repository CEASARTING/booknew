<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>本店管理</title>
    <link rel="stylesheet" href="/css/main.css" type="text/css"/>
    <script type="text/javascript" src="/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="/js/adaptive.js" ></script>
    <script type="text/javascript" src="/js/main.js" ></script>
    <script type="text/javascript">
        window['adaptive'].desinWidth=750;
        window['adaptive'].baseFont=12;
        window['adaptive'].maxWidth=480;
        window['adaptive'].init();
    </script>
    <script>
        $(function() {
            $('.aaa').click(function () {
                if ($(this).css('color') == 'rgb(51, 51, 51)') {
                    $(this).css('color', '#ED5D60');
                    $(".user_19").slideDown("slow");
                }
                else {
                    $(this).css('color', 'rgb(51,51,51)');
                    $(".user_19").hide();
                }

            })
            $('.user_19_3').click(function () {
                if ($(this).attr("class") == "user_19_3 checked_1") {
                    $(this).removeClass('checked_1');
                    $(this).find('img').css('display', 'none');
                    $(this).find("input").prop("checked", false);

                }
                else {
                    $(this).addClass('checked_1');
                    $(this).find('img').css('display', 'block');
                    $(this).find("input").prop("checked", true);
                }

            })

            $('.user_190_3').click(function () {
                $(this).addClass('checked_1').siblings().removeClass('checked_1');
                $(this).find('img').css('display', 'block').parent().siblings().find('img').css('display', 'none')

                $(this).find("input").prop("checked", true);
            })

            $('.user_19_1').click(function () {
                var types = new Array();
                $("input[name='type']:checkbox:checked").each(function () {
                    types.push($(this).val());
                });
                var typeStr = types.join(",");


                var cabinets = new Array();
                $("input[name='cabinet']:checkbox:checked").each(function () {
                    cabinets.push($(this).val());
                });
                var cabinetStr = cabinets.join(",");

                var time = $("input[name='time']:checked").val();

                $.ajax({
                    type: 'post',
                    data:
                            {
                                types: typeStr,
                                cabinets: cabinetStr,
                                time: time
                            },
                    dataType: 'json',
                    async: false,
                    url: "/store/getWineLogFilter",
                    success: function (data) {
                        var code = data.code;
                        var msg = data.msg;
                        var info = data.data;
                        if (code == 200) {
                            var list = eval(info.list);
                            $("#table1").html("");
                            $("#table1").addClass("user_17");
                            $("#table1").css("border", 0);


                            $("#table1").append("<tr><td>取酒量（ml）</td><td>取酒方式</td><td>酒柜编号</td><td>取酒时间</td></tr>");
                            $.each(list, function (n, value) {
                                var inner = eval(value);

                                if (inner.orderStatus == ${orderException}) {
                                    $("#table1").append("<tr class='yichang'><td>" + inner.getLogAcount + "</td><td>" + inner.getLogSourcePage + "</td><td>" + inner.cabinetNumber +
                                            "</td><td style=\"line-height:0.3rem\">" + dateFormat_2(inner.getLogTime) + "</br>" + datetimeFormat_1(inner.getLogTime) + "</td></tr>");
                                } else {
                                    $("#table1").append("<tr><td>" + inner.getLogAcount + "</td><td>" + inner.getLogSourcePage + "</td><td>" + inner.cabinetNumber +
                                            "</td><td style=\"line-height:0.3rem\">" + dateFormat_2(inner.getLogTime) + "</br>" + datetimeFormat_1(inner.getLogTime) + "</td></tr>");
                                }


                            });


                            $(".user_19").hide();
                            return false;
                        } else {
                            return false;
                        }
                    }
                });
            })
        })

        function datetimeFormat_1(longTypeDate){
            var datetimeType = "";
            var date = new Date();
            date.setTime(longTypeDate);

            datetimeType+=       getHours(date);   //时
            datetimeType+= ":" + getMinutes(date);      //分
            datetimeType+= ":" + getSeconds(date);      //分
            return datetimeType;
        }

        function dateFormat_2(longTypeDate){
            var dateType = "";
            var date = new Date();
            date.setTime(longTypeDate);
            dateType = date.getFullYear()+"-"+getMonth(date)+"-"+getDay(date);//yyyy-MM-dd格式日期
            return dateType;
        }

        //返回 01-12 的月份值
        function getMonth(date){
            var month = "";
            month = date.getMonth() + 1; //getMonth()得到的月份是0-11
            if(month<10){
                month = "0" + month;
            }
            return month;
        }
        //返回01-30的日期
        function getDay(date){
            var day = "";
            day = date.getDate();
            if(day<10){
                day = "0" + day;
            }
            return day;
        }

        //返回小时
        function getHours(date){
            var hours = "";
            hours = date.getHours();
            if(hours<10){
                hours = "0" + hours;
            }
            return hours;
        }
        //返回分
        function getMinutes(date){
            var minute = "";
            minute = date.getMinutes();
            if(minute<10){
                minute = "0" + minute;
            }
            return minute;
        }
        //返回秒
        function getSeconds(date){
            var second = "";
            second = date.getSeconds();
            if(second<10){
                second = "0" + second;
            }
            return second;
        }
    </script>
</head>

<body class="body_1">
<div class="header"><img onclick=window.location.href="/store/manageCabinet/${storeId!}" src="/images/27.png"><span>门店取酒记录</span><span class="aaa">过滤</span></div>
<table id="table1" class="user_17" border="0">
    <tr><td>取酒量（ml）</td><td>取酒方式</td><td>取酒编号</td><td>取酒时间</td></tr>
<#if list?exists>
    <#list list as get>
        <tr <#if '${get.orderStatus!}'=='${orderException!}'> class="yichang" </#if>><td>${get.getLogAcount!}</td><td>${get.getLogSourcePage!}</td><td>${get.cabinetNumber!}</td><td style="line-height:0.3rem">${get.getLogTime?number_to_date}<br/>${get.getLogTime?number_to_time}</td></tr>
    </#list>
</#if>
</table>
<div class="user_18">注：默认显示本日取酒记录，红色字体为取酒异常记录</div>
<div class="user_19">
    <div class="user_19_100">
        <span class="user_19_span">店员名称</span>
        <div class="user_19_2">
        <#if types?exists>
            <#list types as type>
                <div class="user_19_3">
                    <img src='/images/duihao.png'>${type.getLogSourcePage!}
                    <input type="checkbox" style="display: none" name="type" value="${type.getLogSource!}"/>

                </div>
            </#list>
        </#if>
            <div class="clear"></div>
        </div>
        <span class="user_19_span">酒柜编号</span>
        <div class="user_19_2">
        <#if cabinets?exists>
            <#list cabinets as cabinet>
                <div  <#if '${cabinetId!}'='${cabinet.cabinetId!}'>
                        class="user_19_3 checked_1"
                        <#else>
                        class="user_19_3"
                      </#if>
                >
                    <img src='/images/duihao.png' <#if '${cabinetId!}'='${cabinet.cabinetId!}'>style="display:block;"</#if>>${cabinet.cabinetNumber!}
                    <input type="checkbox" style="display: none" name="cabinet" value="${cabinet.cabinetId!}"
                           <#if '${cabinetId!}'='${cabinet.cabinetId!}'>checked="checked"</#if>/>
                </div>
            </#list>
        </#if>
            <div class="clear"></div>
        </div>
        <span class="user_19_span">查询区间</span>
        <div class="user_19_2">
            <div class="user_190_3"><img src='/images/duihao.png'>昨日
                <input type="radio" name="time" id="1" style="display: none" value="1"/>
            </div>

            <div class="user_190_3 checked_1"><img src='/images/duihao.png' style="display: block">本日
                <input checked="checked" type="radio" name="time" id="2" style="display: none" value="3"/>
            </div>
            <div class="user_190_3"><img src='/images/duihao.png'>本月
                <input type="radio" style="display: none" name="time" id="3" value="5"/>
            </div>
            <div class="user_190_3"><img src='/images/duihao.png'>上月
                <input type="radio" style="display: none" name="time" id="4" value="7"/>
            </div>
            <div class="clear"></div>
        </div>
        <button class="user_19_1">确认</button>
    </div>
</div>
</body>
</html>
