package javaGUI;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;

public class AplicatieSchimbLookAndFeel {
  public AplicatieSchimbLookAndFeel(){
    JFrameApp jframe = new JFrameApp("Aplicatie");
    jframe.pack();
    jframe.validate();
    jframe.setVisible(true);
  }
  public static void main(String[] args) {
    AplicatieSchimbLookAndFeel app = new AplicatieSchimbLookAndFeel();
  }
}

class JFrameApp extends JFrame {
  JFrameApp(String titlu){
    super(titlu);
    Container contentPane = getContentPane();
    PanelJFrameApp framePanel = new PanelJFrameApp();
    contentPane.add(framePanel);
    // pentru inchiderea aplicatiei
    setDefaultCloseOperation(EXIT_ON_CLOSE);
  }
}
class PanelJFrameApp extends JPanel implements ActionListener{
  JRadioButton rb1 = new JRadioButton("Metal");
  JRadioButton rb2 = new JRadioButton("Motif");
  JRadioButton rb3 = new JRadioButton("Windows");
  JRadioButton rb4 = new JRadioButton("Skin");
  JRadioButton rb5 = new JRadioButton("Plastic");
  JRadioButton rb6 = new JRadioButton("PlasticXP");

  PanelJFrameApp(){
    setLayout(new FlowLayout());
    add(new JButton("Buton"));
    add(new JTextField("TextField"));
    add(new JCheckBox("CheckBox"));
    add(new JRadioButton("Buton Radio"));
    JList jList = new JList(new String []
      {"Element 1", "Element 2", "Element 3", "Element 4"});
    jList.setBorder(BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.LOWERED));
    add(new JScrollPane(jList,
        JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, 
        JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS));
    JScrollBar jScrollBar = new JScrollBar(JScrollBar.HORIZONTAL, 10, 10, 0, 180);
    
    add(jScrollBar);

    ButtonGroup grup = new ButtonGroup();
    grup.add(rb1);
    grup.add(rb2);
    grup.add(rb3);
    grup.add(rb4);
    grup.add(rb5);
    grup.add(rb6);

    rb1.addActionListener(this);
    rb2.addActionListener(this);
    rb3.addActionListener(this);
    rb4.addActionListener(this);
    rb5.addActionListener(this);
    rb6.addActionListener(this);
    
    JPanel panouButoane = new JPanel(new FlowLayout());
    panouButoane.add(rb1);
    panouButoane.add(rb2);
    panouButoane.add(rb3);
    panouButoane.add(rb4);
    panouButoane.add(rb5);
    panouButoane.add(rb6);
    JScrollPane scrollPane = new JScrollPane(panouButoane, 
        JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, 
        JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
    add(scrollPane);

  }
  public void actionPerformed(ActionEvent e){
   try {
      if((JRadioButton)e.getSource() == rb1)
       UIManager.setLookAndFeel("javax.swing.plaf.metal.MetalLookAndFeel");
      if((JRadioButton)e.getSource() == rb2)
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.motif.MotifLookAndFeel");
      if((JRadioButton)e.getSource() == rb3)
        UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
      if((JRadioButton)e.getSource() == rb4)
        UIManager.setLookAndFeel("com.l2fprod.gui.plaf.skin.SkinLookAndFeel");      
      if((JRadioButton)e.getSource() == rb5)
        UIManager.setLookAndFeel("com.jgoodies.plaf.plastic.Plastic3DLookAndFeel");
      if((JRadioButton)e.getSource() == rb6)
        UIManager.setLookAndFeel("com.jgoodies.plaf.plastic.PlasticXPLookAndFeel");
    }
    catch(Exception excpt){}
    SwingUtilities.updateComponentTreeUI(this);
  }
}
