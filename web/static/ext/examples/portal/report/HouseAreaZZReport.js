
Ext.define('Forestry.app.report.HouseAreaZZReport', {
	extend : 'Ext.panel.Panel',
	initComponent : function() {
		var me = this;
		Ext.apply(this, {
			layout : 'border',
			items : 
				[ 
					Ext.create('Forestry.app.report.HouseZZReprot'),
				]
		});
		this.callParent(arguments);
	}
});

// 静态数据 数据请求之后会被替换
var zwz=[
	{departmentName :'小于30岁', proportion : 10},
	{departmentName :'30-40岁', proportion : 40},
	{departmentName :'40-50岁', proportion : 30},
	{departmentName :'50岁以上', proportion : 20}
]

// 请求数据
Ext.Ajax.request({
	async: false,
    url: '/ZwzTelSystem/sys/houseType/getDepartmentsInZZReport',
    method: 'POST',
    success: function (response, options) {
    	//alert(response.responseText);
    	zwz = JSON.parse(response.responseText).list;
        
    },
    failure: function (response, options) {
        Ext.MessageBox.alert('失败', '请求超时或网络故障,错误编号：' + response.status);
    }
});

//数据源
var dataStore = new Ext.data.JsonStore({
	fields:['departmentName', 'proportion','tenantNum'],
	data: zwz
});

// 图
Ext.define('Forestry.app.report.HouseZZReprot', {
	extend : 'Ext.panel.Panel',
	initComponent : function() {
		var housechart=Ext.create('Ext.panel.Panel', {
			title : '通讯录分类数量柱状图',
			autoScroll:true,
			layout: 'fit',
			items : [{
				xtype : 'chart',
				theme: 'Category1',//彩色主题1  Blue  Category1  Base
				store : dataStore,
				animate: true,//是否启用动画效果
				legend: {
					position: 'bottom' //图例位置
				},
				shadow: true,
				axes: [{
					type: 'Numeric',
					grid: true,//显示网格线
					position: 'left',
					minimum : 0,//数轴最小值
					maximum : 100,//数轴最大值
					fields: ['proportion'],
					title: '数量'
				}, {
					type: 'Category',
					position: 'bottom',
					fields: ['departmentName'],
					label: { rotate: { degrees: 315} },
					title: '通讯录分类数量'
				}],
				series : [{
	                type: 'column',//柱状图表序列
	                axis: 'left',
	                xField: 'departmentName', //x坐标
	                yField: 'proportion',//y坐标
					title : '数量'
	            }]
			}]
		});
	
		
		var panel1 = Ext.create('widget.panel', {
			layout : 'fit',
			items : housechart
		});

		Ext.apply(this, {
			layout : 'fit',
			region : "center",
			items : [ panel1 ]
		});

		this.callParent(arguments);
	}
});

