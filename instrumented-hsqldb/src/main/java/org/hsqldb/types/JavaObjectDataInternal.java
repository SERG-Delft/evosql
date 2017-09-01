/* Copyright (c) 2001-2016, The HSQL Development Group
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


package org.hsqldb.types;

import java.io.Serializable;

import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.InOutUtil;

/**
 * Represents of an instance of an OTHER field value for direct storage.<p>
 *
 * Objects need not implement Serializable to be stored in the mem: database.
 * They are stored as-is and reflect any changes to the stored Objects by the
 * application program.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.9.0
 */
public class JavaObjectDataInternal extends JavaObjectData {

    Object object;

    /**
     * Constructor used inside the engine when an already serialized
     * Object is read from a file.
     *
     * If the Object is not serializable, this method throws an exception.
     */
    public JavaObjectDataInternal(byte[] data) {

        try {
            object = InOutUtil.deserialize(data);
        } catch (Exception e) {
            throw Error.error(ErrorCode.X_22521, e.toString());
        }
    }

    /**
     * Constructor used inside the engine.
     */
    public JavaObjectDataInternal(Object o) {
        object = o;
    }

    public byte[] getBytes() {

        try {
            if (object instanceof Serializable) {
                return InOutUtil.serialize((Serializable) object);
            }
        } catch (Exception e) {}

        return new byte[]{};
    }

    public int getBytesLength() {

        try {
            if (object instanceof Serializable) {
                byte[] data = InOutUtil.serialize((Serializable) object);

                return data.length;
            }
        } catch (Exception e) {}

        return 0;
    }

    /**
     * This method is called from classes implementing the JDBC
     * interfaces. Inside the engine it is used for conversion from a value of
     * type OTHER to another type. It will throw if the OTHER is an instance
     * of a class that is not available.
     */
    public Object getObject() {
        return object;
    }

    /**
     * Returns String representation of this object.
     *
     * @return a String representation of this object.
     */
    public String toString() {
        return super.toString();
    }
}
