public class a1ques1
{
       public static void mymethod()
    {
        list<list<String>> list1 = new list<list<String>>{new list<String>{'a;b;a;v;c','a;a;b;b;c'},
                                                          new list<String>{'x;x;y;c;q'}};
        List<String> x = new List<String>();
                for(integer i = 0 ; i < list1.size() ; i++)
                        {
                                for(integer j = 0 ; j < list1[i].size() ; j++)
                                         {
                                            String str = list1[i][j];
                                               list<string> l = str.split(';');
                                            set<string> s1 = new set<string>();
                                            s1.addall(l);
                                            list<string> d = new list<string>(s1);
                                            d.sort();
                                            system.debug(d);
                                             String str1 = '';
                             for(integer k = 0; k<d.size();k++)
                        {
                                         if(k == d.size()-1)
                                {
                                        str1 += d[k];
                                             break;
                                         }
                                         str1 += d[k] + ';';
                             }
                                     x.add(str1);
                         }
                }
                                System.debug(x);
       }

}