from console import Console
from string-utils import StringUtils

interface Iter {
    RequestResponse:
        executeCommand(undefined)(undefined)
}

service Test {
    embed Console as Console
    embed StringUtils as StringUtils
    
    outputPort Out {
        location: "socket://localhost:9743"
        protocol: "jsonrpc" {
			transport = "lsp"
			debug = Debug
			debug.showContent = Debug
			osc.executeCommand.alias = "workspace/executeCommand"
		}
        interfaces: Iter
    }
    main {
        
        req << {
            command = "/refactor/addInterface"
            arguments[0] << {
                label = "uwu"
                module = "file:///home/kasper/msc/fromPC/src/hello/hello.ol"
                
                interfaceName = "testInterface"
            }
        }
        
        executeCommand@Out(req)(response)
        valueToPrettyString@StringUtils(response)(pretty)
        println@Console(pretty)()
    }
}