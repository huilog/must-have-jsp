package common;		// 기본 패키지 이외의 패키지(자바빈즈 규약 1번)

public class Person {
	private String name;	//private 멤버 변수(자바빈즈 규약 2번)
	private int age;		//private 멤버 변수(자바빈즈 규약 2번)
	
	public Person() {} 		//기본 생성자(자바빈즈 규약 3번)
	
	
	public Person(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}

	//멤버 변수에 접근할 수 있는 getter, setter method 선언(자바빈즈 규약 4번)
	//getter, setter method의 접근 제어자는 public으로 선언(자바빈즈 규약 5번)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
}
