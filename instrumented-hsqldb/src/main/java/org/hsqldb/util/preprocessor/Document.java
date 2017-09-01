/* Copyright (c) 2001-2007, The HSQL Development Group
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


package org.hsqldb.util.preprocessor;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.Vector;

/* $Id: Document.java 610 2008-12-22 15:54:18Z unsaved $ */

/**
 * Simple line-oriented text document ADT.
 *
 * @author boucherb@users
 * @version 1.8.1
 * @since 1.8.1
 */
class Document {
    Vector lines = new Vector();

    Document() {}

    Document(Document source) {
        this.appendDocument(source);
    }

    Document addSouceLine(String line) {
        if (line == null) {
            throw new IllegalArgumentException("line: null");
        }

        this.lines.addElement(line);

        return this;
    }

    Document appendDocument(Document doc) {
        if (doc != null) {
            int    count = doc.size();
            Vector src   = doc.lines;
            Vector dst   = this.lines;

            for (int i = 0; i < count; i++) {
                dst.addElement(src.elementAt(i));
            }
        }

        return this;
    }

    Document clear() {
        this.lines.removeAllElements();

        return this;
    }

    boolean contains(String pattern) {
        Vector lines = this.lines;
        int    size  = lines.size();

        for (int i = 0; i < size; i++) {
            if (((String)lines.elementAt(i)).indexOf(pattern) >= 0) {
                return true;
            }
        }

        return false;
    }

    Document deleteSourceLine(int index) {
        this.lines.removeElementAt(index);

        return this;
    }

    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (o instanceof Document) {
            Document other = (Document) o;

            Vector v1 = this.lines;
            Vector v2 = other.lines;

            if (v1.size() != v2.size()) {
                return false;
            }

            for (int i = v1.size() - 1; i >= 0; i--) {
                if (v1.elementAt(i).equals(v2.elementAt(i))) {
                    continue;
                } else {
                    return false;
                }
            }

            return true;
        } else {
            return false;
        }
    }

    String getSourceLine(int index) {
        return (String) this.lines.elementAt(index);
    }

    Document insertSourceLine(int index, String line) {
        if (line == null) {
            throw new IllegalArgumentException("line: null");
        }

        this.lines.insertElementAt(line, index);

        return this;
    }

    Document replaceWith(Document source) {
        return this.clear().appendDocument(source);
    }

    Document setSourceLine(int index, String line) {
        if (line == null) {
            throw new IllegalArgumentException("null");
        }

        this.lines.setElementAt(line, index);

        return this;
    }

    int size() {
        return this.lines.size();
    }

// ------------------------ I/O convenience methods ----------------------------

    Document load(Object source, String encoding) throws IOException,
            UnsupportedEncodingException{
        BufferedReader reader = null;
        boolean        close  = false;

        if (source instanceof InputStream) {
            InputStream       is  = (InputStream) source;
            InputStreamReader isr = isEncoding(encoding)
                    ? new InputStreamReader(is, encoding)
                    : new InputStreamReader(is);

            reader = new BufferedReader(isr);
        } else if (source instanceof File) {
            InputStream       is  = new FileInputStream((File) source);
            InputStreamReader isr = isEncoding(encoding)
                    ? new InputStreamReader(is, encoding)
                    : new InputStreamReader(is);

            close  = true;
            reader = new BufferedReader(isr);
        } else if (source instanceof String) {
            InputStream       is  = new FileInputStream((String) source);
            InputStreamReader isr = isEncoding(encoding)
                    ? new InputStreamReader(is, encoding)
                    : new InputStreamReader(is);

            close  = true;
            reader = new BufferedReader(isr);
        } else if (source instanceof BufferedReader) {
            reader = (BufferedReader) source;
        } else if (source instanceof Reader) {
            reader = new BufferedReader((Reader) source);
        } else {
            throw new IOException("unhandled load source: " + source); // NOI18N
        }

        clear();

        String line;
        Vector lines = this.lines;

        try {
            while(null != (line = reader.readLine())) {
                lines.addElement(line);
            }
        } finally {
            if (close) {
                try {
                    reader.close();
                } catch (IOException ex) {}
            }
        }

        return this;
    }

    Document save(Object target, String encoding) throws IOException {
        BufferedWriter writer = null;
        boolean        close  = false;

        if (target instanceof OutputStream) {
            OutputStream       os  = (OutputStream) target;
            OutputStreamWriter osr = isEncoding(encoding)
                    ? new OutputStreamWriter(os, encoding)
                    : new OutputStreamWriter(os);

            writer = new BufferedWriter(osr);
        } else if (target instanceof File) {
            OutputStream       os  = new FileOutputStream((File) target);
            OutputStreamWriter osr = isEncoding(encoding)
                    ? new OutputStreamWriter(os, encoding)
                    : new OutputStreamWriter(os);

            close  = true;
            writer = new BufferedWriter(osr);
        } else if (target instanceof String) {
            OutputStream       os  = new FileOutputStream((String) target);
            OutputStreamWriter osr = isEncoding(encoding)
                    ? new OutputStreamWriter(os, encoding)
                    : new OutputStreamWriter(os);

            close  = true;
            writer = new BufferedWriter(osr);
        } else if (target instanceof BufferedWriter) {
            writer = (BufferedWriter) target;
        } else if (target instanceof Writer) {
            writer = new BufferedWriter(writer);
        } else {
            throw new IOException("unhandled save target: " + target); // NOI18N
        }

        Vector lines = this.lines;
        int    count = lines.size();

        try {
            for (int i = 0; i < count; i++) {
                writer.write((String)lines.elementAt(i));
                writer.newLine();
            }

            writer.flush();
        } finally {
            if (close) {
                try {
                    writer.close();
                } catch (IOException ex) {}
            }
        }

        return this;
    }

    static boolean isEncoding(String enc) {
        return enc != null && enc.trim().length() > 0;
    }
}
