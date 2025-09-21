/*
 * ExempluJFrame.java
 *
 * Created on 14 aprilie 2003, 13:27
 */

package javaGUI;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
/**
 *
 * @author  strimbeic
 */
public class ExempluJFrame extends JFrame implements ActionListener, WindowListener{ 
    /** Creates a new instance of ExempluJFrame */
    public void actionPerformed(ActionEvent event){
        //System.exit(0);
    }    
    public ExempluJFrame() {
        JButton buton = new JButton("Inchide");
        buton.setForeground(Color.BLUE);
        buton.setBackground(Color.RED);
        buton.setLocation(new Point(100, 100));
        buton.setSize(new Dimension(100, 30));
        getContentPane().add(buton);
        setSize(400, 400);
        getContentPane().setLayout(null);
        //buton.addActionListener(this);
        buton.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent event){
                System.exit(0);
            }
        });
    }
    public void windowClosing(WindowEvent event){
    System.exit(0);
    }
    public void windowClosed(WindowEvent event){}
    public void windowActivated(WindowEvent event){}
    public void windowDeactivated(WindowEvent event){}
    public void windowIconified(WindowEvent event){}
    public void windowDeiconified(WindowEvent event){}
    public void windowOpened(WindowEvent event){}
    
    public static void main(String[] args){
        new ExempluJFrame().show();
    }
}    
