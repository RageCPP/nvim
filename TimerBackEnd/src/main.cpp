#include <iostream>
#include "boost/asio/io_context.hpp"
#include "net.hpp"

int main(int argc, char* argv[]) {
    if(argc != 4) {
        std::cerr <<
            "Usage: websocket-chat-multi <address> <port> <doc_root> <threads>\n" <<
            "Example:\n" <<
            "    websocket-chat-server 0.0.0.0 8080 4\n";

        return EXIT_FAILURE;
    }

    auto address = net::ip::make_address(argv[1]);
    auto port = static_cast<unsigned short>(std::atoi(argv[2]));
    auto const threads = std::max<int>(1, std::atoi(argv[3]));
    net::io_context iocontext;
   
    return 0;
}
