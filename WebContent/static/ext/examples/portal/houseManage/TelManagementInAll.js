Ext.onReady(function() {
	Ext.tip.QuickTipManager.init();

	// 获取通讯录类型列表
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

	// 审核意见
	var checkOpionAgree="同意";
	var checkOpionDisagree="不同意";
	var checkOpionStore = Ext.create("Ext.data.Store", {
		fields: ["ItemText", "ItemValue"],
		data: [
			{ ItemText: checkOpionAgree, ItemValue: 1 },
			{ ItemText: checkOpionDisagree, ItemValue: 2 }
		]
	});
	
	// 添加对话框 修改对话框
	Ext.define('App.HouseManagementInAllDepartWindow', {
		extend : 'Ext.window.Window',
		constructor : function(config) {
			config = config || {};
			Ext.apply(config, {
				title : '通讯录信息',
				width : 350,
				height : 340,
				bodyPadding : '10 5',
				modal : true,
				layout : 'fit',
				items : [ {
					xtype : 'form',
					fieldDefaults : {
						labelAlign : 'left',
						labelWidth : 90,
						anchor : '100%'
					},
					items : [ {
						name : "cmd",
						xtype : "hidden",
						value : 'new'
					}, {
						xtype : 'combobox',
						fieldLabel : '关系类型',
						store : houseTypeNameStore,
						valueField : 'ItemValue',
						displayField : 'ItemText',
						typeAhead : true,
						ManagementMode : 'remote',
						emptyText : '请选择...',
						allowBlank : false,
						editable : false,
						listeners : {
							select : function(combo, record, index) {
								Ext.getCmp("houseForm-houseTypeId").setValue(combo.getValue());
								Ext.getCmp("houseForm-houseTypeName").setValue(combo.getRawValue());
							}
						}
					},{
						xtype : 'hiddenfield',
						name : 'id'
					},{
						xtype : 'textfield',
						name : 'name',
						fieldLabel : '姓名',
						emptyText : '请输入姓名',
						allowBlank : false,
						maxLength : 200
					},{
						xtype : 'textfield',
						fieldLabel : '电话号码',
						name : 'tel',
						maxLength : 200
					}, {
						xtype : 'textfield',
						name : 'qq',
						fieldLabel : 'QQ',
						allowBlank : false,
						maxLength : 200
					},{
						xtype : 'textarea',
						name : 'address',
						fieldLabel : '房屋地址',
						allowBlank : false,
						maxLength : 200
					}, {
						xtype : 'hiddenfield',
						id : 'houseForm-houseTypeId',
						name : 'houseTypeId'
					},{
						xtype : 'hiddenfield',
						id : 'houseForm-houseTypeName',
						name : 'houseTypeName'
					},{
						xtype : 'hiddenfield',
						id : 'ownerId',
						name : 'ownerId'
					}
					],
					buttons : [ '->', {
						id : 'Housewindow-save',
						text : '保存',
						iconCls : 'icon-save',
						width : 80,
						handler : function(btn, eventObj) {
							var window = btn.up('window');
							var form = window.down('form').getForm();
							if (form.isValid()) {
								window.getEl().mask('数据保存中，请稍候...');
								var vals = form.getValues();
								Ext.Ajax.request({
									async: false,
									url : appBaseUri + '/sys/tel/saveTel',
									params : {
										cmd : vals['cmd'],
										id : vals['id'],
										name : vals['name'],
										qq : vals['qq'],
										relationshipId : vals['houseTypeId'],
										relationshipName : vals['houseTypeName'],
										houseAddress : vals['houseAddress'],
										address : vals['address'],
										ownerId : vals['ownerId'],
										tel : vals['tel']
									},
									method : "POST",
									success : function(response) {
										if (response.responseText != '') {
											var res = Ext.JSON.decode(response.responseText);
											if (res.success) {
												
												//判断前端是否选择有图片，否则就不调用上传图片Ajax 
												//调用Ajax插入图片
												//saveHouseTwoDimensionalCode
												globalObject.msgTip('操作成功！');
												Ext.getCmp('HouseManagementInAllDepartgrid').getStore().reload();
											} else {
												globalObject.errTip('保存失败！');
											}
										}
									},
									failure : function(response) {
										globalObject.errTip('操作失败！');
									}
								});
								window.getEl().unmask();
								window.close();
							}
						}
					}, {
						id : 'Housewindow-cancel',
						text : '取消',
						iconCls : 'icon-cancel',
						width : 80,
						handler : function() {
							this.up('window').close();
						}
					}, {
						id : 'Housewindow-accept',
						text : '确定',
						hidden : true,
						iconCls : 'icon-accept',
						width : 80,
						handler : function() {
							this.up('window').close();
						}
					}, '->' ]
				} ]
			});
			App.HouseManagementInAllDepartWindow.superclass.constructor.call(this, config);
		}
	});
	
	Ext.define('App.ImportWindow', {
		extend : 'Ext.window.Window',
		constructor : function(config) {
			config = config || {};
			var scope = this;
			Ext.apply(config, {
				title : '树木识别数据导入',
				width : 500,
				height : 190,
				bodyPadding : '10 5',
				modal : true,
				layout : 'fit',
				items : [ {
					xtype : 'form',
					fieldDefaults : {
						labelAlign : 'left',
						labelWidth : 70,
						anchor : '100%'
					},
					items : [ {
						xtype : 'fileuploadfield',
						fieldLabel : '选择文件',
						afterLabelTextTpl : '<span style="color:#FF0000;">*</span>',
						buttonText : '请选择...',
						name : 'importedFile',
						emptyText : '请选择Excel文件',
						blankText : 'Excel文件不能为空',
						allowBlank : false,
						listeners : {
							change : function(view, value, eOpts) {
								scope.checkImportFile(view, value);
							}
						}
					}, {
						columnWidth : 1,
						xtype : 'fieldset',
						title : '导入须知',
						layout : {
							type : 'table',
							columns : 1
						},
						collapsible : false,// 是否可折叠
						defaultType : 'label',// 默认的Form表单组件
						items : [ {
							html : '1、导入文件大小不超过2MB.'
						}, {
							html : '2、支持Microsoft Office Excel的xls和xlsx文件,模板<a href="' + appBaseUri + '/sys/tel/downloadImportedFile")>点此下载.</a>'
						} ]
					} ],
					buttons : [ '->', {
						text : '导入',
						iconCls : 'icon-excel',
						handler : function(btn) {
							scope.importForestryFile(btn);
						}
					}, {
						text : '取消',
						iconCls : 'icon-cancel',
						handler : function(btn) {
							btn.up('window').close();
						}
					}, '->' ]
				} ]
			});
			App.ImportWindow.superclass.constructor.call(this, config);
		},
		checkImportFile : function(fileObj, fileName) {
			var scope = this;
			if (!(scope.getFileType(scope.getFileSuffix(fileName)))) {
				globalObject.errTip('导入文件类型有误！');
				fileObj.reset();// 清空上传内容
				return;
			}
		},
		getFileType : function(suffix) {
			var typestr = 'xls,xlsx';
			var types = typestr.split(',');
			for (var i = 0; i < types.length; i++) {
				if (suffix == types[i]) {
					return true;
				}
			}
			return false;
		},
		getFileSuffix : function(fileName) {
			var suffix = '';// 后缀
			var index = fileName.lastIndexOf('.');// 文件名称中最后一个.的位置
			if (index != -1) {
				suffix = fileName.substr(index + 1).toLowerCase();// 后缀转成小写
			}
			return suffix;
		},
		importForestryFile : function(btn) {
			var windowObj = btn.up('window');// 获取Window对象
			var formObj = btn.up('form');// 获取Form对象
			if (formObj.isValid()) { // 验证Form表单
				formObj.form.doAction('submit', {
					url : appBaseUri + '/sys/tel/importForestryFile',
					method : 'POST',
					submitEmptyText : false,
					waitMsg : '正在导入文件,请稍候...',
					timeout : 6000000, // 60s
					success : function(response, options) {
						var result = options.result;
						if (!result.success) {
							globalObject.errTip(result.msg);
							return;
						}
						globalObject.infoTip(result.msg);
						// var url = result.data;
						windowObj.close();// 关闭窗体
						Ext.getCmp('HouseManagementInAllDepartgrid').getStore().reload();
					},
					failure : function(response, options) {
						globalObject.errTip(options.result.msg);
					}
				});
			}
		}
	});

	// 通讯录管理界面
	Ext.define('Forestry.app.houseManage.TelManagementInAll', {
		extend : 'Ext.ux.custom.GlobalGridPanel',
		region : 'center',
		initComponent : function() {
			var me = this;
	
			// 数据类型
			Ext.define('ModelList', {
				extend : 'Ext.data.Model',
				idProperty : 'id',
				fields : [ {
					name : 'id',
					type : 'long'
				},'name', 'tel','relationshipName','qq' ,'address', 'registDate','ownerId','ownerName']
			});

			// 对接后台的api接口
			var store = me.createStore({
				modelName : 'ModelList',
				// 获取列表
				proxyUrl : appBaseUri + '/sys/tel/getTelList',
				// 删除地址
				proxyDeleteUrl : appBaseUri + '/sys/tel/deleteTel',
				// 导出地址
				proxyExportUrl : appBaseUri + '/sys/tel/getExportedTelList',
				// 审核地址
				proxyCheckUrl : appBaseUri + '/sys/house/checkHouse',
				extraParams : me.extraParams
			});

			// 条件查询 对话框
			Ext.define('App.HouseQueryWindow', {
				extend : 'Ext.window.Window',
				constructor : function(config) {
					config = config || {};
					Ext.apply(config, {
						title : '查询',
						width : 350,
						height : 250,
						bodyPadding : '10 5',
						layout : 'fit',
						modal : true,
						items : [ {
							xtype : 'form',
							fieldDefaults : {
								labelAlign : 'left',
								labelWidth : 90,
								anchor : '100%'
							},
							items : [ 
							{
								xtype : 'combobox',
								fieldLabel : '关系',
								store : houseTypeNameStore,
								valueField : 'ItemValue',
								displayField : 'ItemText',
								typeAhead : true,
								queryMode : 'remote',
								emptyText : '请选择...',
								allowBlank : false,
								editable : false,
								listeners : {
									select : function(combo, record, index) {
										Ext.getCmp("houseQueryform-departmentId").setValue(combo.getValue());
									}
								}
							},{
								xtype : 'hiddenfield',
								id : 'houseQueryform-departmentId',
								name : 'houseQueryform-departmentId'
							}],
							buttons : [ '->', {
								text : '确定',
								iconCls : 'icon-accept',
								width : 80,
								handler : function() {
									var searchParams = {
											relationshipId:encodeURI(Ext.getCmp('houseQueryform-departmentId').getValue())
										};
									Ext.apply(store.proxy.extraParams, searchParams);
									store.reload();
									this.up('window').close();
								}
							}, '->' ]
						} ]
					});
					App.HouseQueryWindow.superclass.constructor.call(this, config);
				}
			});
			
			// 列
			var columns = [ 
			{
				text : "ID",
				xtype : "hidden",
				dataIndex : 'id',
				flex : 0.05,
				sortable : false
			},{
				text : "姓名",
				dataIndex : 'name',
				flex : 0.08,
				sortable : false
			},{
				text : "电话号码",
				dataIndex : 'tel',
				flex : 0.1,
				sortable : false
			},{
				text : "关系",
				dataIndex : 'relationshipName',
				flex : 0.08,
				sortable : false
			},{
				text : "QQ",
				dataIndex : 'qq',
				flex : 0.08,
				sortable : false
			},{
				text : "家庭地址",
				dataIndex : 'address',
				flex : 0.2,
				sortable : false
			},{
				text : "注册日期",
				dataIndex : 'registDate',
				flex : 0.1,
				sortable : false
			},{
				text : "操作",
				xtype : 'actioncolumn',
				flex : 0.2,
				items : [ {
					iconCls : 'icon-view',
					tooltip : '查看',
					disabled : !globalObject.haveActionMenu(me.cButtons, 'View'),
					handler : function(grid, rowIndex, colIndex) {
						var gridRecord = grid.getStore().getAt(rowIndex);
						var win = new App.HouseManagementInAllDepartWindow({
							hidden : true
						});
						var form = win.down('form').getForm();
						form.loadRecord(gridRecord);
						form.findField('tel').setReadOnly(true);
						form.findField('qq').setReadOnly(true);
						form.findField('address').setReadOnly(true);
						form.findField('houseTypeId').setReadOnly(true);
						form.findField('houseTypeName').setReadOnly(true);
						Ext.getCmp('Housewindow-save').hide();
						Ext.getCmp('Housewindow-cancel').hide();
						Ext.getCmp('Housewindow-accept').show();
						win.show();
					}
				}, {
					iconCls : 'edit',
					tooltip : '修改',
					disabled : !globalObject.haveActionMenu(me.cButtons, 'Edit'),
					handler : function(grid, rowIndex, colIndex) {
						var gridRecord = grid.getStore().getAt(rowIndex);
						var win = new App.HouseManagementInAllDepartWindow({
							hidden : true
						});
						win.setHeight(250);
						var form = win.down('form').getForm();
						form.loadRecord(gridRecord);
						form.findField("cmd").setValue("edit");
						win.show();
					}
				
				},{
					iconCls : 'icon-delete',
					tooltip : '删除',
					disabled : !globalObject.haveActionMenu(me.cButtons, 'Delete'),
					handler : function(grid, rowIndex, colIndex) {
						var entity = grid.getStore().getAt(rowIndex);
						singleId = entity.get('id');
						me.onDeleteClick();
					}
				},{
					iconCls : 'edit',
					tooltip : '审核',
					disabled : !globalObject.haveActionMenu(me.cButtons, 'Examine'),
					handler : function(grid, rowIndex, colIndex) {
				
						var entity = grid.getStore().getAt(rowIndex);
						singleId = entity.get('id');
						me.onCheckClick();
					}
				
				}]
			} ];

			// 网格布局 整合数据和列
			Ext.apply(this, {
				id : 'HouseManagementInAllDepartgrid',
				store : store,
				columns : columns
			});

			store.loadPage(1);

			this.callParent(arguments);
		},
		
		// 添加按钮单击事件
		onAddClick : function() {
			new App.HouseManagementInAllDepartWindow().show();
		},
		
		// 条件查询按钮单击事件
		onQueryClick : function() {
			new App.HouseQueryWindow().show();
		},
		
		// 全部查询按钮单击事件
		onQueryAllClick : function() {
			var store=Ext.getCmp("HouseManagementInAllDepartgrid").getStore();
			var searchParams = {
					relationshipId : null
			};
			Ext.apply(store.proxy.extraParams, searchParams);
			store.reload();
		},
		onImportClick : function() {
			new App.ImportWindow().show();
		},
		// 查看按钮单击事件
		onViewClick : function() {
			var grid = Ext.getCmp("HouseManagementInAllDepartgrid");
			var id = grid.getSelectionModel().getSelection()[0].get('id');
			var gridRecord = grid.getStore().findRecord('id', id);
			var win = new App.HouseManagementInAllDepartWindow({
				hidden : true,
				height : 430
			});
			var form = win.down('form').getForm();
			form.findField('houseName').setReadOnly(true);
			form.findField('houseDesc').setReadOnly(true);
			form.findField('houseTypeName').setReadOnly(true);
			form.loadRecord(gridRecord);
			Ext.getCmp('Housewindow-save').hide();
			Ext.getCmp('Housewindow-cancel').hide();
			Ext.getCmp('Housewindow-accept').show();
			win.show();
		}
	});
});