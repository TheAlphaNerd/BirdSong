//
//  FlockPool.cpp
//  BirdSong
//
//  Created by thealphanerd on 2/17/14.
//  Copyright (c) 2014 Myles Borins. All rights reserved.
//

#include "FlockPool.h"

FlockPool::FlockPool(int count)
{
    for (int i = 0; i < count; i++)
    {
        Flock * fe = new Flock();
        fe->init(10);
        fe->active = false;
        // reset transparency
        fe->alpha = 1.0;
        // set location
        fe->loc.setAll(0);
        // set color
        fe->col.setAll(1);
        // assign touch
        fe->_touch = nullptr;
        addChild(fe);
    }
};

//FlockPool::~FlockPool()
//{
//    for (std::vector<YEntity *>::iterator it = children.begin(); it != children.end(); it++)
//    {
//        FlockEntity * fe = (FlockEntity *)(*it);
//        delete te;
//    }
//};
//
void FlockPool::addFlock(UITouch * touch, GLfloat x, GLfloat y)
{
    std::vector<YEntity *>::iterator it = children.begin();
    Flock * fe = (Flock *)(*it);
    while (fe->active)
    {
        it++;
        fe = (Flock *)(*it);
        if (it == children.end()) {
            return;
        }
    }
    fe->active = true;
    fe->_touch = touch;
    fe->_centerMass.set(x, y, 0);
};

void FlockPool::updateFlock(UITouch * touch, GLfloat x, GLfloat y)
{
    std::vector<YEntity *>::iterator it = children.begin();
    Flock * fe = (Flock *)(*it);
    while (fe->_touch != touch)
    {
        it++;
        fe = (Flock *)(*it);
        if (it == children.end()) {
            return;
        }
    }
    fe->_centerMass.set(x, y, 0);
};

void FlockPool::removeFlock(UITouch * touch)
{
    std::vector<YEntity *>::iterator it = children.begin();
    Flock * fe = (Flock *)(*it);
    while (fe->_touch != touch)
    {
        it++;
        fe = (Flock *)(*it);
        if (it == children.end()) {
            return;
        }
    }
    fe->loc.setAll(0);
    fe->active = false;
    fe->_touch = nullptr;
};
