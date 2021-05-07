/**
 * @description       : example test class
 * @author            : drewtsnyder@gmail.com
 * @group             : 
 * @last modified on  : 05-07-2021
 * @last modified by  : drewtsnyder@gmail.com
 * Modifications Log 
 * Ver   Date         Author                  Modification
 * 1.0   05-07-2021   drewtsnyder@gmail.com   Initial Version
**/
@IsTest
private class MyExampleClassTest {
    
    @IsTest
    static void testPublicString(){
        System.assert('MyExampleClass Test'.equals(MyExampleClass.forTesting), 'Incorrect String Value Returned');
    }
}
