public class tes
{
    public static PageReference redirectToNewPage() 
    {
        // Redirect the user to a different page
        PageReference newPage = new PageReference('www.google.com');
        return newPage.setRedirect(true);
    }
    
}