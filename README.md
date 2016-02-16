## http_to_mqtt

Server which convert HTTP request to MQTT request written in Erlang.


## Prerequisites
    
You should have Git, Erlang 17.x and Vernemq installed in your PC to use this Plugin.
    
For Erlang 17.x you can download it from [here](https://www.erlang.org/downloads).
    
For Vernemq you can install from source file. [Here](https://github.com/erlio/vernemq) is the link to the source.

For Installing Git you can look [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).
    
    
## Installation
    
    To install the plugin.

1) Clone the Directory using command
            
    $ git clone https://github.com/sunnyjain1/http_to_mqtt.git
    
2) Go in the clone directory using command
    
    $ cd mqtt_to_http
    
3) Compile the plugin using command
    
    $ ./rebar compile

4) Start the server using command
    
    $ vernemq start
    
5) Enable the plugin using command
    
    $ vmq-admin plugin enable -n http_to_mqtt -p <Path to the Cloned Dir>
    
6) You can check the plugin starts working by using the command
    
    $ vmq-admin plugin show
