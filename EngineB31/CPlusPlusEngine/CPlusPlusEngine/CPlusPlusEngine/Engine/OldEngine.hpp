//
//  OldEngine.hpp
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 23.05.2024.
//

#ifndef OldEngine_hpp
#define OldEngine_hpp

#include <stdio.h>
#include <string>

using namespace std;

class OldEngine {
  
public:

    // Constructor + destructor
    OldEngine(int initialSize);
    ~OldEngine();
    
    // Age
    int getSize() const;
    void setSize(int size);
   
    // Other stuff
    string wrooom() const;

private:
    int itsSize;
};

#endif /* OldEngine_hpp */
