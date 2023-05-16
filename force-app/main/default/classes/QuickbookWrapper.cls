public class QuickbookWrapper
{
    
	public cls_eventNotifications[] eventNotifications;
	public class cls_eventNotifications 
    {
		public String realmId;	//4620816365220401130
		public  cls_dataChangeEvent dataChangeEvent;
	}
	public class cls_dataChangeEvent
    {
		public cls_entities[] entities;
	}
	class cls_entities
    {
		public String name;	//Customer
		public String id;	//106
		public String operation;	//Update
		public String lastUpdated;	//2022-09-01T12:52:29.000Z
	}
	public static QuickbookWrapper parse(String json)
    {
		return (QuickbookWrapper) System.JSON.deserialize(json, QuickbookWrapper.class);
	}

	/*static testMethod void testParse()
    {
		String json='{"eventNotifications":[{"realmId":"4620816365220401130","dataChangeEvent":{"entities":[{"name":"Customer","id":"106","operation":"Update","lastUpdated":"2022-09-01T12:52:29.000Z"}]}}]}';
		fromJSON obj = parse(json);
		System.assert(obj != null);
	}*/    
 }