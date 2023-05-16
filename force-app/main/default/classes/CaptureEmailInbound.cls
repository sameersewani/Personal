global class CaptureEmailInbound implements Messaging.InboundEmailHandler
{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env) 
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        String myPlainText = email.plainTextBody; //this is  email body content that you can save where needed
        String defaultAccount = 'Default Account';
        String accountId;
        try 
        {
            List <Account> acclist = [Select id, name from Account where name like: email.subject];
            //find an account id first that has account name matching the subject of email	
            if (acclist.size()==0) 
            {
                for (Account a: acclist) 
                {
                    accountId = a.Id;
                    break;
                }
            } 
            else 
            {
                Account account = new Account();
                account.name = email.subject;
                insert account;
                system.debug('aa'+account);
                accountId = account.Id;
            }
            // Save attachments, if any (both text and binary)
            for (Messaging.Inboundemail.TextAttachment tAttachment: email.textAttachments) 
            {
                Attachment attachment = new Attachment();
                attachment.Name = tAttachment.fileName;
                attachment.Body = Blob.valueOf(tAttachment.body);
                attachment.ParentId = accountId;
                insert attachment;
            }
            for (Messaging.Inboundemail.BinaryAttachment bAttachment: email.binaryAttachments) 
            {
                Attachment attachment = new Attachment();
                attachment.Name = bAttachment.fileName;
                attachment.Body = bAttachment.body;
                attachment.ParentId = accountId;
                insert attachment;
            }
        } 
        catch (Exception e) 
        {
            
            result.success = false;
            result.message = 'Oops, I failed.' + e + myPlainText;
        }
        return result;
    }
}