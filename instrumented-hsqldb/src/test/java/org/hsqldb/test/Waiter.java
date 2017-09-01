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


package org.hsqldb.test;

import java.util.Map;
import java.util.HashMap;

/**
 * Single-use synchronization object.
 *
 * Design would be more scalable if there were a separate collection class,
 * instead of the static Waiter.map.  The limitation is acceptable since
 * there's no use case for running multiple Test Runners simultaneously
 * from a single JVM (one Test runner can handle multiple test scripts
 * simultaneously or synchronously).
 *
 * (It would be much work to make the collection non-static, because that
 * would require a refactor of TestUtil with proper OOD).
 */
public class Waiter {
    /*
    static private HashMap<String, Waiter> map =
            new HashMap<String, Waiter>();
    Java 5 */
    static private Map map = new HashMap();
    private String key;
    private boolean notified = false; // resume() method has been called
    private boolean waiting = false;  // a client is waiting (in waitFor()).
    private boolean abort = false;  // Make fail if partner failed

    public boolean isNotified() { return notified; }
    public boolean isWaiting() { return waiting; }

    private Waiter(String key) {
        this.key = key;
        map.put(key, this);
    }

    /**
     * @param enforceSequence  Fail if waitFor() called before resume()
     */
    public synchronized void waitFor(boolean enforceSequence) {
        if (abort)
            throw new RuntimeException("Notifier side failed previously");
        if (notified) {
            if (enforceSequence)
                throw new RuntimeException(
                        "Request to wait on '" + key
                        + "', but this object has already been notified");
            return;
        }
        waiting = true;
        try {
            wait();
        } catch (InterruptedException ie) {
            throw new RuntimeException(
                    "Unexpected interrupted while waiting for '"
                    + key + "'", ie);
        } finally {
            waiting = false;
        }
        map.remove(this);
        if (!notified)
            throw new RuntimeException(
                    "Exiting waitFor() on '" + key
                    + "' even though not 'notified'");
    }

    /**
     * @param enforceSequence  Fail if waitFor() called before resume()
     */
    public synchronized void resume(boolean enforceSequence) {
        if (enforceSequence && !waiting) {
            abort = true;
            throw new RuntimeException("Requested to resume on '"
                    + key + " ', but nothing is waiting for it");
        }
        notified = true;
        notify();
    }

    /**
     * It doesn't matter if the waiter or the waitee runs getWaiter()
     * first.  Whoever requests it first will instantiate it.
     *
     * @return A Waiter instance.  Never returns nul.
     */
    public synchronized static Waiter getWaiter(String key) {
        Waiter waiter = (Waiter) map.get(key);
        if (waiter == null) waiter = new Waiter(key);
        return waiter;
    }
}
