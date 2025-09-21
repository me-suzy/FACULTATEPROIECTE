/*
 * ExempluJTextField.java
 *
 * Created on May 18, 2004, 3:18 PM
 */

package javaGUI.componente;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class ExempluJTextField extends JFrame{
    JTextField text = new JTextField();
    /** Creates a new instance of ExempluJTextField */
    public ExempluJTextField() {
        Container cp = getContentPane();
        cp.setLayout(new FlowLayout());
        cp.add(text);
        text.setText("Text cu JTextField");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 300);
        
        text.addActionListener(new ActionListener() {
          public void actionPerformed(ActionEvent e){
                    // secven?a de cod ce trebuie executat? la apari?ia ecenimentului sau
                    // apel la o eventual? metod? din cadrul p?rinte în care s? fie tratat explicit acest eveniment
            System.out.println("Textul introdus " + e.getActionCommand());
          }
        });
        
    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJTextField().show();
    }
}
