/* Copyright (c) 2001-2014, The HSQL Development Group
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


package org.hsqldb.cmdline.sqltool;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.regex.Pattern;
import java.util.EnumSet;

public class Calculator {
    private List<Atom> atoms = new ArrayList<Atom>();
    private static Pattern intPattern = Pattern.compile("[+-]?\\d+");
    private Map<String, String> vars;

    private enum MathOp {
        LPAREN('('),
        RPAREN(')'),
        ADD('+'),
        SUBTRACT('-'),
        MULTIPLY('*'),
        DIVIDE('/'),
        REM('%'),
        POWER('^')
        ;
        MathOp(char c) { this.c = c; }
        private char c;
        public String toString() { return Character.toString(c); }
        public static MathOp valueOf(char c) {
            for (MathOp o : MathOp.values())
                if (o.c == c) return o;
            return null;
        }
    }
    private EnumSet<MathOp> TradOrLParen =
            EnumSet.of(MathOp.ADD, MathOp.SUBTRACT, MathOp.LPAREN,
            MathOp.MULTIPLY, MathOp.DIVIDE, MathOp.REM, MathOp.POWER);

    private long deref(String varName) {
        if (!vars.containsKey(varName))
            throw new IllegalStateException("Undefined variable: " + varName);
        try {
            return Long.parseLong(vars.get(varName));
        } catch (NumberFormatException nfe) {
            throw new IllegalStateException(
                    "Variable's value not an integer: " + varName);
        }
    }

    private class Atom {
        /* Atoms do not hold variables.
         * Makes for nice simplification by dereferencing variable names in
         * the constructor and just dealing with integer values thereafter. */
        private Atom(String token) {
            /*
            if (token == null || token.length() < 1)
                throw new IllegalArgumentException(
                        "Tokens must have length > 1, but was '" + token + "'");
            */
            if (token == null)
                throw new IllegalArgumentException("Tokens may not be null");
            if (token.length() < 1)
                throw new IllegalArgumentException("Tokens may not be empty");
            if (intPattern.matcher(token).matches()) {
                val = Long.parseLong(token);
                return;
            }
            if (token.length() == 1) {
                op = MathOp.valueOf(token.charAt(0));
                if (op != null) return;
            }
            // System.err.println("Trying '" + token + "'");
            val = deref(token);
        }
        private Atom(MathOp op) { this.op = op; }
        private Atom(long val) { this.val = val; }
        public MathOp op;
        public long val;
        public String toString() {
            return (op == null) ? Long.toString(val) : op.toString();
        }
    }

    public String toString() {
        return atoms.toString();
    }

    public Calculator(String[] sa, Map<String, String> vars) {
        /* Populates the atom list.
         * Also collapses 2-part negative numbers into single Atoms. */
        if (vars.size() < 1)
            throw new IllegalArgumentException("No expression supplied");
        this.vars = vars;
        Atom atom = null, prePrevAtom;
        int prevIndex;
        NEXT_TOKEN:
        for (String token : sa) try {
            atom = new Atom(token);
            prevIndex = atoms.size() - 1;
            if (prevIndex < 0) continue;
            if (atoms.get(prevIndex).op != MathOp.SUBTRACT) continue;
            prePrevAtom = (prevIndex > 0) ? atoms.get(prevIndex-1) : null;
            if (prePrevAtom != null && !TradOrLParen.contains(prePrevAtom.op))
                continue;

            if (atom.op == null) {
                atoms.remove(prevIndex);
                atom.val *= -1;
            } else if (atom.op == MathOp.LPAREN) {
                atoms.remove(prevIndex);
                atoms.add(new Atom(-1L));
                atoms.add(new Atom(MathOp.MULTIPLY));
            }
        } finally {
            atoms.add(atom);
        }
    }

    /**
     * Every integer, var name, and single-math-op-character get their own
     * tokens here.
     * Special processesing is needed afterwards because negative signs get
     * separated into separate tokens.
     */
    public Calculator(String s, Map<String, String> vars) {
        this(s.replaceAll("([-()*/+^])", " $1 ")
                .trim().split("\\s+"), vars);
    }
    /**
     * If atoms[startAtomIndex] == '(', then last visited atoms will be the
     * next top-level (un-paired) ')'.
     * Otherwise, all remainign atoms will be visited.
     * Every visited atom will be removed from 'atoms'.
     *
     * @return Value that all visited atoms reduce to.
     */
    public long reduce(int startAtomIndex, boolean stopAtParenClose) {
        // Every occurence of atoms.remove() below is an instance of reduction.
        int i;
        Long prevValue = null;
        Atom atom;
        // Reduce parens via recursion
        i = startAtomIndex - 1;
        PAREN_SEEKER:
        while (atoms.size() >= ++i) {
            if (atoms.size() == i) {
                if (stopAtParenClose)
                    throw new IllegalStateException(
                            "Unbalanced '" + MathOp.LPAREN + "'");
                break;
            }
            atom = atoms.get(i);
            if (atom.op != null) switch (atom.op) {
              case RPAREN:
                if (!stopAtParenClose)
                    throw new IllegalStateException(
                            "Unbalanced '" + MathOp.RPAREN + "'");
                atoms.remove(i);
                break PAREN_SEEKER;
              case LPAREN: // Recurse.  Reduction inside of reduce().
                atoms.remove(i);
                atoms.add(i, new Atom(reduce(i, true)));
                break;
              default:
                // Intentionally empty
            }
        }
        int remaining = i - startAtomIndex;
        if (remaining < 1)
            throw new IllegalStateException("Empty expression");
        // System.out.println("Need to consume " + remaining + " after parens removed");
        Atom nextAtom;
        MathOp op;

        // Reduce powers
        i = startAtomIndex;
        atom = atoms.get(i);
        if (atom.op != null)
            throw new IllegalStateException(
                    "Expected initial value expected but got operation "
                    + atom.op);
        while (startAtomIndex + remaining > i + 1) {
            if (startAtomIndex + remaining < i + 3)
                throw new IllegalStateException(
                        "No operator/operand pairing remaining");
            nextAtom = atoms.get(i + 1);
            if (nextAtom.op == null)
                throw new IllegalStateException(
                        "Operator expected but got value " + nextAtom.val);
            op = nextAtom.op;
            nextAtom = atoms.get(i + 2);
            if (nextAtom.op != null)
                throw new IllegalStateException(
                        "Value expected but got operator " + nextAtom.op);
            if (op != MathOp.POWER) {
                // Skip 'atom' (current) and the operand that we'll handle later
                i += 2;
                atom = nextAtom;
                continue;
            }
            // Reduce the operator and right operand Atoms
            remaining -= 2;
            atoms.remove(i + 1);
            atoms.remove(i + 1);
            long origVal = atom.val;
            atom.val = 1;
            for (int j = 0; j < nextAtom.val; j++) atom.val *= origVal;
        }

        // Reduce multiplication and division
        i = startAtomIndex;
        atom = atoms.get(i);
        if (atom.op != null)
            throw new IllegalStateException(
                    "Expected initial value expected but got operation "
                    + atom.op);
        while (startAtomIndex + remaining > i + 1) {
            if (startAtomIndex + remaining < i + 3)
                throw new IllegalStateException(
                        "No operator/operand pairing remaining");
            nextAtom = atoms.get(i + 1);
            if (nextAtom.op == null)
                throw new IllegalStateException(
                        "Operator expected but got value " + nextAtom.val);
            op = nextAtom.op;
            nextAtom = atoms.get(i + 2);
            if (nextAtom.op != null)
                throw new IllegalStateException(
                        "Value expected but got operator " + nextAtom.op);
            if (op != MathOp.MULTIPLY && op != MathOp.DIVIDE && op != MathOp.REM) {
                // Skip 'atom' (current) and the operand that we'll handle later
                i += 2;
                atom = nextAtom;
                continue;
            }
            // Reduce the operator and right operand Atoms
            remaining -= 2;
            atoms.remove(i + 1);
            atoms.remove(i + 1);
            if (op == MathOp.MULTIPLY) atom.val *= nextAtom.val;
            else if (op == MathOp.DIVIDE) atom.val /= nextAtom.val;
            else atom.val %= nextAtom.val;
        }

        // Reduce addition and subtraction
        // Reduce the leading value
        atom = atoms.remove(startAtomIndex);
        remaining--;
        if (atom.op != null)
            throw new IllegalStateException(
                    "Value expected but got operation " + atom.op);
        long total = atom.val;
        while (remaining > 0) {
            // Reduce the operator Atom
            --remaining;
            atom = atoms.remove(startAtomIndex);
            op = atom.op;
            // System.err.println("Trying +/- for " + op);
            if (op == null)
                throw new IllegalStateException(
                        "Operator expected but got value " + atom.val);
            if (remaining <= 0)
                throw new IllegalStateException("No operand for operator " + op);
            // Reduce the right operand
            --remaining;
            atom = atoms.remove(startAtomIndex);
            if (atom.op != null)
                throw new IllegalStateException(
                        "Value expected but got operation " + atom.op);
            switch (op) {
              case ADD:
                total += atom.val;
                break;
              case SUBTRACT:
                total -= atom.val;
                break;
              default:
                throw new IllegalStateException("Unknown operator: " + op);
            }
        }

        return total;
    }

    /* TODO:  Replace this method with a proper unit test class */
    public static void main(String[] sa) {
        if (sa.length != 1)
            throw new IllegalArgumentException(
                    "SYNTAX: java Calculator 'expression'");
        Map<String, String> uV = new HashMap<String, String>();
        uV.put("one", "1");
        uV.put("two", "2");
        uV.put("three", "3");
        uV.put("four", "4");
        uV.put("five", "5");
        uV.put("six", "6");
        uV.put("seven", "7");
        uV.put("eight", "8");
        uV.put("nine", "9");
        Calculator calc = new Calculator(sa[0], uV);
        System.out.println(calc);
        System.out.println(calc.reduce(0, false));
        /*
        if (sa[0].length() != sa[0].length()) {
            System.out.println((sa[0].length() >= sa[0].length()) ? ">" : "<");
            return;
        }
        int val = sa[0].compareTo(sa[1]);
        if (val == 0)
            System.out.println("==");
        else if (val > 0)
            System.out.println(">");
        else
            System.out.println("<");
        */
    }

    /**
     * Does not actually do the assigment, but validates the input variable
     * and returns the value ready to be assigned to it.
     */
    public static long reassignValue(String assignee,
            Map<String, String> valMap, String opStr, String expr) {
        long outVal = 0;
        try {
            outVal = Long.parseLong(valMap.get(assignee));
        } catch (NumberFormatException nfe) {
            throw new IllegalArgumentException(
                    "Can not perform a self-operation on a non-integer: "
                    + assignee);
        }
        Long rhValObj = (expr == null || expr.trim().length() < 1) ? null
                : Long.valueOf(
                        new Calculator(expr, valMap).reduce(0, false));
        if (opStr.equals("++")) {
            if (rhValObj != null)
                throw new IllegalStateException(
                        "++ operator takes no right hand operand");
            return 1 + outVal;
        }
        if (opStr.equals("--")) {
            if (rhValObj != null)
                throw new IllegalStateException(
                        "++ operator takes no right hand operand");
            return outVal - 1;
        }
        if (rhValObj == null)
            throw new IllegalStateException(
                    "Operator requires a right hand operand: " + opStr);
        long rhVal = rhValObj.intValue();
        if (opStr.equals("+=")) {
            outVal += rhVal;
        } else if (opStr.equals("-=")) {
            outVal -= rhVal;
        } else if (opStr.equals("*=")) {
            outVal *= rhVal;
        } else if (opStr.equals("/=")) {
            outVal /= rhVal;
        } else if (opStr.equals("%=")) {
            outVal %= rhVal;
        } else {
            throw new IllegalStateException("Unsupported operator: " + opStr);
        }
        return outVal;
    }
}
