/*
 * FormularAplicatie.java
 *
 * Created on May 26, 2004, 8:24 PM
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
public class FormularAplicatie extends JPanel{
    public final static int MODAL = 1;
    public final static int MODELESS = 2;
    
    private Window form;
    private int windowType = MODAL;
    /** Creates a new instance of FormularAplicatie */
    public FormularAplicatie() {
    }
    public void setWindowType(int type){
        if (type == 1 || type == 2)
            windowType = type;
    }
    public void activate(){
        initComponents();
        if (windowType == MODELESS){
            form = new JFrame();
            ((JFrame)form).setContentPane(this);
            ((JFrame)form).setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        }else {
            form = new JDialog();
            ((JDialog)form).setModal(true);
            ((JDialog)form).setContentPane(this);
            ((JDialog)form).setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        }   
        form.setSize(250, 250);
        form.setVisible(true);
        
    }
    private void initComponents(){
        this.setLayout(new FlowLayout());
        button = new JButton("Inchide formularul");
        button.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                form.dispose();
            }
        });
        label = new JLabel("Acesta este un formular " + 
            (windowType==MODAL?"modal":"nemodal"));
        add(label);
        add(button);
    }
    private JButton button;
    private JLabel label;
}

