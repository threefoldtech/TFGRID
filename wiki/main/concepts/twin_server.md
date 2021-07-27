# Twin Server

```mermaid
graph TD

    subgraph PCUSER[Env User]
    twin[[Twin Server<br>Node JS]] --- webinterface[rest webinterface]
    rmb --- cmdline[cmdline + json data]
    rmb --- vlang[vlang module]
    twin --- rmb[[Reliable Message Bus]]  
    rmb --- redis[[Redis]]
    end

    twin --- explorer((TFCHAIN))
    twin --- stellar((STELLAR))
    rmb --- 3Node
```

- twin_server is implemented in nodejs

> TODO: use gitpod to run env as specified here, all need to run inside, easy to develop

## More Info

- [twin_server_tech](twin_server_tech)
  

!!!def alias:twin_server,digital_twin_server,digital_self_server,self_server