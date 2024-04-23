
fun main() {
    val quine = """
        fun main() {
            val quine = \"\"\"${'$'}{""" + '"' + """}\"\"\"
            println(quine)
        }
    """
    println(quine)
}


