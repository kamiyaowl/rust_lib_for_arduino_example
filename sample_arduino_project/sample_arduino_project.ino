#include "rust_lib_for_arduino_example.h"

void setup() {
    Serial.begin(9600);
    while (!Serial) {}
}

void loop() {
    // test
    const uint32_t dst = example_add(1,2);
    Serial.print("Hello Rust. 1+2=");
    Serial.print;n(dst);

    delay(1000);
}