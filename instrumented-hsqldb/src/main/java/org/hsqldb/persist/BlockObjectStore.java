/* Copyright (c) 2001-2015, The HSQL Development Group
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

import java.lang.reflect.Constructor;

import org.hsqldb.Session;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.rowio.RowInputInterface;

/**
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 2.3.0
 */
public class BlockObjectStore extends SimpleStore {

    Class       objectClass;
    Constructor constructor;
    int         storageSize;
    int         blockSize;

    public BlockObjectStore(DataFileCache cache,
                            TableSpaceManager tableSpaceManager,
                            Class objectClass, int storageSize,
                            int blockSize) {

        this.cache        = cache;
        this.spaceManager = tableSpaceManager;
        this.objectClass  = objectClass;
        this.blockSize    = blockSize;
        this.storageSize  = storageSize;

        try {
            this.constructor = objectClass.getConstructor(int.class);
        } catch (Exception e) {
            throw Error.runtimeError(ErrorCode.U_S0500, "BlockObjectStore");
        }
    }

    public CachedObject get(long i) {
        return cache.get(i, storageSize, this, false);
    }

    public CachedObject get(CachedObject object, boolean keep) {
        return cache.get(object, this, keep);
    }

    public CachedObject get(long i, boolean keep) {
        return cache.get(i, storageSize, this, keep);
    }

    public void add(Session session, CachedObject object, boolean tx) {
        throw Error.runtimeError(ErrorCode.U_S0500, "BlockObjectStore");
    }

    public void add(CachedObject object, boolean keep) {

        int size = object.getRealSize(cache.rowOut);

        size = cache.rowOut.getStorageSize(size);

        if (size > storageSize) {
            throw Error.runtimeError(ErrorCode.U_S0500, "BlockObjectStore");
        }

        object.setStorageSize(storageSize);

        long pos = spaceManager.getFilePosition(size, true);

        object.setPos(pos);
        cache.add(object, keep);
    }

    public CachedObject get(RowInputInterface in) {

        CachedObject object = getNewInstance();

        object.read(in);

        int size = object.getRealSize(cache.rowOut);

        size = cache.rowOut.getStorageSize(size);

        if (size > storageSize) {
            throw Error.runtimeError(ErrorCode.U_S0500, "BlockObjectStore");
        }

        object.setStorageSize(storageSize);

        return object;
    }

    public CachedObject getNewInstance(int size) {
        throw Error.runtimeError(ErrorCode.U_S0500, "BlockObjectStore");
    }

    private CachedObject getNewInstance() {

        try {
            CachedObject object =
                (CachedObject) constructor.newInstance(new Object[]{
                    Integer.valueOf(blockSize) });

            return object;
        } catch (Exception e) {
            return null;
        }
    }
}
