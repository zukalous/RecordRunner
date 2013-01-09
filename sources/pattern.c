//
//  pattern.c
//  RecordRunnerARC
//
//  Created by Hin Lam on 12/12/12.
//
//
#include "pattern.h"

char injectorPatternArray[][7][7] =
{
    {
        // kPatternDiamond
        { 0, 0, 0, 2, 0, 0, 0 },
        { 0, 0, 2, 2, 2, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 2, 2, 2, 1, 2, 2, 2 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 0, 0, 2, 2, 2, 0, 0 },
        { 0, 0, 0, 2, 0, 0, 0 }
    },
    
    {
        // kPatternSquare
        { 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 1, 2, 2, 0 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 0, 0, 0, 0, 0, 0, 0 }
    },
    
    {
        // kPatternRectangle,
        { 0, 0, 0, 0, 0, 0, 0 },
        { 2, 2, 2, 1, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2 },
        { 0, 0, 0, 0, 0, 0, 0 }
    },
    
    {
        // kPatternTriangle,
        { 0, 0, 0, 1, 0, 0, 0 },
        { 0, 0, 2, 2, 2, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 2, 2, 2, 2, 2, 2, 2 },
        { 0, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 0 }

    },
    
    {
        // kPatternCircle,
        { 0, 0, 2, 1, 2, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 0, 0, 2, 2, 2, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 0 }
    },
    
    {
        // kPatternHeart
        { 0, 0, 2, 0, 2, 0, 0 },
        { 0, 2, 2, 1, 2, 2, 0 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 0, 2, 2, 2, 2, 2, 0 },
        { 0, 0, 2, 2, 2, 0, 0 },
        { 0, 0, 0, 2, 0, 0, 0 },
        { 0, 0, 0, 2, 0, 0, 0 }
    }
};

int patternNumPattern(void)
{
    return (sizeof(injectorPatternArray)/(PATTERN_NUM_ROWS * PATTERN_NUM_COLS));
}