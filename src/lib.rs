#![no_std]
#![feature(lang_items, core_intrinsics)]

use core::intrinsics;
use core::panic::PanicInfo;

#[panic_handler]
#[no_mangle]
pub fn panic(_info: &PanicInfo) -> ! {
    unsafe { intrinsics::abort() }
}

#[lang = "eh_personality"]
#[no_mangle]
pub extern "C" fn rust_eh_personality() {}

#[no_mangle]
pub unsafe extern "C" fn example_add(a: u32, b: u32) -> u32 {
    a + b
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn it_works() {
        assert_eq!(3, example_add(1,2));
    }
}