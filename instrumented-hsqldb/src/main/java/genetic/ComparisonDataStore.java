package genetic;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ComparisonDataStore implements Iterable<ComparisonDataStore> {

	private ComparisonDataStore nextLevelStore;
	private ComparisonDataStore prevLevelStore;
	private List<ComparisonDataStore> subLevelData;
	private List<ComparisonRow> rows;
	private int queryLevel;
	
	public ComparisonDataStore(int pQueryLevel, ComparisonDataStore prevLevelStore) {
		queryLevel = pQueryLevel;
		rows = new ArrayList<ComparisonRow>();
		subLevelData = new ArrayList<ComparisonDataStore>();
		this.prevLevelStore = prevLevelStore;
	}
	
	public ComparisonDataStore getNextLevel() {
		if (nextLevelStore == null)
			nextLevelStore = new ComparisonDataStore(queryLevel + 1, this);
		
		return nextLevelStore;
	}
	
	public boolean hasComparisons() {
		if (rows.size() > 0)
			return true;
		
		for (ComparisonDataStore subStore : subLevelData) {
			if (subStore.hasComparisons()) 
				return true;
		}
		
		return false;
	}
	
	public boolean hasNextLevel() {
		return nextLevelStore != null;
	}
	
	public int getQueryLevel() {
		return queryLevel;
	}
	
	public List<ComparisonRow> getRows() {
		return rows;
	}
	
	public ComparisonDataStore getSubStore(int subIndex) {
		while (subIndex > subLevelData.size() - 1) {
			subLevelData.add(new ComparisonDataStore(0, null));
		}
		return subLevelData.get(subIndex);
	}
	
	public List<ComparisonDataStore> getSubStores() {
		return subLevelData;
	}
	
	public ComparisonDataStore getPrevLevel() {
		return prevLevelStore;
	}

	public void add(ComparisonRow currentRow) {
		rows.add(currentRow);
	}
	
	// Iterator 
    @Override
    public Iterator<ComparisonDataStore> iterator() {
        return new StoreIterator(this);
    }
    
    private static final class StoreIterator implements Iterator<ComparisonDataStore> {
    	private ComparisonDataStore currentStore;
    	private boolean first;

    	public StoreIterator(ComparisonDataStore startStore) {
    		currentStore = startStore;
    		first = true;
    	}
    	
        @Override
        public boolean hasNext() {
        	if (first) return true;
        	
            return currentStore.hasNextLevel();
        }

        @Override
        public ComparisonDataStore next() {
        	if (first) {
        		first = false;
        		return currentStore;
        	}
        	currentStore = currentStore.getNextLevel();
            return currentStore;
        }

        @Override
        public void remove() {
            throw new UnsupportedOperationException();
        }
    }
}
