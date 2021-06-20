var checkOpionAgree="同意";
var checkOpionDisagree="不同意";
var checkOpionStore = Ext.create("Ext.data.Store", {
	fields: ["ItemText", "ItemValue"],
	data: [
		{ ItemText: checkOpionAgree, ItemValue: 1 },
		{ ItemText: checkOpionDisagree, ItemValue: 2 }
	]
});
Ext.define('Forestry.app.houseManage.HouseQuery', {
	extend : 'Ext.grid.Panel',
	region : 'center',
	initComponent : function() {
		var me = this;
	
		var AllDeprtmentQuery_hidden="hidden"
	        if(globalObject.haveActionMenu(me.cButtons, 'AllDeprtmentQuery'))
	        		AllDeprtmentQuery_hidden="combobox";//判断登录者是否有查询所有部门权限
		var departmentQueryStore = Ext.create('Ext.data.JsonStore', {
			proxy : {
				type : 'ajax',
				url : appBaseUri + '/sys/department/getDepartments',
				reader : {
					type : 'json',
					root : 'list',
					idProperty : 'ItemValue'
				}
			},
			fields : [ 'ItemText', 'ItemValue' ]
		});
		
		// 通讯录关系类型
		var houseTypeNameStore = Ext.create('Ext.data.JsonStore', {
			proxy : {
				type : 'ajax',
				url : appBaseUri + '/sys/houseType/getHouseType',
				reader : {
					type : 'json',
					root : 'list',
					idProperty : 'ItemValue'
				}
			},
			fields : [ 'ItemText', 'ItemValue' ]
		});
		
		// 数据结构
		Ext.define('ModelList', {
			extend : 'Ext.data.Model',
			idProperty : 'id',
			fields : [ {
				name : 'id',
				type : 'long'
			}, 'name', 'tel','relationshipName','qq','address', {
				name : 'registDate',
				type : 'datetime',
				dateFormat : 'Y-m-d'
			}]
		});

		// 数据
		var queryHousestore = Ext.create('Ext.data.Store', {
			model : 'ModelList',
			// autoDestroy: true,
			autoLoad : true,
			remoteSort : true,
			pageSize : globalPageSize,
			proxy : {
				type : 'ajax',
				url : appBaseUri + '/sys/tel/queryTel',
				extraParams : me.extraParams || null,
				reader : {
					type : 'json',
					root : 'data',
					totalProperty : 'totalRecord',
					successProperty : "success"
				}
			},
			sorters : [ {
				property : 'id',
				direction : 'DESC'
			} ]
		});

		// 列
		var columns = [ {
			text : "编号",
			dataIndex : 'id',
			xtype : "hidden",
			width : '5%'
		}, {
			text : "姓名",
			dataIndex : 'name',
			width : '8%',
			sortable : false
		},{
			text : "电话号码",
			dataIndex : 'tel',
			width : '12%',
			sortable : false
		}, {
			text : "关系",
			dataIndex : 'relationshipName',
			width : '8%',
			sortable : false
		}, {
			text : "QQ",
			dataIndex : 'qq',
			width : '12%',
			sortable : false
		}, {
			text : "家庭地址",
			dataIndex : 'address',
			width : '20%',
			sortable : false
		}, {
			text : "注册日期",
			width : '10%',
			dataIndex : 'registDate',
			sortable : false
		}
		];

		// 导出按钮  条件查询 搜索框
		var houseQueryToolbarToolbar = Ext.create('Ext.toolbar.Toolbar', {
			items : [ 
			{
				xtype : 'button',
				text : '导出',
				iconCls : 'icon-excel',
				width : '10%',
				maxWidth : 60,
				handler : function(btn, eventObj) {
					
					
					var me = Ext.getCmp("HouseQuerygrid");;
					var s = me.getSelectionModel().getSelection();
					var ids = [];
					var idProperty = me.idProperty || 'id';
					for (var i = 0, r; r = s[i]; i++) {
						ids.push(r.get(idProperty));
					}
					if (ids.length < 1) {
						globalObject.infoTip('请先选择导出的数据行！');
						return;
					}
					//// 导出地址proxyExportUrl : appBaseUri + '/sys/Tenant/getExportedTenantList',					
					location.href = appBaseUri + "/sys/tel/getExportedTelList?ids=" + ids;
				}
			},
			{
				xtype : 'textfield',
				id : 'houseQueryform_houseName',
				name : 'houseName',
				fieldLabel : '姓名',
				labelWidth : 60,
				width : '20%'
			}, {
				xtype : 'textfield',
				id : 'houseQueryform_houseOwnerName',
				name : 'houseOwnerName',
				fieldLabel : '电话号码',
				labelWidth : 60,
				width : '20%'
			},{
				xtype : 'combobox',
				fieldLabel : '关系',
				id:'houseQueryform_houseType',
				labelWidth : 60,
				store : houseTypeNameStore,
				valueField : 'ItemValue',
				displayField : 'ItemText',
				typeAhead : true,
				queryMode : 'remote',
				emptyText : '请选择...',
				editable : false,
				listeners : {
					select : function(combo, record, index) {
						Ext.getCmp("houseQueryform-houseTypeId").setValue(combo.getValue());
						Ext.getCmp("houseQueryform-houseTypeName").setValue(combo.getRawValue());
					}
				}
			} ,{
				xtype : 'hiddenfield',
				id : 'houseQueryform-houseTypeId',
				name : 'houseTypeId'
			}, {
				xtype : 'hiddenfield',
				id : 'houseQueryform-houseTypeName',
				name : 'houseTypeName'
			}, {
				xtype : 'button',
				text : '查询',
				iconCls : 'icon-search',
				width : '10%',
				maxWidth : 60,
				handler : function(btn, eventObj) {
					// 查询单击事件
					var searchParams = {
							name : encodeURI(Ext.getCmp('houseQueryform_houseName').getValue()),
							tel : encodeURI(Ext.getCmp('houseQueryform_houseOwnerName').getValue()),
							relationshipId : encodeURI(Ext.getCmp('houseQueryform-houseTypeId').getValue()),
							relationshipName : encodeURI(Ext.getCmp('houseQueryform-houseTypeName').getValue())
					};
					Ext.apply(queryHousestore.proxy.extraParams, searchParams);
					// 数据重新加载
					queryHousestore.reload();
				}
			}, {
				xtype : 'button',
				text : '重置',
				iconCls : 'icon-reset',
				width : '10%',
				maxWidth : 60,
				handler : function(btn, eventObj) {
					Ext.getCmp('houseQueryform_houseName').setValue(null);
					Ext.getCmp('houseQueryform_houseOwnerName').setValue(null);
					Ext.getCmp('houseQueryform-houseTypeId').setValue(null);
					Ext.getCmp('houseQueryform-houseTypeName').setValue(null);
					Ext.getCmp('houseQueryform_houseType').setValue(null);
				}
			} ]
		});

		// 整合
		Ext.apply(this, {
			id : 'HouseQuerygrid',
			store : queryHousestore,
			selModel: { selType: 'checkboxmodel' },   //选择框
			columns : columns,
			tbar : houseQueryToolbarToolbar,
			bbar : Ext.create('Ext.PagingToolbar', {
				store : queryHousestore,
				displayInfo : true
			}),
			listeners : {
				itemdblclick : function(dataview, record, item, index, e) {
					var grid = this;
					var id = grid.getSelectionModel().getSelection()[0].get('id');
					var gridRecord = grid.getStore().findRecord('id', id);
					//var win = new App.HouseQueryWindow({
					//	hidden : true
					//});
					//var form = win.down('form').getForm();
					//form.loadRecord(gridRecord);
					//form.findField('epcId').setReadOnly(true);
					//form.findField('name').setReadOnly(true);
					//form.findField('plantTime').setReadOnly(true);
					//form.findField('entryTime').setReadOnly(true);
					//form.findField('houseName').setReadOnly(true);
					//win.show();
				}
			}
		});

		this.callParent(arguments);
	}
});