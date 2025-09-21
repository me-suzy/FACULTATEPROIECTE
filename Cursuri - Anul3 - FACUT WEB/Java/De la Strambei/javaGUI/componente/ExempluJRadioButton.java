/*
 * ExempluJRadioButton.java
 *
 * Created on May 18, 2004, 3:41 PM
 */

package javaGUI.componente;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

/**
 *
 * @author  strimbeic
 */
public class ExempluJRadioButton extends JFrame{
  JLabel jlabel;
  ButtonGroup grup;
  JRadioButton [] butoaneRadio;
  JRadioButton b1;
    public ExempluJRadioButton() {
        Container contentPane = getContentPane();
        jlabel = new JLabel();
        jlabel.setIcon(new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\5.jpg"));
        contentPane.add(jlabel);
        grup = new ButtonGroup();
        butoaneRadio = new JRadioButton[]{
          new JRadioButton("help"),
          new JRadioButton("exit"),
          new JRadioButton("find"),
        };
        contentPane.setLayout(new FlowLayout());
        for (int i = 0; i < butoaneRadio.length; ++i){
          grup.add(butoaneRadio[i]);
          contentPane.add(butoaneRadio[i]);
          butoaneRadio[i].addItemListener(new ItemListener(){
            public void itemStateChanged(ItemEvent e){
              refacere_imagine(e);
            }
          });
        }
        butoaneRadio[0].setSelected(true);       
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 300);          
      }
  public void refacere_imagine(ItemEvent e){
        if (butoaneRadio[0].isSelected())
         jlabel.setIcon(new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\5.jpg"));
        //if (e.getItemSelectable() == butoaneRadio[1])
        if (butoaneRadio[1].isSelected())
         jlabel.setIcon(new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\3.jpg"));
        //if (e.getItemSelectable() == butoaneRadio[2])
        if (butoaneRadio[2].isSelected())
          jlabel.setIcon(new ImageIcon("D:\\Working\\Professional\\POO_2004\\ProCurs\\img\\jpg\\4.jpg"));
  }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJRadioButton().show();
    }        
}
