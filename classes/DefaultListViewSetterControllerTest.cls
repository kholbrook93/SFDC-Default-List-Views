@IsTest
public class DefaultListViewSetterControllerTest 
{
	public static testMethod void test()
    {
        Map<Id, Default_Listview__mdt> config = new Map<Id, Default_Listview__mdt>([SELECT Id, Object__c, Listview__c FROM Default_Listview__mdt]);
        if (config.size() == 0)
        {
            system.debug(LoggingLevel.WARN, 'No Default Listview records exist, thus the unit test cannot work.');
            return;
        }
        
        Test.startTest();
        	List<DefaultListViewController.Item> items = DefaultListViewController.getDefaultListviews();
        Test.stopTest();
        
        DefaultListViewController.Item itm = items[0];
        Default_Listview__mdt dlv = config.get(itm.DefaultId);
        
        system.assertEquals(dlv.Listview__c, itm.ListviewDeveloperName);
        system.assertEquals(dlv.Object__c, itm.ObjectName);
        system.assertEquals([SELECT Id FROM Listview WHERE SObjectType = :itm.ObjectName AND DeveloperName = :itm.ListviewDeveloperName].Id, itm.ListviewId);
    }
}