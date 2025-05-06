from console import Console
service A {
    embed Console as Console
    
    main{
        println@Console("hello world")()
    }
}