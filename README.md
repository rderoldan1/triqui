triqui_distribuido
==================

Triqui distribuido, RMI con distributed ruby

##Para correr el primer ejemplo

Abre dos terminales, en una corre el servidor

    ruby simple_server.rb druby://localhost:4000


En la otra terminal corre el cliente

    ruby simple_client.rb druby://localhost:4000

En el servidor debe ver que imprime "Hello, World"