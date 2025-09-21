/*
 * Test.java
 *
 * Created on 10 martie 2003, 09:54
 */
/**
 *
 * @author  strimbeic
 */
public class Test extends SuperTest{
    public float X = 1;
    /** Creates a new instance of Test */
    public Test() {
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        //SuperTest t1 = new Test();
        //System.out.println(t1.getX());
        /*Companie o_companie = new Companie("A", "B", "C");
        double rand = Math.random() * 10;
        System.out.println(rand);
        System.out.println(Math.floor(rand));*/
        
        /*Disciplina disc = new Disciplina("DISC01", "Disciplina A");        
        Specializare spec = new Specializare("SPEC01", "Specializarea A", 4, 1);
        spec.addDiscPlanInvatamint(disc, 0, true,
            new ModEvaluare1(20, 20, 15));
        Student stud = new Student("MA001", "Student", "A");
        stud.inscriere(spec, 3);
        stud.initializeazaExamene();
        stud.examene[0].setCriteriiEvaluare(5, 6, 5, 8);
        stud.examene[0].calculeazaNotaFinala();*/
        //Integer[] b = new Integer[]{new Integer(1), new Integer(2)};
        //Integer[] b = {new Integer(1), new Integer(2)};
        //System.out.println(b[1]);
        boolean test = true;
        if (test){
            int i = 0;
            i++;
        }
        int i =2;
        System.out.println(i);
        
        class InnerTest{
            int j;
            void mtd(int j){
                this.j = ++j;
            }
        }
        
        InnerTest it = new InnerTest();
        it.mtd(20);
        System.out.println(it.j);
    }
    
}
