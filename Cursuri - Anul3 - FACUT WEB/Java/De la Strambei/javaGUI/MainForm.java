/*
 * MainForm.java
 *
 * Created on 10 mai 2003, 18:43
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
public class MainForm extends JFrame{
    
    /** Creates a new instance of MainForm */
    public MainForm() {
        this.setJMenuBar(new MainMenuBar());
        ((MainMenuBar)(this.getJMenuBar())).frmParent = this;
        this.setContentPane(new JDesktopPane());
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setSize(500, 500);
        this.setVisible(true);
    }
    public static void main(String[] args) throws Exception{
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        new MainForm();
    }
}
