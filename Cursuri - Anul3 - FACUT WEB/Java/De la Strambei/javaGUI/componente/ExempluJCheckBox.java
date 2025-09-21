/*
 * ExempluJCheckBox.java
 *
 * Created on May 18, 2004, 3:32 PM
 */

package javaGUI.componente;
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

/**
 *
 * @author  strimbeic
 */
public class ExempluJCheckBox extends JFrame implements ItemListener{
    JCheckBox check1, check2, check3, check4;
    JTextField text;
    public ExempluJCheckBox() {
        Container contentPane = getContentPane();
        contentPane.setLayout(new FlowLayout());

        check1 = new JCheckBox("Opt 1");
        check2 = new JCheckBox("Opt 2");
        check3 = new JCheckBox("Opt 3");
        check4 = new JCheckBox("Opt 4");

        check1.addItemListener(this);
        check2.addItemListener(this);
        check3.addItemListener(this);
        check4.addItemListener(this);

        contentPane.add(check1);
        contentPane.add(check2);
        contentPane.add(check3);
        contentPane.add(check4);

        text = new JTextField(20);

        contentPane.add(text);
        
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 300);            
    }
    public void itemStateChanged(ItemEvent e)
    {
        String text_ = "Ai selectat ";
        if (check1.isSelected()) text_ += "1, ";
        if (check2.isSelected()) text_ += "2, ";
        if (check3.isSelected()) text_ += "3, ";
        if (check4.isSelected()) text_ += "4, ";
        text.setText(text_);

    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJCheckBox().show();
    }        
}
