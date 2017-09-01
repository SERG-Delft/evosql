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


package org.hsqldb.persist;

import org.hsqldb.HsqlException;
import org.hsqldb.Table;
import org.hsqldb.lib.HashMap;
import org.hsqldb.lib.Iterator;

/*
 * Manages the TEXT TABLE caches in the database. A separate class from
 * version 2.3.3
 *
 * @author Bob Preston (sqlbob@users dot sourceforge.net)
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.7.0
 */
public class TextTableStorageManager {

    //
    private HashMap textCacheList = new HashMap();

    TextTableStorageManager() {}

    /**
     *  Opens the TextCache object.
     */
    public DataFileCache openTextFilePersistence(Table table, String source,
            boolean readOnlyData, boolean reversed) {

        closeTextCache(table);

        TextCache c = new TextCache(table, source);

        c.open(readOnlyData || reversed);
        textCacheList.put(table.getName(), c);

        return c;
    }

    /**
     *  Closes the TextCache object.
     */
    public void closeTextCache(Table table) {

        TextCache c = (TextCache) textCacheList.remove(table.getName());

        if (c != null) {
            try {
                c.close();
            } catch (HsqlException e) {}
        }
    }

    public void closeAllTextCaches(boolean delete) {

        Iterator it = textCacheList.values().iterator();

        while (it.hasNext()) {
            TextCache textCache = ((TextCache) it.next());

            // use textCache.table to cover both cache and table readonly
            if (delete && !textCache.table.isDataReadOnly()) {
                textCache.purge();
            } else {
                textCache.close();
            }
        }
    }

    public boolean isAnyTextCacheModified() {

        Iterator it = textCacheList.values().iterator();

        while (it.hasNext()) {
            if (((TextCache) it.next()).isModified()) {
                return true;
            }
        }

        return false;
    }
}
