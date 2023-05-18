trigger TET on OpportunityLineItem (after insert) 
{
    TETHandler.main(trigger.new);
}