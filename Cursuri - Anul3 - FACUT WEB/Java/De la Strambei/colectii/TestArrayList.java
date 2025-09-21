/*
 * TestArrayList.java
 *
 * Created on 29 mai 2003, 11:55
 */

package colectii;
import java.util.*;
/**
 *
 * @author  strimbeic
 */
public class TestArrayList {
    public static void main(String[] args) {
        List list = new ArrayList(2);
        list.add("primul");
        list.add("al doilea");
        list.add("al doilea");
        list.add("al treilea"); // am depasit deja capacitatea initiala, asa ca
        // lista va final obligata sa-si redefineasca automat dimensiunea
        list.add(3, "al patrulea"); // operatie validata fiindca urmeaza indexul 3
        //list.add(5, "primul"); // operatie validata fiindca urmeaza indexul 4
        list.add(4, "al cincilea");
        list.add(2,  "ultimul");
        
        // Parcurgem lista in stil "clasic":
        System.out.println("Iteratie clasica folosind for()");
        for(int i=0; i<list.size(); i++)
            System.out.println(list.get(i));
        
        // Parcurgem lista prin interator in ordinea indexarii:
        System.out.println("Iteratie cu iterator in ordinea indexarii");
        // Obtin un iterator care porneste de la primul index
        Iterator iterator = list.listIterator();
        while(iterator.hasNext())
            System.out.println(iterator.next());
        
        // Parcurgem lista prin interator in ordine inversa:
        System.out.println("Iteratie cu iterator in ordinea inversa indexarii)");
        // Reconsider iteratorul anterior ca ListIterator, si care
        // in iteratia de mai jos va porni de la ultimul element, la
        // care a ajuns prin iteratia de msi sus
        ListIterator listIterator = (ListIterator)iterator;
        while(listIterator.hasPrevious())
            System.out.println(listIterator.previous());   
    }
}
