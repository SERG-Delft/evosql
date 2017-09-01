/* Copyright (c) 2001-2011, The HSQL Development Group
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * Neither the name of the HSQL Development Group nor the names of its
 * contributors may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL HSQL DEVELOPMENT GROUP, HSQLDB.ORG,
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


/* Filename: TestHarness.java
 * Created on May 18, 2005
 * Author: Carl Gould
 * Copyright Calmetrics 2005
 * Project: HSQLDB_Test
 */
package org.hsqldb.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

/**
 * Describe this class
 *
 * @author Carl
 */
public class TestHarness extends JFrame {

    protected String    dbURL;
    protected JTextArea textArea;

    public static void main(String[] args) {

        if (args.length == 0) {
            args = new String[]{ "testrecovery" };
        }

        try {
            Class.forName("org.hsqldb.jdbc.JDBCDriver").newInstance();
        } catch (Exception e) {
            System.out.println("ERROR: failed to load HSQLDB JDBC driver.");
            e.printStackTrace();

            return;
        }

        new TestHarness("jdbc:hsqldb:file:" + args[0]);
    }

    public TestHarness(String url) {

        super("HSQLDB Test Harness");

        this.dbURL = url;

        setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
        addWindowListener(new WindowAdapter() {

            public void windowClosing(WindowEvent e) {
                doClose();
            }
        });
        initComponents();
        setSize(400, 400);
        setLocation(200, 200);
        setVisible(true);

        try {
            Connection c = getConnection("sa", "password", true);

            textArea.setText("Database already exists.");
            c.close();
        } catch (SQLException e1) {
            doCreate();
        }
    }

    protected void initComponents() {

        Container main = getContentPane();

        textArea = new JTextArea();

        JPanel  buttons = new JPanel(new FlowLayout());
        JButton close   = new JButton("Close Gracefully");

        close.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                doClose();
            }
        });

        JButton create = new JButton("Add Row");

        create.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                doInsert();
            }
        });

        JButton list = new JButton("List Data");

        list.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                doListing();
            }
        });

        JButton kill = new JButton("Kill");

        kill.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });
        buttons.add(create);
        buttons.add(list);
        buttons.add(kill);
        buttons.add(close);
        main.add(new JScrollPane(textArea), BorderLayout.CENTER);
        main.add(buttons, BorderLayout.SOUTH);
    }

    protected void doInsert() {

        try {
            Connection con = getConnection("ABCD", "dcba", false);

            if (con != null) {
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(
                    "SELECT NEXT VALUE FOR MySeq FROM Dummy");

                rs.next();

                int id = rs.getInt(1);

                stmt.executeUpdate("INSERT INTO MyTable (Id, Name) VALUES ("
                                   + id + ", 'This is row #" + id + "')");
                append("Row #" + id + " added");
                stmt.close();
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doListing() {

        try {
            Connection con = getConnection("ABCD", "dcba", false);

            if (con != null) {
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(
                    "SELECT * FROM MyTable ORDER BY Id ASC");

                append("Listing 'MyTable'....");

                while (rs.next()) {
                    append("  " + rs.getString(1) + ", " + rs.getString(2));
                }

                append("...done.");
                stmt.close();
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void append(String s) {
        textArea.setText(textArea.getText() + "\n" + s);
    }

    protected void doClose() {

        try {
            Connection con = getConnection("sa", "password", false);

            if (con != null) {
                Statement stmt = con.createStatement();

                stmt.execute("SHUTDOWN");
                stmt.close();
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.exit(0);
    }

    protected void doCreate() {

        try {
            Connection con = getConnection("sa", "", false);

            if (con != null) {
                Statement stmt = con.createStatement();

                stmt.execute("SET PASSWORD 'password'");
                stmt.execute("CREATE USER abcd PASSWORD 'dcba'");
                stmt.execute("CREATE SEQUENCE MySeq");
                stmt.execute(
                    "CREATE TABLE MyTable (Id INT PRIMARY KEY, Name VARCHAR(100) NOT NULL)");
                stmt.execute("CREATE TABLE Dummy (Blah VARCHAR(100) NOT NULL)");
                stmt.execute(
                    "INSERT INTO Dummy (Blah) VALUES ('dummy value')");
                stmt.execute("GRANT ALL ON MyTable TO abcd");
                stmt.execute("GRANT ALL ON Dummy TO abcd");
                stmt.execute("GRANT ALL ON SEQUENCE MySeq TO abcd");
                stmt.close();
                con.close();
                textArea.setText("Database created.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected Connection getConnection(String username, String password,
                                       boolean ifExists) throws SQLException {

        Properties props = new Properties();

        props.put("user", username);
        props.put("password", password);
        props.put("ifexists", String.valueOf(ifExists));

        return DriverManager.getConnection(dbURL, props);
    }
}
