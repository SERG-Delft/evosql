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


package org.hsqldb.cmdline.sqltool;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.FileInputStream;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

/**
 * This class does not impement or extend java.io classes/interfaces, and is
 * not a Reader in the sense of java.io.Reader.
 * It is a 'reader' in the sense that it provides a method that reads and
 * return records from a text file.
 *
 * The unique use case here is that records are delimited with a regular
 * expression pattern yet the file contents are read incrementally to minimize
 * RAM usage.
 */
public class FileRecordReader {
    /*
     * We purposefully use a non-buffered Reader.  We are doing buffering
     * outselves.
     * We have to read linearly from the front, so combined with previous
     * requirement, that narrows us to FileReader or FileInputStream.
     * Since we need to get at characters, FileReader is the most direct
     * tool for us to use.
     */

    // Can lower dramatically, all the way to 1, to test buffering.
    public static final int INITIAL_CHARBUFFER_SIZE = 10240;
    private File file;
    private InputStreamReader reader;
    private Pattern recordPattern;
    private long postRead;
    private StringBuilder stringBuffer = new StringBuilder();
    private char[] charBuffer = new char[INITIAL_CHARBUFFER_SIZE];

    /**
     * @throws java.util.regex.PatternSyntaxException
     * @throws UnsupportedEncodingException
     */
    public FileRecordReader(
            String filePath, String recordDelimiterRegex, String encoding)
            throws FileNotFoundException, UnsupportedEncodingException {
        file = new File(filePath);
        reader = new InputStreamReader(new FileInputStream(file), encoding);
        recordPattern = Pattern.compile(
                "(.*?)(" + recordDelimiterRegex + ").*", Pattern.DOTALL);
    }

    /**
     * Free up resources and close all potentially open I/O streams.
     */
    public void close() throws IOException {
        if (reader == null)
            throw new IllegalStateException("File already closed: " + file);
        reader.close();
        reader = null;
    }

    public String getName() {
        return file.getName();
    }

    public String getPath() {
        return file.getPath();
    }

    public String getAbsolutePath() {
        return file.getAbsolutePath();
    }

    public boolean isOpen() {
        return reader != null;
    }

    /**
     * To be replaced by proper unit test class
     *
     * @throws IOException
     */
    public static void main(String[] sa) throws IOException {
        if (sa.length != 2)
            throw new IllegalArgumentException(
                    "SYNTAX: java " + FileRecordReader.class.getName()
                    + " file.txt RECORD_DELIM");
        FileRecordReader frr = new FileRecordReader(sa[0], sa[1], "UTF-8");
        int i = 0;
        String r;
        while ((r = frr.nextRecord()) != null)
            System.out.println("Rec #" + (++i) + ":  [" + r + ']');
    }

    /**
     * @return null if no more records in input file
     * @throws IOException
     */
    public String nextRecord() throws IOException {
        Matcher matcher;
        boolean reloaded = false;

        while (true) {
            matcher = recordPattern.matcher(stringBuffer);
            if (matcher.matches()) {
                String rec = matcher.group(1);
                stringBuffer.delete(0,  matcher.end(2));
                //System.err.println("    REM=(" + stringBuffer + ')');
                return rec;
            }
            if (reader == null) {
                if (stringBuffer.length() < 1) return null;
                String rec = stringBuffer.toString();
                stringBuffer.setLength(0);
                //System.err.println("    Rem=()");
                return rec;
            }
            reload(reloaded);
            //System.err.println("        Reloaded to {"  + stringBuffer + '}');
            reloaded = true;
        }
    }

    /**
     * @param increaseBuffer.  If true, grab 2 x as many bytes as previous read.
     * @throws IOException
     */
    private void reload(boolean increaseBuffer) throws IOException {
        if (reader == null)
            throw new IllegalStateException(
                    "Attempt to reload after source file has been closed");
        if (increaseBuffer) charBuffer = new char[charBuffer.length * 2];
        //if (increaseBuffer) System.err.println("-> " + charBuffer.length);
        int retVal = reader.read(charBuffer);
        // Indicate OED for 0, since we could get into loop by returning 0:
        if (retVal > 0)
            stringBuffer.append(charBuffer, 0, retVal);
        else
            close();
    }
}
