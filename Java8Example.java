package cc.cho;

import java.util.ArrayList;
import java.util.List;

import cc.cho.vo.NumberVO;

public class Java8Example {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// Greeter g = new ConcurrentGreeting();
		// g.greet();
		
//		String[] strings = {"VCd","fGu","alK","ABc"};
//		System.out.println(String.join(", ", strings));
//	
//		Arrays.sort(strings, String::compareToIgnoreCase);
//		System.out.println(String.join(", ", strings));
//
//		String testStr = "SUB_tbl4-tbody1-ITEM_NM12_FROM_CHILD";
//		System.out.println(testStr.substring(testStr.indexOf("_", 4) + 3, testStr.indexOf("_", 21)));
//		System.out.println(testStr.substring(testStr.indexOf("_", 21)));
//		testStr = testStr.replace("SUB_tbl4-tbody1-ITEM_NM", "").replace("_FROM_CHILD", "");
//		System.out.println("testStr : " + testStr);
		
		List<NumberVO> numbers = new ArrayList<>();
		for (int i = 0; i < 5; i++) {
			NumberVO vo = new NumberVO();
			vo.setSeq(i + 1);
			vo.setId("id" + (i + 1));
			if (i == 2) {
				vo.setMidName("midName" + (i + 1));
			}
			numbers.add(vo);
		}
		
		List<NumberVO> updateNumbers = new ArrayList<>();
		updateNumbers.add(numbers.get(0));
		updateNumbers.add(numbers.get(1));
		updateNumbers.add(numbers.get(3));
		updateNumbers.add(numbers.get(4));
		
		List<NumberVO> deleteNumbers = getDeleteList(numbers, updateNumbers);

		StringBuilder sb = insertCommaInDeleteList(deleteNumbers);
		
		System.out.println("deleteNumbers : " + sb.toString());
	}

	private static StringBuilder insertCommaInDeleteList(List<NumberVO> deleteNumbers) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < deleteNumbers.size(); i++) {
			if (deleteNumbers.get(i).getMidName() != null && !deleteNumbers.get(i).getMidName().isEmpty()) {
				System.out.println("중간 이름 삭제 : " + deleteNumbers.get(i).toString());
			}
			if (i != deleteNumbers.size() - 1) {
				sb.append(deleteNumbers.get(i).getSeq() + ", ");
			} else {
				sb.append(deleteNumbers.get(i).getSeq());
			}
		}
		return sb;
	}

	private static List<NumberVO> getDeleteList(List<NumberVO> numbers, List<NumberVO> updateNumbers) {
		List<NumberVO> deleteNumbers = numbers; 

		for (int i = 0; i < deleteNumbers.size(); i++) {
			for (int j = 0; j < updateNumbers.size(); j++) {
				if (deleteNumbers.get(i).getSeq() == updateNumbers.get(j).getSeq()) {
					deleteNumbers.remove(i);
				}
			}
		}
		return deleteNumbers;
	}

}

class Greeter {
	public void  greet() {
		System.out.println("Hello, world!");
	}
}

class ConcurrentGreeting extends Greeter {
	public void greet() {
		Thread t = new Thread(super::greet);
		t.start();
	}
}
