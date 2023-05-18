trigger CityTrigger on City__c (after insert)
{
    for (City__c a:trigger.new)
    {
        HotelApi.getHotels(a.Name);
        
    }

}