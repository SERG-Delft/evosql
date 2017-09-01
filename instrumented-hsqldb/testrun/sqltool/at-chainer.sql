/*
 * $Id: at-chainer.sql 3714 2010-07-22 02:28:38Z unsaved $
 *
 * This script invokes the script subdir/atuser.sql, in normal fashion, to
 * test that @ works when used by a sub-script.
 */

\i subdir/atuser.sql
