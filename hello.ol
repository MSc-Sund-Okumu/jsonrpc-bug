from console import Console
from string_utils import StringUtils
type ResponseType: string {
    inner: string
}
interface IFace {
    RequestResponse:
        hello(void)(ResponseType),
        goodbye(void)(ResponseType)  
}
service Main {
    execution{ concurrent }
    inputPort IPort {
        location: "socket://localhost:12345"
        protocol: http
        interfaces: IFace
    }
    embed Console as Console
    embed StringUtils as SU
    main {
        [
            hello()(response) {
                response = "👏🏽"
                length@SU(response)(len)
                println@Console("length of: " + response + " is: " + len)()
                response.inner = "world"
            }
        ]
    }
}