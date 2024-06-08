
interface Messenger{
    fun send(message: String)
}
class InstantMessenger(val programName: String) : Messenger{

    override fun send(message: String){
        println("Message `$message` has been sent")
    }
}
class SmartPhone(val name: String, m: Messenger): Messenger by  m

open class MyClass {
    fun myFunction() {
        println("Hello, I'm a function in MyClass") }}

fun main() {
    //Делегаты
    val telegram = InstantMessenger("Telegram")
    val pixel = SmartPhone("Pixel 5", telegram)
    pixel.send("Hello Kotlin")
    pixel.send("Learn Kotlin on Metanit.com")

    //Регулярные выражения
    val input = "The quick brown fox jumps over the lazy dog"
    val regex = Regex("""\b\w{5}\b""")
    val results = regex.findAll(input)
    println("Matches:")
    results.forEach { println(it.value) }

    //Совместное объявление экземпляра и класса
    val myObject = object : MyClass() {
        fun additionalFunction() {
            println("I'm an additional function in myObject")
            myFunction()
        }
    }
    println(myObject.additionalFunction())

}

