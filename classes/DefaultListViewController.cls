public class DefaultListViewController 
{
	@AuraEnabled
    public static List<Item> getDefaultListviews()
    {
        List<Item> rtn = new List<Item>();
        List<Default_Listview__mdt> config = [SELECT Id, Object__c, Listview__c FROM Default_Listview__mdt];
        
        Map<string, Listview> listviews = new Map<string, Listview>();
        
        Set<string> listviewDeveloperNames = new Set<string>();
        for (Default_Listview__mdt itm : config)
        {
            listviewDeveloperNames.add(itm.Listview__c);
        }
        
        for (Listview lv : [SELECT Id, DeveloperName, SObjectType FROM Listview WHERE DeveloperName IN :listviewDeveloperNames])
        {
            listviews.put(getKey(lv.SobjectType, lv.DeveloperName), lv);
        }        
        
        for (Default_Listview__mdt itm : config)
        {
            string obj = itm.Object__c.trim();
            string devname = itm.Listview__c.trim();
            
            Listview lv = listviews.get(getKey(obj, devname));
            
            Item i = new Item();
            i.DefaultId = itm.Id;
            i.UserId = UserInfo.getUserId();
            i.ObjectName = lv.SobjectType;
            i.ListviewDeveloperName = lv.DeveloperName;
            i.ListviewId = lv.Id;
            rtn.add(i);
        }
        
        return rtn;
    }
    
    private static string getKey(string obj, string devname)
    {
        return obj + ':' + devname;
    }
    
    public class Item
    {
        public Id DefaultId; 
        
        @AuraEnabled
        public string UserId { get; set; }
        
        @AuraEnabled
        public string ObjectName { get; set; }
        
        @AuraEnabled
        public string ListviewId { get; set; }
        
        @AuraEnabled
        public string ListviewDeveloperName { get; set; }
    }
}