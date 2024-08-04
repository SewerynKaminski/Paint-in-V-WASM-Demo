fn JS.canvas_x ( ) int
fn JS.canvas_y ( ) int
fn JS.setpixel ( x int, y int, c u8 )
fn JS.settitle ( t &string )
fn JS.test     ( r &Rect )
fn JS.teststr  ( s &string )
fn JS.init     ( app &App )
fn JS.line     ( x0 u32, y0 u32, x1 u32, y1 u32, c u32)

struct App {
  mut: mousedown bool
       ox u32
       oy u32
       color u32
}

struct Rect{
 x i32
 y i32
 w i32
 h i32
}

fn (this &App) draw () {}

pub fn (mut app App)mousedown ( x u32,y u32 ) {
	app.mousedown=true
	app.ox=x
	app.oy=y
}

pub fn (mut app App)mouseup ( x u32, y u32 ) {
	app.mousedown=false
}


pub fn (mut app App)mousemove ( x u32, y u32 ) {
	if app.mousedown {
		JS.line ( app.ox, app.oy, x, y, app.color )
		app.ox = x
    app.oy = y
	}
}

pub fn (mut app App)keydown ( key &u8, code &u8 ) {
    unsafe {
        if key[0]==`1` {
            app.color = 0xff0000
        } else if key[0]==`2` {
            app.color = 0x00ff00
        } else if key[0]==`S` &&
                  key[1]==`h` &&
                  key[2]==`i` &&
                  key[3]==`f` &&
                  key[4]==`t` && key[5]==0 {          
            println("V: Shift down")
        } else if key[0]==`B` &&
                  key[1]==`a` &&
                  key[2]==`c` &&
                  key[3]==`k` &&
                  key[4]==`s` &&
                  key[5]==`p` &&
                  key[6]==`a` &&
                  key[7]==`c` &&
                  key[8]==`e` && key[9]==0 {
            JS.test( Rect{x:0,y:0,w:512,h:512} )
        }
    }
}

pub fn (mut app App)keyup(key &u8, code &u8) {
    unsafe{
    if key[0]==`S` &&
       key[1]==`h` &&
       key[2]==`i` &&
       key[3]==`f` &&
       key[4]==`t` && key[5]==0 { 
        println("V: Shift up")}
    }
}

// `main` must be public!
pub fn main ( ) {
    mut app:=App{}

    title := "V WASM Paint demo"
    JS.settitle ( title )
    JS.init ( app )

    app.draw ( )
}
