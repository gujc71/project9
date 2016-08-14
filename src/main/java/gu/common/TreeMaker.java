package gu.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.map.ObjectMapper;

public class TreeMaker {
	public String makeTreeByHierarchy(List<?> listview){
		List<TreeVO> rootlist= new ArrayList<TreeVO>();
		
		for (Integer i=0; i<listview.size(); i++) {			
			TreeVO mtDO = (TreeVO)listview.get(i);			
			
			if (mtDO.getParent()==null) {
				rootlist.add(mtDO);
				continue;
			}	
			 for (Integer j=0; j<listview.size(); j++) {
				 TreeVO ptDO = (TreeVO) listview.get(j);
				 if (mtDO.getParent().equals(ptDO.getKey())) {
					 if (ptDO.getChildren()==null) ptDO.setChildren(new ArrayList<Object>() );
					 List<TreeVO> a = ptDO.getChildren();
					 a.add(mtDO);
					 ptDO.setIsFolder(true);
					 break;
				 }
			 }	 
		 }

		ObjectMapper mapper = new ObjectMapper();
		String str="";
		try {
			str = mapper.writeValueAsString(rootlist);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return str;
	}
}
