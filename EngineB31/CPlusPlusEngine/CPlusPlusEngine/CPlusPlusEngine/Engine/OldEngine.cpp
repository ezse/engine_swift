//
//  OldEngine.cpp
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 23.05.2024.
//

#include "OldEngine.hpp"
#include <iostream>

OldEngine::OldEngine(int initialSize) {
    itsSize = initialSize;
}

OldEngine::~OldEngine() {
    itsSize = 0;
}

std::string OldEngine::wrooom() const {
    cout << "wrooom from C++ engine \n";
    uint64_t tid;
    pthread_threadid_np(NULL, &tid);
    printf("%#08x\n", (unsigned int) tid);

    return "wrooom from C++ engine";
}

void OldEngine::setSize(int size) {
    
    itsSize = size;
}

int OldEngine::getSize() const {
    return itsSize;
}

