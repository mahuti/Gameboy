//
// Gameboy
// Theme by Mahuti
// vs. 2.0 // added pos module, flyers, and other minor things
//
local order = 0
class UserConfig {
	</ label="Show Logos", 
        help="Shows wheel images when enabled", 
        order=order++, 
        options="Yes, No" />
        show_logos="Yes";
 
    </ label="Show Flyers", 
        help="Shows flyers when enabled", 
        order=order++, 
        options="Yes, No" />
        show_flyers="Yes";
  
    </ label="Show Boxart", 
        help="Shows boxart when enabled", 
        order=order++, 
        options="Yes, No" />
        show_boxart="Yes";
    
 	</ label="Show Playtime", 
        help="The amount of time this game's been played.", 
        order=order++, 
        options="Yes, No, Include Romname" />
        show_playtime="Yes";
    
    </ label="Show Scanlines", 
        help="Shows scanlines when enabled", 
        order=order++, 
        options="Yes, No" />
        show_scanlines="No"; 
    
    </ label="Scratched Text", 
        help="This is some text scratched in the desk, which may not always be visible. Set it to blank to hide it", 
        order=order++
        />
        desk_text="Gameboy Rulz!";
}

 
local config = fe.get_config()

fe.load_module("preserve-art")
fe.load_module("pos") // positioning & scaling module
fe.load_module("shadow-glow")

// stretched positioning
local posData =  {
    base_width = 1920.0,
    base_height = 1080.0,
    layout_width = fe.layout.width,
    layout_height = fe.layout.height,
    scale= "stretch",
    rotate= 0
    debug = false,
}
local pos = Pos(posData)

// scaled positioning
posData =  {
    base_width = 1920.0,
    base_height = 1080.0,
    layout_width = fe.layout.width,
    layout_height = fe.layout.height,
    scale= "scale",
    rotate=0
    debug = false,
}
local scalepos = Pos(posData)

    
//Wood Background
local bg = fe.add_image("gb_bg.png", 0, 0, pos.width(1920), pos.height(1080))

//local positioning = fe.add_image("template.png", 0, 0, scalepos.width(1920), scalepos.height(1080))
//positioning.preserve_aspect_ratio = true
    
local scratch_me = null
if (config["desk_text"] != ""){
    
    local scratch_y = -200
    local scratch_x = 100
    local scratch_width = 1100
    local scratch_height = 200
    local scratch_font_height=44 
    local scratch_rotation = 17
        
    scratch_me = fe.add_text(config["desk_text"], pos.x(scratch_x), pos.y(scratch_y), pos.width(scratch_width), pos.height(scratch_height) )
    pos.set_font_height(scratch_font_height,scratch_me, "TopLeft")

    scratch_me.x = scalepos.x(scratch_x, "right",scratch_me)
    scratch_me.y = scalepos.y(scratch_y, "bottom",scratch_me)
    scratch_me.alpha=140
    scratch_me.rotation=scratch_rotation
    scratch_me.set_rgb(150,112,72)
    scratch_me.font = "sugar-death-2-italic.ttf"
        
    local scratch_me2 = fe.add_text(config["desk_text"], pos.x(scratch_x), pos.y(scratch_y), pos.width(scratch_width), pos.height(scratch_height) )
    scratch_me2.y = scalepos.y( -2, "top", scratch_me2, scratch_me)
    scratch_me2.x = scalepos.x( -2, "left", scratch_me2, scratch_me)
    pos.set_font_height(scratch_font_height,scratch_me2, "TopLeft")
    scratch_me2.alpha=70    
    scratch_me2.rotation=scratch_rotation
    scratch_me2.set_rgb(88,23,41)
    scratch_me2.font = "sugar-death-2-italic.ttf"
    
   scratch_me2.zorder = scratch_me.zorder
}

