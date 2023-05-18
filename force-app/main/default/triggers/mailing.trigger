trigger mailing on Account (before update)
{
  mailclass.main(trigger.newMap);
}