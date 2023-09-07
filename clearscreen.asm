
#import "../System/System_Macros.s"
#import "../System/memorymap.asm"


//.const SCREEN = $0800    //screen is at mem location $0400

System_BasicUpstart65(main) // autostart macro

*=$2015

main:

    //jsr $ff81
    jsr cls
    //jmp *     //to keep jumping to current address, i.e. loop forever
    rts       //to return to basic

cls:
    lda #32   //load A with whatever want to fill the screen with 
              // for clearing the screen you should use #32 which is "space"
    ldx #0    //load index register with immediate 0

cls_loop:
                //screen size is 40x25 or 1000 chars
    sta VIC.SCREEN, X  //store whatever is in acc to screen location plus index offset    
    sta VIC.SCREEN + $0100, X //cover the next quarter
    sta VIC.SCREEN + $0200, X // cover the 3rd quarter
    //sta SCREEN + $0300, X // this would actually go past the screen by 24 bytes
    sta VIC.SCREEN + $02E8, X // this starts at $0300 - 24 bytes 
    dex             //decrement our x counter *more efficient than adding and cmp
    bne cls_loop    // branch  if x is not zero (falls through after 255 cycles)
    rts             //return to the calling routine

