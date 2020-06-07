({
	init : function(cmp, event, helper) {
        var action = cmp.get('c.getDefaultListviews');
                
        action.setCallback(this, function(response)
        {
            var items = response.getReturnValue();            
            var data = JSON.parse(window.localStorage.getItem('objectHomeStateManager'));
            if (data == null)
            {
                data = {};
            }
            
            for (var item of items)
            {
                var key = 'PinnedListView_' + item.UserId + '_' + item.ObjectName;
                
                if (!(key in data) || data[key].state.isDefault == true)
                {
                    console.log(key + ': setting value.');
                    
                    var obj = {};
                    obj.state = {};
                    obj.state.listViewId = item.ListviewId;
                    obj.state.developerName = item.ListviewDeveloperName;
                    obj.state.isDefault = true;
                    
                    data[key] = obj;
                }
                else
                {
                    console.log(key + ': skipping, user has custom pinned listview.');
                }
            }
            
            window.localStorage.setItem('objectHomeStateManager', JSON.stringify(data));
		});
        $A.enqueueAction(action);
	}
})