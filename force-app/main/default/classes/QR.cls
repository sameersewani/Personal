public class QR 
{
    @future(callout=true)
    public static void main(String Id)
    {
        String url='https://cyntexa-2c6-dev-ed.lightning.force.com/lightning/r/Lead/'+Id+'/view';
         HTTP h = new HTTP();
        HttpRequest req = new HttpRequest();
       
        req.setEndpoint('https://api.happi.dev/v1/qrcode?data='+url+'&width=&dots=000000&bg=FFFFFF&apikey=4f0e742VP4FQRXjSgEtcASoaNAWZCQ9oftZCMuGg1zOx3a9xkjBodG12');
        req.setMethod('GET');
        HTTPResponse res = h.send(req);
        Map<String,Object> result = (Map<String,Object>)Json.deserializeUntyped(res.getBody());
        system.debug(result);
       
        String s=(String)result.get('qrcode');
        System.debug(s);
        String hi='';
        String [] temp=s.split(',');
        hi=temp[1];
        
        Blob tempBlob = EncodingUtil.base64Decode(hi);
        System.debug(tempBlob);
       
        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
       
        efa.setFileName('QR Code');
        efa.setBody(tempBlob);
        efa.setContentType('image/png');
            
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        list<String> emailAddr = new list<String>();
        emailAddr.add('sameersewani@cyntexa.com');
        mail.setToAddresses(emailAddr);
        mail.setPlainTextBody('Hello');
       
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        //Messaging.SendEmailResult[] r = Messaging.sendEmail(new  Messaging.Singleemailmessage[] {mail});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
       
     
    }

}