/*
 * StringList.java
 *
 * Created on 20 aprilie 2003, 09:20
 */

package siruri;

import java.util.StringTokenizer;
import java.util.Arrays;
/**
 *
 * @author  strimbeic
 */
public class StringList {
    private String[] listItems;
    private String listString;
    private StringBuffer listBuffer = new StringBuffer();
    private String delimitator = ",";
    /** Creates a new instance of StringList */
    public StringList(String[] list) {
        listItems = new String[list.length];
        for(int i = 0; i < list.length; i++){
            listItems[i] = list[i];
            //listString += delimitator + list[i];
            if (i==0)
                listBuffer.append(list[i]);
            else
                listBuffer.append(delimitator + list[i]);
        }
        listString = listBuffer.toString();
    }
    public StringList(String list){
        StringTokenizer stoke = new StringTokenizer(list, delimitator);
        listItems = new String[stoke.countTokens()];
        listString = list;
        String item;
        int i = 0;
        while (stoke.hasMoreElements()){
            item = stoke.nextToken();
            listItems[i] = item;
            i++;
        } 
        //listItems = list.split(delimitator);
    }
    public String getList(){
        return listString;
    }
    public String[] getListItems(){
        return listItems;
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        StringList sList = new StringList(new String[] 
            {"primul", 
             "al doilea", 
             "al treilea", 
             "al patrulea", 
             "al cincilea"});
        System.out.println(sList.getList());
        
        sList = new StringList("primul,al doilea,al treilea,al patrulea,al cincilea");
        for(int i=0; i < sList.getListItems().length; i++){
            System.out.println(sList.getListItems()[i]);
        }
        String input = "primul,al doilea,al treilea,al patrulea,al cincilea";
        System.out.println(Arrays.asList(input.split(",")));
        
    }
}