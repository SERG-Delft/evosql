package nl.tudelft.serg.evosql.experiment;

import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class QueryPathList {
    public final int queryNo;
    public final List<String> pathList;
}