@isTest
public class DemoTestClass
{  
    @isTest
    public static void StripeTest()
    {
        System.Test.setMock(HttpCalloutMock.class, new DemoMockCallout());
        
        System.Test.startTest();
        
        testCallout.payment();
        
        System.Test.stopTest();
    }
    
}