local flyer = null
if ( config["show_flyers"] == "Yes" )
{
    // flyer
    flyer = fe.add_artwork("flyer", scalepos.x(-300), scalepos.y(-100), scalepos.width(1100), scalepos.height(2000))
    flyer.preserve_aspect_ratio = true
    flyer.trigger = Transition.EndNavigation
    // print("flyer  y: " + flyer.y + "flyer  x " + flyer.x)
    flyer.y = pos.y(100,"bottom",flyer)
    flyer.x = pos.x(100,"left",flyer)
    flyer.rotation =  -22
}

     
local playtime = null 
if ( config["show_playtime"] != "No" )
{
    // Playtime   
    if ( config["show_playtime"] == "Yes" )
    {
        playtime = fe.add_text("Playtime: [PlayedTime]", pos.x(14),0, pos.width(800), pos.height(108))
    }
    else
    {
        playtime = fe.add_text("Playtime: [PlayedTime] [Name]", pos.x(14),0, pos.width(800), pos.height(108))
    }
    pos.set_font_height(25,playtime, "BottomLeft")
    playtime.y = scalepos.y(-20,"bottom",playtime)
    playtime.x = scalepos.x(20,"left",playtime)
    playtime.set_rgb(10,10,10)	
}

 // Nintendo Power
local nintendo_power = fe.add_image("nintendo_power1.png", scalepos.x(-40), scalepos.y(150), scalepos.width(1608), scalepos.height(2051))
nintendo_power.preserve_aspect_ratio = true
playtime.zorder = nintendo_power.zorder + 1


local pencil = fe.add_image("pencil.png", 0, scalepos.y(30), scalepos.width(588), scalepos.height(173))

    
local boxart = null
if ( config["show_boxart"] == "Yes" )
{
    // Boxart
    boxart = fe.add_artwork("boxart", scalepos.x(1120), scalepos.y(17), scalepos.width(698), scalepos.height(740))
    boxart.preserve_aspect_ratio = true
    boxart.trigger = Transition.EndNavigation
    boxart.rotation = 5.5 
    boxart.x = scalepos.x(10,"right", boxart)

    local ds = DropShadow( boxart, 40, scalepos.x(20), scalepos.y(20), 83 )
    boxart.zorder = boxart.zorder -1
}
// Missing Cartridge Underlay
local gb_underlay = fe.add_image("nogame.png", scalepos.x(509), scalepos.y(496), scalepos.width(565), scalepos.height(536))
gb_underlay.preserve_aspect_ratio = true

// Snap
local snap = fe.add_artwork("snap", scalepos.x(485), scalepos.y(557), scalepos.width(515), scalepos.height(460))
snap.preserve_aspect_ratio = true
snap.trigger = Transition.EndNavigation
snap.rotation = -7.6
snap.red = 181
snap.green = 169
snap.blue = 72 
snap.alpha=220


if (config["show_scanlines"] == "Yes" )
{
    // Scanlines
    local scanlines = fe.add_image("scanlines.png", scalepos.x(510), scalepos.y(557), scalepos.width(610), scalepos.height(460) )
    scanlines.preserve_aspect_ratio = true
    scanlines.rotation = -7.5
}

local wheel = null
if ( config["show_logos"] == "Yes" )
{
 	// wheel
	wheel = fe.add_artwork("wheel", scalepos.x(1440),scalepos.y(1080), scalepos.width(432), scalepos.height(216))
    wheel.x=pos.x(-75,"right", wheel)
    
    if (boxart != null){
        wheel.y=pos.y(100,"top",wheel, boxart,"bottom") 
    }
    else
    {
        wheel.y=pos.y(10,"bottom",wheel)        
    }
    wheel.preserve_aspect_ratio = true
	wheel.trigger = Transition.EndNavigation
    wheel.alpha=220
}

// Gameboy Overlay
local gb_overlay = fe.add_image("gb_foreground.png", scalepos.x(176), scalepos.y(123), scalepos.width(1309), scalepos.height(1835))
gb_overlay.preserve_aspect_ratio = true
