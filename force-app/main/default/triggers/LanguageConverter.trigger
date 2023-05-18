trigger LanguageConverter on Account (after insert)
{
   for (Account a:trigger.new)
    {
        Language.getAccountLanguage(a.id);
    }
}