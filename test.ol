from console import Console
from string_utils import StringUtils
from file import File
interface Iter {
    RequestResponse:
        executeCommand(undefined)(undefined)
}
service Test {
    embed Console as Console
    embed StringUtils as StringUtils
    embed File as File
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
        //get the full path for hello.ol
        getRealServiceDirectory@File()(path)
        println@Console("trying to add an interface to " + path)()
        
        req << {
            command = "/refactor/addInterface"
            arguments[0] << {
                label = "uwu"
                module = "file://" + path + "/hello.ol"
                interfaceName = "testInterface"
            }
        }
        
        executeCommand@Out(req)(response)
        valueToPrettyString@StringUtils(response)(pretty)
        println@Console(pretty)()
    }
}
