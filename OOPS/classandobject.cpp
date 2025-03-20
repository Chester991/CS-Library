#include<bits/stdc++.h>
using namespace std;

class Car{
    public:
    string brand;
    int speed;

    void drive(){
        cout<<"Brand of car is " << brand << " and its speed is " <<speed<<endl; 
    }
};

int main(){
    Car hiteshcar;
    hiteshcar.brand = "BMW";
    hiteshcar.speed = 90;

    Car ayushcar;
    ayushcar.brand = "Auto";
    ayushcar.speed = 20;

    hiteshcar.drive();
    ayushcar.drive();
}