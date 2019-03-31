package cc.cho;

import java.util.Arrays;

public class Java8Example {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// Greeter g = new ConcurrentGreeting();
		// g.greet();
		
		String[] strings = {"VCd","fGu","alK","ABc"};
		System.out.println(String.join(", ", strings));
	
		Arrays.sort(strings, String::compareToIgnoreCase);
		System.out.println(String.join(", ", strings));

		String testStr = "SUB_tbl4-tbody1-ITEM_NM12_FROM_CHILD";
		System.out.println(testStr.substring(testStr.indexOf("_", 4) + 3, testStr.indexOf("_", 21)));
		System.out.println(testStr.substring(testStr.indexOf("_", 21)));
		testStr = testStr.replace("SUB_tbl4-tbody1-ITEM_NM", "").replace("_FROM_CHILD", "");
		System.out.println("testStr : " + testStr);
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