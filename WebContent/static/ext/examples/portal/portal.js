Ext.Ajax.timeout = 60000;
Ext.Loader.setConfig({
	enabled : true
});
Ext.require([ 'Ext.util.History', 'Ext.ux.statusbar.StatusBar', 'Ext.app.PortalPanel', 'Ext.ux.TabScrollerMenu', 'Ext.state.*', 'Ext.window.MessageBox', 'Ext.tip.*' ]);

var mainTab, globalPageSize = 40, // 全局分页大小
globalDateColumnWidth = 160;// 全局时间列宽度



Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.History.init();
	// Ext.state.Manager.setProvider(Ext.create('Ext.ux.custom.HttpProvider'));

	var tokenDelimiter = ':';

	var mainPortal = Ext.create('Ext.app.Home', {
		title : '通讯录分类数量总览'
	});

	mainTab = Ext.create('Ext.TabPanel', {
		region : 'center',
		margins : '2 0 0 0',
		deferredRender : false,
		activeTab : 0,
		plugins : Ext.create('Ext.ux.TabCloseMenu', {
			closeTabText : '关闭面板',
			closeOthersTabsText : '关闭其他',
			closeAllTabsText : '关闭所有'
		}),
		items : [ mainPortal ],
		listeners : {
			tabchange : onTabChange,
			afterrender : onAfterRender
		}
	});

	var menuTreeStore = Ext.create('Ext.data.TreeStore', {
		autoLoad : true,
		proxy : {
			type : 'ajax',
			url : appBaseUri + '/sys/authority/getAuthority?globalRoleId=' + globalRoleId,
			reader : {
				type : 'json',
				root : 'children'
			}
		}
	/**
	 * <code>
	 proxy : new Ext.data.HttpProxy({
	 	url : appBaseUri + '/static/json/menu.json'
	 })
	 </code>
	 */
	});

	var treeFilterField = Ext.create('Ext.form.field.Trigger', {
		width : '100%',
		emptyText : '功能查找...',
		trigger1Cls : 'x-form-clear-trigger',
		onTrigger1Click : function() {
			treeFilterField.setValue('');
			menuTreeStore.clearFilter(true);
		},
		listeners : {
			'keyup' : {
				element : 'el',
				fn : function(e) {
					var regex = new RegExp(Ext.String.escapeRegex(treeFilterField.getValue()), 'i');
					menuTreeStore.clearFilter(true);
					menuTreeStore.filter(new Ext.util.Filter({
						filterFn : function(item) {
							return regex.test(item.get('text'));
						}
					}));
				}
			}
		}
	});

	var treePanel = Ext.create('Ext.tree.Panel', {
		id : 'menuTree',
		region : 'west',
		split : true,
		title : '功能导航',
		width : 220,
		stateId : 'appnav',
		stateful : true,
		margins : '2 0 0 0',
		collapsible : true,
		animCollapse : true,
		xtype : 'treepanel',
		rootVisible : false,
		store : menuTreeStore,
		// tbar : [ treeFilterField ],
		listeners : {
			'itemclick' : function(e, record) {
				if (record.data.leaf) {
					globalObject.openTab(record.data.id, record.data.text, record.raw.url, {
						cButtons : record.raw.buttons ? record.raw.buttons.split(',') : [],
						cName : record.raw.menuCode,
						cParams : record.raw.menuConfig
					});
				}
			}
		}
	});

	var viewport = Ext.create('Ext.Viewport', {
		layout : 'border',
		items : [ {
			region : 'north',
			xtype : 'container',
			height : 50,
			id : 'app-header',
			layout : {
				type : 'hbox',
				align : 'middle'
			},
			defaults : {
				xtype : 'component'
			},
			items : [ {
				html : '<img src = "' + appBaseUri + '/static/img/logo.png" width="45" height="45" />',
				width : 55
			}, {
				id : 'app-header-title',
				html : appName,
				width : 700
			}, {
				html : '欢迎您，' + userName,
				style : 'text-align:center;font-size:14px;',
				flex : 1
			}, {
				width : 120,
				xtype : 'button',
				text : '个人中心',
				icon : appBaseUri + '/static/ext/examples/shared/icons/fam/user.gif',
				menu : [ {
					text : '修改密码',
					iconCls : 'icon_key',
					handler : function() {
						globalObject.openWindow('修改密码', 'profile.ChangePassword', 300);
					}
				}, '-', {
					text : '安全退出',
					handler : function() {
						top.location.href = appBaseUri + '/sys/sysuser/logout';
					}
				} ]
			} ]
		}, treePanel, mainTab, {
			region : 'south',
			border : false,
			items : [ Ext.create('Ext.ux.StatusBar', {
				border : false,
				text : '',
				style : 'background:#3892D3;',
				defaults : {
					style : 'color:#fff;'
				},
				items : [ '->', '绍兴文理学院元培学院 计算机1701 郑为中 《数据库编程》期末作品', '-', '©2020', '->', '->' ]
			}) ]
		} ]
	});

	function onTabChange(tabPanel, tab) {
		var tabs = [], ownerCt = tabPanel.ownerCt, oldToken, newToken;

		tabs.push(tab.id);
		tabs.push(tabPanel.id);

		while (ownerCt && ownerCt.is('tabpanel')) {
			tabs.push(ownerCt.id);
			ownerCt = ownerCt.ownerCt;
		}

		newToken = tabs.reverse().join(tokenDelimiter);

		oldToken = Ext.History.getToken();

		if (oldToken === null || oldToken.search(newToken) === -1) {
			Ext.History.add(newToken);
		}
	}

	function onAfterRender() {
		Ext.History.on('change', function(token) {
			var parts, tabPanel, length, i;

			if (token) {
				parts = token.split(tokenDelimiter);
				length = parts.length;

				for (i = 0; i < length - 1; i++) {
					Ext.getCmp(parts[i]).setActiveTab(Ext.getCmp(parts[i + 1]));
				}
			}
		});

		var activeTab1 = mainTab.getActiveTab(), activeTab2 = activeTab1;

		onTabChange(activeTab1, activeTab2);
	}
});

