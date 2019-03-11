package nl.tudelft.serg.evosql.experiment;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class CacheReader {

    public static List<QueryPathList> loadCacheErpNext() {
        //
        List<QueryPathList> cachedPaths = new ArrayList<>();
        Gson gson = new Gson();
        BufferedReader reader_erpnext = new BufferedReader(new InputStreamReader(
                Runner.class.getClassLoader().getResourceAsStream("paths/erpnext.json")));
        cachedPaths.addAll(gson.fromJson(reader_erpnext, new TypeToken<ArrayList<QueryPathList>>(){}.getType()));
        return cachedPaths;
    }

    public static List<QueryPathList> loadCacheEspoCrm() {
        //
        List<QueryPathList> cachedPaths = new ArrayList<>();
        Gson gson = new Gson();
        BufferedReader reader_erpnext = new BufferedReader(new InputStreamReader(
                Runner.class.getClassLoader().getResourceAsStream("paths/espocrm.json")));
        cachedPaths.addAll(gson.fromJson(reader_erpnext, new TypeToken<ArrayList<QueryPathList>>(){}.getType()));
        return cachedPaths;
    }

    public static List<QueryPathList> loadCacheSuiteCrm() {
        //
        List<QueryPathList> cachedPaths = new ArrayList<>();
        Gson gson = new Gson();
        BufferedReader reader_erpnext = new BufferedReader(new InputStreamReader(
                Runner.class.getClassLoader().getResourceAsStream("paths/suitecrm.json")));
        cachedPaths.addAll(gson.fromJson(reader_erpnext, new TypeToken<ArrayList<QueryPathList>>(){}.getType()));
        return cachedPaths;
    }
}
