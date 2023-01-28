/**
 * @description       : example test class
 * @author            : drewtsnyder@gmail.com
 * @group             : Example Code
 * @last modified on  : 01-28-2023
 * @last modified by  : drew.snyder@hunterdouglas.com
 * Modifications Log
 * Ver   Date         Author                  Modification
 * 1.0   05-07-2021   drewtsnyder@gmail.com   Initial Version
 * 1.1   01-28-2023   drewtsnyder@gmail.com   prettier, header update
 **/
@IsTest
private class MyExampleClassTest {
  @IsTest
  static void testPublicString() {
    System.assert(
      'MyExampleClass Test'.equals(MyExampleClass.forTesting),
      'Incorrect String Value Returned'
    );
  }
}
