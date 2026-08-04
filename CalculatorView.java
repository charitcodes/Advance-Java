// import javax.swing.JButton;
// import javax.swing.JFrame;
// import javax.swing.JLabel;
// import javax.swing.JTextField;

// public class Cviews extends JFrame{

//     JLabel a ,b ,result;
//     JTextField txta,txtb,txtresult;
//     JButton add,sub,mul,div;

//     Cviews(){
//         setSize(500,500);
//         setLayout(null);
//         setTitle("Calculator");

//         // Value a
//         a = new JLabel("Enter value of A :");
//         a.setBounds(30,30,100,30);
//         add(a);

//         txta = new JTextField();
//         txta.setBounds(60,30,100,30);
//         add(txta);

//         // Value b
//         b = new JLabel("Enter the value of B :");
//         b.setBounds(30,60,100,30);
//         add(b);

//         txtb = new JTextField();
//         txtb.setBounds(100,60,100,30);
//         add(txtb);

//         add = new JButton("+");
//         add.setBounds(30,90,40,30);
//         add(add);

//         sub = new JButton("-");
//         sub.setBounds(70,90,40,30);
//         add(sub);

//         mul =new JButton("*");
//         mul.setBounds(90,90,40,30);
//         add(mul);

//         div = new JButton("/");
//         div.setBounds(110,90,40,30);
//         add(div);

//         result = new JLabel("Enter the value of B :");
//         result.setBounds(30,60,100,30);
//         add(result);

//         txtresult = new JTextField();
//         txtresult.setBounds(100,60,100,30);
        
//         add(txtresult);

//         setVisible(true);
//     }

// }
import javax.swing.*;

public class CalculatorView extends JFrame {
    JTextField txtNum1, txtNum2, txtResult;
    JButton btnAdd, btnSub, btnMul, btnDiv;

    public CalculatorView() {
        setTitle("MVC Calculator");
        setSize(400, 300);
        setLayout(null);

        JLabel l1 = new JLabel("First Number");
        l1.setBounds(30, 30, 100, 25);
        add(l1);

        txtNum1 = new JTextField();
        txtNum1.setBounds(150, 30, 150, 25);
        add(txtNum1);

        JLabel l2 = new JLabel("Second Number");
        l2.setBounds(30, 70, 100, 25);
        add(l2);

        txtNum2 = new JTextField();
        txtNum2.setBounds(150, 70, 150, 25);
        add(txtNum2);

        btnAdd = new JButton("+");
        btnAdd.setBounds(30, 120, 60, 30);
        add(btnAdd);

        btnSub = new JButton("-");
        btnSub.setBounds(100, 120, 60, 30);
        add(btnSub);

        btnMul = new JButton("*");
        btnMul.setBounds(170, 120, 60, 30);
        add(btnMul);

        btnDiv = new JButton("/");
        btnDiv.setBounds(240, 120, 60, 30);
        add(btnDiv);

        JLabel l3 = new JLabel("Result");
        l3.setBounds(30, 180, 100, 25);
        add(l3);

        txtResult = new JTextField();
        txtResult.setBounds(150, 180, 150, 25);
        txtResult.setEditable(false);
        add(txtResult);

        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setVisible(true);
    }
}