var globalObject = new Object();

// 打开tab
globalObject.openTab = function(tabId, tabTitle, tab, config) {
	// console.log(config);
	var _tab = mainTab.getComponent('tab' + tabId);
	if (!_tab) {
		mainTab.setLoading('Loading...');
		_tab = Ext.create('Ext.panel.Panel', {
			closable : true,
			id : 'tab' + tabId,
			title : tabTitle,
			layout : 'fit',
			autoScroll : true,
			border : false,
			items : typeof (tab) == 'string' ? Ext.create('Forestry.app.' + tab, config) : tab
		});
		mainTab.add(_tab);
		mainTab.setLoading(false);
	}
	mainTab.setActiveTab(_tab);
}

// 打开window
globalObject.openWindow = function(winTitle, win, winWidth, config) {
	Ext.create('Ext.window.Window', {
		autoShow : true,
		modal : true,
		title : winTitle,
		id : win,
		resizable : false,
		width : winWidth || 300,
		items : typeof (win) == 'string' ? Ext.create('Forestry.app.' + win, config) : win
	});
}

// 关闭tab
globalObject.closeTab = function(tabId) {
	var tab = mainTab.getActiveTab();
	tab.close();
	if (tabId != undefined) {
		mainTab.setActiveTab(tabId);
	}
};

// 刷新ActiveTab下的gridpanel
globalObject.listReload = function() {
	if (mainTab.getActiveTab().down('gridpanel'))
		mainTab.getActiveTab().down('gridpanel').getStore().reload();
}

// 成功提示
globalObject.msgTip = function(msg) {
	function createBox(t, s) {
		return '<div class="msg"><h3>' + t + '</h3><p>' + s + '</p></div>';
	}

	var msgCt;
	if (!msgCt) {
		msgCt = Ext.DomHelper.insertFirst(document.body, {
			id : 'msg-div'
		}, true);
	}
	var m = Ext.DomHelper.append(msgCt, createBox('系统信息', msg), true);
	m.hide();
	m.slideIn('t').ghost("t", {
		delay : 2000,
		remove : true
	});
};

// 错误提示
globalObject.errTip = function(msg, e) {
	Ext.MessageBox.show({
		title : '出错信息',
		msg : msg,
		buttons : Ext.MessageBox.OK,
		animateTarget : e,
		icon : Ext.MessageBox.ERROR
	});
};

// 一般提示
globalObject.infoTip = function(msg, e) {
	Ext.MessageBox.show({
		title : '系统信息',
		msg : msg,
		buttons : Ext.MessageBox.OK,
		animateTarget : e,
		icon : Ext.MessageBox.INFO
	});
};

// 选择性提示
globalObject.confirmTip = function(msg, fn, buttons, e) {
	Ext.MessageBox.show({
		title : '系统信息',
		msg : msg,
		buttons : buttons || Ext.MessageBox.YESNO,
		animateTarget : e,
		fn : fn
	});
};

// 控制台日志
globalObject.log = function(obj) {
	if (window.console) {
		console.log(obj);
	}
}

// 拥有指定权限
globalObject.haveAction = function(name) {
	return Ext.Array.contains(idata.myInfo.actions, name);
}

// 拥有指定按钮
globalObject.haveActionMenu = function(items, name) {
	if (items && items.length > 0)
		return Ext.Array.contains(items, name)
	return false;
}

// 拥有指定角色
globalObject.haveRole = function(name) {
	return Ext.Array.contains(idata.myInfo.roles, name);
}

// 执行指定Action
globalObject.run = function(url, params, itemStore) {
	Ext.Ajax.request({
		url : url,
		params : params,
		success : function(response) {
			if (response.responseText != '') {
				var res = Ext.JSON.decode(response.responseText);
				if (res.success) {
					globalObject.msgTip('操作成功！');
					if (itemStore)
						itemStore.reload();
				} else
					globalObject.errTip(res.msg);
			}
		}
	});
}

// 拥有指定列
globalObject.haveColumn = function(cName) {
	var columns = idata.myInfo.roleColumns[cName];
	this.have = function(columnName) {
		if (columns == undefined)
			return -2;
		return Ext.Array.contains(columns, columnName);
	}
}

function StringBuffer() {
	this._strings_ = new Array();
}

StringBuffer.prototype.append = function(str) {
	this._strings_.push(str);
};

StringBuffer.prototype.toString = function() {
	return this._strings_.join("");
};
