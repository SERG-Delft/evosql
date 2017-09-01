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


package org.hsqldb.test;

import java.sql.Connection;

public class TestScript extends TestBase {

//    String path = "TestSelf00NewJoins.txt";
//    String path = "TestSelf01AllNewFeatures.txt";
//    String path = "TestSelf01Aggregates.txt";
//    String path = "TestSelf01Cascade.txt";
//    String path = "TestSelf01DateTime.txt";
//    String path = "TestSelf02DateTime.txt";
//    String path = "TestSelf01Etc.txt";
//    String path = "TestSelf01hsqldb_schema.txt";
//    String path = "TestSelf01ForeignKeys.txt";
//    String path = "TestSelf01Function.txt";
//    String path = "TestSelf01Indexes.txt";
//    String path = "TestSelf01IndexUse.txt";
//    String path = "TestSelf01LimitOpt.txt";
//    String path = "TestSelf01Procedure.txt";
//    String path = "TestSelf01Problems.txt";
//    String path = "TestSelf01RecursiveQueries.txt";
//    String path = "TestSelf01RoutineHandlers.txt";
//    String path = "TestSelf01Subquery.txt";
//    String path = "TestSelf01TempTables.txt";
//    String path = "TestSelf01Triggers.txt";
//    String path = "TestSelf01UDAggregates.txt";
//    String path = "TestSelf01WithSubquery.txt";
//    String path = "TestSelf02Function.txt";
//    String path = "TestSelf02UpdatableViews.txt";
//    String path = "TestSelf02Sequence.txt";
    String path = "TestSelf02Merge.txt";
//    String path = "TestSelf02UpdatableViews.txt";
//    String path = "TestSelf04UnionCorresponding.txt";
//    String path = "TestSelf07OrderLimitNulls.txt";
//    String path = "TestSelf06Generated.txt";
//    String path = "TestSelf08Collations.txt";
//    String path = "TestAny.txt";

//    String path = "TestSelf.txt";
//    String path = "TestSelfArrays.txt";
//    String path = "TestSelf3PartNames.txt";
//    String path = "TestSelfArithmetic.txt";
//    String path = "TestSelfAlterColumn.txt";
//    String path = "TestSelfCaseWhen.txt";
//    String path = "TestSelfCheckConstraints.txt";
//    String path = "TestSelfColGrant.txt";
//    String path = "TestSelfCreate.txt";
//    String path = "TestSelfConstraints.txt";
//    String path = "TestSelfFunction.txt";
//    String path = "TestSelfGrantees.txt";
//    String path = "TestSelfGroupBy.txt";
//    String path = "TestSelfInsertDeleteQueries.txt";
//    String path = "TestSelfInterval.txt";
//    String path = "TestSelfInternalFunctions.txt";
//    String path = "TestSelfFieldLimits.txt";
//    String path = "TestSelfFKModes.txt";
//    String path = "TestSelfInPredicateReferencing.txt";
//    String path = "TestSelfInsteadOfTriggers.txt";
//    String path = "TestSelfIssues.txt";
//    String path = "TestSelfJoins.txt";
//    String path = "TestSelfLeftJoin.txt";
//    String path = "TestSelfNameResolution.txt";
//    String path = "TestSelfImmediateShutdown.txt";
//    String path = "TestSelfInsertDeleteQueries.txt";
//    String path = "TestSelfInPredicateReferencing.txt";
//    String path = "TestSelfMultiGrants.txt";
//    String path = "TestSelfNot.txt";
//    String path = "TestSelfOrderLimits.txt";
//    String path = "TestSelfRoleNesting.txt";
//    String path = "TestSelfQueries.txt";
//    String path = "TestSelfSchemaPersistB1.txt";
//    String path = "TestSelfSeqRightsA.txt";
//    String path = "TestSelfStoredProcedure.txt";
//    String path = "TestSelfStoredProcedureTypes.txt";
//    String path = "TestSelfSubselects.txt";
//    String path = "TestSelfSysTables.txt";
//    String path = "TestSelfTempTable1.txt";
//    String path = "TestSelfTransaction.txt";
//    String path = "TestSelfTriggers.txt";
//    String path = "TestSelfTriggers2.txt";
//    String path = "TestSelfUnions.txt";
//    String path = "TestSelfUserFunction.txt";
//    String path = "TestSelfViews.txt";
//    String path = "TestSelfViewGrants.txt";
//    String path = "TestSelfSeqRightsA.txt";
//    String path = "TestSelfSysTables.txt";
//    String path = "TestTemp.txt";
    public TestScript(String name) {
        super(name, "jdbc:hsqldb:mem:test", false, false);
//        super(name, "jdbc:hsqldb:file:test1", false, false);
    }

    public void test() throws java.lang.Exception {

        TestUtil.deleteDatabase("test");

        Connection conn     = newConnection();
        String     fullPath = "testrun/hsqldb/" + path;

        TestUtil.testScript(conn, fullPath);
//        conn.createStatement().execute("SHUTDOWN");
    }

    public static void main(String[] Args) throws Exception {

        TestScript ts = new TestScript("test");

        ts.test();
    }
}
