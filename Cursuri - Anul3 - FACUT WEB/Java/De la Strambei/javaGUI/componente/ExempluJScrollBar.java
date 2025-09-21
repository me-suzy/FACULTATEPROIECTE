/*
 * ExempluJScrollBar.java
 *
 * Created on May 19, 2004, 4:17 PM
 */

package javaGUI.componente;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;

/**
 *
 * @author  strimbeic
 */
public class ExempluJScrollBar extends JFrame{
  JScrollBar sbar = new JScrollBar(JScrollBar.VERTICAL, 0, 20, 0, 180);
  JPanelScroll jpanel = new JPanelScroll();    
    /** Creates a new instance of ExempluJScrollBar */
    public ExempluJScrollBar() {
        Container contentPane = getContentPane();
        sbar.setBorder(BorderFactory.createLineBorder(Color.black));
        contentPane.add(jpanel, BorderLayout.WEST);
        contentPane.add(sbar, BorderLayout.EAST);

        sbar.addAdjustmentListener(new AdjustmentListener(){
          public void adjustmentValueChanged(AdjustmentEvent e){
            JScrollBar sb = (JScrollBar)e.getSource();
            jpanel.setScrolledPosition(e.getValue());
            jpanel.repaint();
          }
        });
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 225);    
    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new ExempluJScrollBar().show();
    }    
}
class JPanelScroll extends JPanel{
    JLabel jlabel = new JLabel("Componenta Swing");
    int y= 0;
    JPanelScroll(){
        add(jlabel);
    }
    public void paintComponent(Graphics g){
        super.paintComponent(g);
        jlabel.setLocation(0, y);
    }
    public void setScrolledPosition(int p){
        y = p;
    }
}

