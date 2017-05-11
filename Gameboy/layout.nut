//
// Gameboy
// Theme by Mahuti
// vs. 1.0
//

class UserConfig {
	</ label="Enable Logos", help="If wheel images/logos aren't used, game titles will be shown instead.", order=1, options="show logos, show titles" />
	enable_logos="show logos";
 
}

local config = fe.get_config();

local flw = fe.layout.width;
local flh = fe.layout.height;

//Background
local bg = fe.add_image("gb_bg.jpg", 0, 0, flw, flh);


// Snap
local snap = fe.add_artwork("snap", flw*0.235, flh*0.960, flw*0.346, flh*0.405);
snap.trigger = Transition.EndNavigation;
snap.origin_x = flw*0.09375;
snap.origin_y = flh*0.4601;
snap.rotation = -7.9; 
snap.red = 181; 
snap.green = 169; 
snap.blue = 72; 

// Boxart
local flyer = fe.add_artwork("flyer", flw*1.09, flh*0.127, flw*0.51, flh*0.655);
flyer.preserve_aspect_ratio = false;
flyer.trigger = Transition.EndNavigation;
flyer.origin_x = flw*0.531;
flyer.origin_y = flh*0.0259;
flyer.rotation = 6.5; 


if ( config["enable_logos"] == "show logos" )
{
 	// wheel
	local wheel = fe.add_artwork("wheel", flw*0.68, flh*0.780, flw*0.3, flh*0.2);
	wheel.preserve_aspect_ratio = true;
	wheel.trigger = Transition.EndNavigation;
	wheel.zorder=100;
	
} /* else {
	// Title
	local title = fe.add_text("[Title]", flw*0, flh*0.92, flw*1, flh*0.1);
	title.align = Align.Right;
	title.charsize = 24;
	title.set_rgb(247, 35, 0);
	title.font = "Pretendo"; 
} */ 
 
 // Gameboy Overlay
 local gb_overlay = fe.add_image("gb_foreground.png", 0, 0, flw, flh);
 

// Playtime
local playtime = fe.add_text("Playtime : [PlayedTime]", flw*0.01, flh*0, flw*0.4, flh*0.1);
playtime.align = Align.Left;
playtime.charsize = 20;
playtime.set_rgb(255, 255, 255);




